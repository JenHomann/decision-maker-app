class PagesController < ApplicationController

  #get
  # Initial user inputs contact information
  def home
    @contact = Contact.new
  end
  
  #post
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
  def start
    @round = Round.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @round }
    end
  end
  
  #post
  def new_round
    @round = Round.new(params[:round])
    @round.set_encrypted_url

    respond_to do |format|
      if @round.save
         @option = Option.create(name: "Option A")
         @option.round = @round
        format.html { redirect_to new_contacts_path(@round.encrypted_url), notice: 'Round was successfully created.' }
        format.json { render json: @round, status: :created, location: @round }
      else
        format.html { render action: "start" }
        format.json { render json: @round.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # #post
  # def set_options
  #   @option = Option.create(name: "Option A")
  #   @option.round = Round.find_by_encrypted_url(params[:encrypted_url])
  #
  #   render new_contacts_path(@option.round.encrypted_url)
  #   # yelp_array = Yelp -- (whatever it returns)
  #   # yelp_array.each do |yelp_data|
  #   #   Option.create(yelp_data)
  #   # end
  # end

  #get
  def new_contacts
    @round = Round.find_by_encrypted_url(params[:encrypted_url])
    @contact = Contact.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @contact }
    end
  end
  
  #post
  def create_contacts
    @contact = Contact.new(params[:contact])
    @round = Round.find_by_encrypted_url(params[:encrypted_url])
    @contact.set_encrypted_id
    @round.contacts << @contact
    @initial_contact_id = session[:initial_contact_id]
  
    respond_to do |format|
      if @contact.save
        ContactMailer.send_vote(@contact).deliver
        format.html { redirect_to vote_path(@initial_contact_id), notice: 'Contact was successfully created.' }
        format.json { render json: @contact, status: :created, location: @contact }
      else
        format.html { render action: new_contact_path(@round.encrypted_url) }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  #get
  def vote
    @vote = Vote.new
    @contact = Contact.find_by_encrypted_id(params[:encrypted_id])
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @vote }
    end
  end

  def create_vote
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
  end
  
  def show_round
  end
  
end