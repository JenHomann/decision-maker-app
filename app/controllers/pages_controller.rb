class PagesController < ApplicationController

  #get
  # Initial user inputs contact information
  def home
    @contact = Contact.new
  end
  
  #post
  # initiates initial contact object
  def initial_contact
    @contact = Contact.new(params[:contact])
    @contact.set_encrypted_id
    session[:initial_contact_id] = @contact.encrypted_id
    
    if @contact.save
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
        @contact = Contact.find_by_encrypted_id(session[:initial_contact_id])
        @round.contacts << @contact
        Option.create_options(params[:round][:location], params[:round][:restaurant_type], @round.id)
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
    @contact = Contact.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @contact }
    end
  end
  
  #post
  # additional contact objects are created, encrypted_ids are set, they are assigned to a round and an email is sent to them to go vote
  def create_contacts
    @contact = Contact.new(params[:contact])
    @round = Round.find_by_encrypted_url(params[:encrypted_url])
    @contact.set_encrypted_id
    @round.contacts << @contact
    
    @options = @round.options
    @options.each do |o|
      Vote.create(option_id: o.id, contact_id: @contact.id)
    end
    
    @initial_contact_id = session[:initial_contact_id]
    @initial_contact = Contact.find_by_encrypted_id(@initial_contact_id)
    @options.each do |o|
      Vote.create(option_id: o.id, contact_id: @initial_contact_id)
    end

    respond_to do |format|
      if @contact.save
        ContactMailer.send_vote(@contact).deliver
        ContactMailer.confirm(@initial_contact).deliver
        format.html { redirect_to vote_path(@initial_contact_id), notice: 'Contact was successfully created.' }
        format.json { render json: @contact, status: :created, location: @contact }
      else
        format.html { render action: new_contact_path(@round.encrypted_url) }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # get
  # displays all of the option data, as well as checkboxes for voting (for now - hope to add jquerymobile soon enough)
  def vote
    @vote = Vote.new
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
    binding.pry
    @vote = Vote.new(params[:vote])
    @contact = Contact.find_by_encrypted_id(params[:encrypted_id])
    
    respond_to do |format|
      if @vote.save
        @vote.contact = @contact
        format.html { redirect_to confirm_path(@contact.round.encrypted_url), notice: 'Vote was successfully created.' }
        format.json { render json: @vote, status: :created, location: @vote }
      else
        format.html { render action: vote_path(@contact.encrypted_id) }
        format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
    end
  end
  
  #get
  def confirm
    @round = Round.find_by_encrypted_url(params[:encrypted_url])
    @round.contacts.each do |contact|
      ContactMailer.decision(contact).deliver
    end
  end
  
  def show_round
  end
  
end