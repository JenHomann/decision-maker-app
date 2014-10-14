class ContactsController < ApplicationController
  
  # GET /contacts/new
  # GET /contacts/new.json
  def new
    @contact = Contact.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @contact }
    end
  end

  # POST /initial_contact
  def initial
    @contact = Contact.new(params[:contact])
    
    if @contact.save
      redirect_to start_path, :notice => "Email has been successfully saved."
    else
      render "home"
    end
  end

  # POST /contacts
  # POST /contacts.json
  def create
    raise "#{params}"
    @contact = Contact.new(params[:contact])
    @round = Round.find_by_encrypted_url(params[:encrypted_url])
    
    respond_to do |format|
      if @contact.save
        @contact.set_encrypted_id
        @round.contact << @contact
        ContactMailer.send_vote(@contact).deliver
        format.html { redirect_to @contact, notice: 'Contact was successfully created.' }
        format.json { render json: @contact, status: :created, location: @contact }
      else
        format.html { render action: "new" }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy

    respond_to do |format|
      format.html { redirect_to contacts_url }
      format.json { head :no_content }
    end
  end
end
