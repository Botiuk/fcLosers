# frozen_string_literal: true

class TournamentsController < ApplicationController
  before_action :authenticate_press_service!, except: %i[cup championship]
  before_action :set_tournament, only: %i[edit update show]

  def index
    @pagy, @tournaments = pagy(Tournament.order(start_date: :desc, name: :asc), limit: 15)
  rescue Pagy::OverflowError
    redirect_to tournaments_url(page: 1)
  end

  def show
    @tournament_teams = TournamentTeam.includes(:team).where(tournament_id: @tournament.id).order_by_team
    @games = Game.includes(:home_team, :visitor_team).where(tournament_id: @tournament.id).order(:stage, :game_date)
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

  def cup
    @cup = Tournament.where(schema_type: 'national_cup').last
    if @cup.present?
      @cup_matches = Game.where(tournament_id: @cup.id).order(:stage, :game_date, :start_time)
    else
      redirect_to root_url
    end
  end

  def championship
    @championship = Tournament.where(schema_type: 'national_champ').last
    if @championship.present?
      @championship_matches = Game.where(tournament_id: @championship.id).order(:stage, :game_date, :start_time)
    else
      redirect_to root_url
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
