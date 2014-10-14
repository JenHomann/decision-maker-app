class RoundsController < ApplicationController
  # GET /rounds
  # GET /rounds.json
  def index
    @rounds = Round.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @rounds }
    end
  end

  # GET /rounds/1
  # GET /rounds/1.json
  def show
    @round = Round.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @round }
    end
  end

  # GET /rounds/new
  # GET /rounds/new.json
  def new
    @round = Round.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @round }
    end
  end

  # POST /rounds
  # POST /rounds.json
  def create
    @round = Round.new(params[:round])
    
    # yelp_array = Yelp -- (whatever it returns)
    # yelp_array.each do |yelp_data|
    #   Option.create(yelp_data)
    # end

    respond_to do |format|
      if @round.save
         @round.set_encrypted_url
        format.html { redirect_to new_contact_path, notice: 'Round was successfully created.' }
        format.json { render json: @round, status: :created, location: @round }
      else
        format.html { render action: "new" }
        format.json { render json: @round.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rounds/1
  # DELETE /rounds/1.json
  def destroy
    @round = Round.find(params[:id])
    @round.destroy

    respond_to do |format|
      format.html { redirect_to rounds_url }
      format.json { head :no_content }
    end
  end
  
  def confirmation
  end
  
  # def new_contact
  #   raise "#{params}"
  #   @contact = Contact.new
  #   @round = Round.find_by_encrypted_url(params[:encrypted_url])
  #
  #   respond_to do |format|
  #     format.html # new.html.erb
  #     format.json { render json: @contact }
  #   end
  # end
    
end
