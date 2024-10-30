# frozen_string_literal: true

class CoachesController < ApplicationController
  before_action :authenticate_press_service!, except: %i[index show]
  before_action :set_coach, only: %i[edit update show destroy]

  def index
    if press_service_signed_in?
      @pagy, @coaches = pagy(Coach.coaches_ordered, limit: 20)
    elsif params[:team].present?
      @coaches = Coach.where(which_team: params[:team]).coaches_ordered
    else
      @coaches = Coach.where(which_team: 'first').coaches_ordered
    end
  rescue Pagy::OverflowError
    redirect_to coaches_url(page: 1)
  end

  def show; end

  def new
    @coach = Coach.new
  end

  def edit; end

  def create
    @coach = Coach.new(coach_params)
    if @coach.save
      redirect_to coach_url(@coach), notice: t('notice.create.coach')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @coach.update(coach_params)
      redirect_to coach_url(@coach), notice: t('notice.update.coach')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @coach.destroy
    redirect_to coaches_url, notice: t('notice.destroy.coach')
  end

  private

  def set_coach
    @coach = Coach.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to coaches_url
  end

  def coach_params
    params.require(:coach).permit(:name, :middle_name, :surname, :date_of_birth, :which_team, :position, :coach_photo,
                                  :coach_biography)
  end
end
