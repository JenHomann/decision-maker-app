class PagesController < ApplicationController

  # Initial user inputs contact information
  def home
    @contact = Contact.new
  end
  
  def initial_contact
    @contact = Contact.new(params[:contact])
    
    if @contact.save
      redirect_to start_path, :notice => "Email has been successfully saved."
    else
      render "home"
    end
  end
  
  def start
    @round = Round.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @round }
    end
  end
  
  def new_round
    @round = Round.new(params[:round])

    respond_to do |format|
      if @round.save
         @round.set_encrypted_url
        format.html { redirect_to set_options_path(@round.encrypted_url), notice: 'Round was successfully created.' }
        format.json { render json: @round, status: :created, location: @round }
      else
        format.html { render action: "start" }
        format.json { render json: @round.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def set_options
    @option = Option.create(name: "Option A")
    @option.round = Round.find_by_encrypted_url(params[:encrypted_url])

    # yelp_array = Yelp -- (whatever it returns)
    # yelp_array.each do |yelp_data|
    #   Option.create(yelp_data)
    # end
  end

  def new_contacts
    @contact = Contact.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @contact }
    end
  end
  
  def create_contacts
    @contact = Contact.new(params[:contact])
    @round = Round.find_by_encrypted_url(params[:encrypted_url])
  
    respond_to do |format|
      if @contact.save
        @contact.set_encrypted_id
        @contact.round = @round
        ContactMailer.send_vote(@contact).deliver
        format.html { redirect_to vote_path(@contact.encrypted_id), notice: 'Contact was successfully created.' }
        format.json { render json: @contact, status: :created, location: @contact }
      else
        format.html { render action: new_contact_path(@round.encrypted_url) }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

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
  
  def confirm
    @round = Round.find_by_encrypted_url(params[:encrypted_url])
  end
  
  def show_round
  end
  
end