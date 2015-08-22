class GiftsController < ApplicationController
  before_action :set_gift, only: [:show, :edit, :update, :destroy]


  def index
    @gifts = Gift.all

    user_ids = UserGift.all.pluck(:user_id)
    @users = User.where.not(id: user_ids)
  end


  def reset
    @gift = Gift.find params[:id]

    @gift.users.clear

    redirect_to gifts_url
  end

  def luck
    @gift = Gift.find params[:id]

    if @gift.name == '杯子'
      user_ids = UserGift.includes(:gift).where(gifts: {name: ['杯子']}).pluck(:user_id)
      @users = User.where.not(id: user_ids).where(role: 'student')
    else
      user_ids = UserGift.includes(:gift).where.not(gifts: {name: ['杯子']}).pluck(:user_id)
      @users = User.where.not(id: user_ids)
    end

    if @gift.amount > @gift.users.count
      @gift.users << @users.sample
    else
      flash[:error] = "奖品不够咯"
    end

    redirect_to gifts_path
  end

  # GET /gifts/new
  def new
    @gift = Gift.new
  end

  # GET /gifts/1/edit
  def edit
  end

  # POST /gifts
  # POST /gifts.json
  def create
    @gift = Gift.new(gift_params)

    respond_to do |format|
      if @gift.save
        format.html { redirect_to gifts_url, notice: 'Gift was successfully created.' }
        format.json { render :show, status: :created, location: @gift }
      else
        format.html { render :new }
        format.json { render json: @gift.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /gifts/1
  # PATCH/PUT /gifts/1.json
  def update
    respond_to do |format|
      if @gift.update(gift_params)
        format.html { redirect_to gifts_url, notice: 'Gift was successfully updated.' }
        format.json { render :show, status: :ok, location: @gift }
      else
        format.html { render :edit }
        format.json { render json: @gift.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gifts/1
  # DELETE /gifts/1.json
  def destroy
    @gift.destroy
    respond_to do |format|
      format.html { redirect_to gifts_url, notice: 'Gift was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gift
      @gift = Gift.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gift_params
      params[:gift].permit(:grade, :name, :amount)
    end
end
