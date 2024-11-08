# frozen_string_literal: true

class TournamentsController < ApplicationController
  before_action :authenticate_press_service!
  before_action :set_tournament, only: %i[edit update show]

  def index
    @pagy, @tournaments = pagy(Tournament.order(start_date: :desc, name: :asc), limit: 15)
  rescue Pagy::OverflowError
    redirect_to tournaments_url(page: 1)
  end

  def show
    @tournament_teams = TournamentTeam.includes(:team).where(tournament_id: @tournament.id).order_by_team
  end

  def new
    @tournament = Tournament.new
  end

  def edit; end

  def create
    @tournament = Tournament.new(tournament_params)
    if @tournament.save
      redirect_to tournament_url(@tournament), notice: t('notice.create.tournament')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @tournament.update(tournament_params)
      redirect_to tournament_url(@tournament), notice: t('notice.update.tournament')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_tournament
    @tournament = Tournament.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to tournaments_url
  end

  def tournament_params
    params.require(:tournament).permit(:name, :schema_type, :start_date, :end_date)
  end
end
