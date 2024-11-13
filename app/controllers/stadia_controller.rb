# frozen_string_literal: true

class StadiaController < ApplicationController
  before_action :authenticate_press_service!
  before_action :set_stadium, only: %i[edit update]

  def index
    @pagy, @stadia = pagy(Stadium.order(:location_name, :stadium_name), limit: 15)
  rescue Pagy::OverflowError
    redirect_to stadia_url(page: 1)
  end

  def new
    @stadium = Stadium.new
  end

  def edit; end

  def create
    @stadium = Stadium.new(stadium_params)
    if @stadium.save
      redirect_to stadia_url, notice: t('notice.create.stadium')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @stadium.update(stadium_params)
      redirect_to stadia_url, notice: t('notice.update.stadium')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_stadium
    @stadium = Stadium.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to stadia_url
  end

  def stadium_params
    params.require(:stadium).permit(:country, :region, :district, :loctype, :location_name, :address, :stadium_name)
  end
end
