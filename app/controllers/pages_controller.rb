class PagesController < ApplicationController

  #get
  # Initial user inputs contact information
  def home
    @contact = Contact.new
  end
  
  #post
  # initiates and saves initial contact object
  def initial_contact
    @contact = Contact.new(params[:contact])
    
    if @contact.save
      session[:initial_contact_id] = @contact.encrypted_id
      redirect_to start_path, :notice => "Email has been successfully saved."
    else
      render "home"
    end
  end
  
  #get
  # initial contact inputs search data
  def start
    @round = Round.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @round }
    end
  end
  
  #post
  # search data is stored in a new instance of a round Object
  # Options are returned from Yelp using params[:round]
  def new_round
    @round = Round.new(params[:round])
    @round.set_encrypted_url
    
    respond_to do |format|
      if @round.save
        
        # options generated for the round
        Option.create_options(params[:round][:location], params[:round][:restaurant_type], @round.id)
        # @options = Option.where(round_id: @round.id)
        
        format.html { redirect_to new_contacts_path(@round.encrypted_url), notice: 'Round was successfully created.' }
        format.json { render json: @round, status: :created, location: @round }
      else
        format.html { render action: "start" }
        format.json { render json: @round.errors, status: :unprocessable_entity }
      end
    end
  end

  #get
  # initial Contact inputs other contact info
  def new_contacts
    @round = Round.find_by_encrypted_url(params[:encrypted_url])
    @round.contacts.build
    
    respond_to do |format|
      format.html # new.html.erb
      format.js
    end
  end
  
  #post
  # additional contact objects are created, encrypted_ids are set, they are assigned to a round and an email is sent to them to go vote
  def create_contacts
    @round = Round.find_by_encrypted_url(params[:encrypted_url])

    respond_to do |format|
      if @round.update_attributes(params[:round])
        
        @options = @round.options
        @round.contacts.each do |c|
          @options.each do |o|
            Vote.create!(option_id: o.id, contact_id: c.id)
          end
          ContactMailer.send_vote(c).deliver
        end

        @initial_contact = Contact.find_by_encrypted_id(session[:initial_contact_id])
        @round.contacts << @initial_contact
        @options.each do |o|
          Vote.create!(option_id: o.id, contact_id: @initial_contact.id)
        end
        
        ContactMailer.confirm(@initial_contact).deliver
        
        format.html { redirect_to vote_path(@initial_contact.encrypted_id), notice: 'Contact was successfully created.' }
        format.json { render json: @round, status: :created, location: @round }
      else
        format.html { render action: new_contact_path(@round.encrypted_url) }
        format.json { render json: @round.errors, status: :unprocessable_entity }
      end
    end
  end

  # get
  # displays all of the option data, as well as checkboxes for voting (for now - hope to add jquerymobile soon enough)
  def vote
    @contact = Contact.find_by_encrypted_id(params[:encrypted_id])
    @round = @contact.round
    @options = @round.options
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @vote }
    end
  end

  # post
  def create_vote
    @contact = Contact.find_by_encrypted_id(params[:encrypted_id])
    # @contact.update_attributes(params[:contact], :voted => true)
    
    @votes = params[:contact][:votes_attributes]
    @votes.each do |v|
      vote = Vote.find_by_id(v[1][:id])
      vote.update_attributes(:response => v[1][:response])
      vote.save
      vote.assign_points
    end
    
    @contact.update_attributes(:voted => true)
    
    respond_to do |format|
      # if @vote.save
        format.html { redirect_to confirm_path(@contact.round.encrypted_url), notice: 'Votes were successfully saved.' }
        format.json { render json: @vote, status: :created, location: @vote }
      # else
      #   format.html { render action: vote_path(@contact.encrypted_id) }
      #   format.json { render json: @vote.errors, status: :unprocessable_entity }
      # end
    end
  end
  
  # get
  def confirm
    @round = Round.find_by_encrypted_url(params[:encrypted_url])
    @contacts = @round.contacts
    voted_contacts = []
    @contacts.each do |c|
      if c.voted == true
        voted_contacts << c
      end
    end
    
    if voted_contacts.length == @contacts.length
      @options = @round.options
      @options.each do |o|
        o.update_attributes(:score => Vote.tally_score(o.id))
        o.save
      end
      # determine a winner
      high_score = 0
      @options.each do |option|
        if option.score > high_score
          high_score = option.score
          @decision = option
        end
      end
      @round.update_attributes(:decision => @decision.name, :decision_url => @decision.url)
      @round.save
      # send confirmation email
      @round.contacts.each do |contact|
        ContactMailer.decision(contact, @decision).deliver
      end
      redirect_to decision_path(@round.encrypted_url), :notice => "A decision has been made!"
    else
      redirect_to no_decision_path, :alert => "No decision yet. We'll send you an email when a decision is made."
    end
    
  end
  
  def decision
    @round = Round.find_by_encrypted_url(params[:encrypted_url])
    
    @round.contacts.each do |c|
      c.votes.destroy
      c.destroy
    end

    @round.options.each do |o|
      o.destroy
    end
    
  end
  
  def no_decision
  end
  
end