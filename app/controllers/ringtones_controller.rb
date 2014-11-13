class RingtonesController < ApplicationController
  def index
    @ringtones = Ringtone.where(processing: false)
  end

  def show
    @ringtone = Ringtone.find(params[:id])
  end

  def new
    @ringtone = Ringtone.new
  end

  def create
    @ringtone = Ringtone.new(ringtone_params)

    if @ringtone.save
      redirect_to @ringtone
    else
      render :new
    end
  end

  private

  def ringtone_params
    params.require(:ringtone).permit(:source, :song, :artist, :start_time, :length)
  end
end
