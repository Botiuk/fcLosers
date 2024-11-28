# frozen_string_literal: true

class GamesController < ApplicationController
  before_action :authenticate_press_service!, except: :show
  before_action :set_game, only: %i[edit update show destroy]
  before_action :stadium_formhelper, only: %i[new create edit update]

  def show; end

  def new
    if params[:tournament_id].present?
      @tournament = Tournament.find(params[:tournament_id])
      @game = Game.new(tournament_id: params[:tournament_id])
      @teams = Team.tournament_teams_formhelper(params[:tournament_id])
    else
      redirect_to tournaments_url
    end
  end

  def edit
    @teams = Team.tournament_teams_formhelper(@game.tournament_id)
    @tournament = Tournament.find(@game.tournament_id)
  end

  def create
    @game = Game.new(game_params)
    @teams = Team.tournament_teams_formhelper(@game.tournament_id)
    @tournament = Tournament.find(@game.tournament_id)
    if @game.save
      redirect_to game_url(@game), notice: t('notice.create.game')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @teams = Team.tournament_teams_formhelper(@game.tournament_id)
    @tournament = Tournament.find(@game.tournament_id)
    if @game.update(game_params)
      redirect_to game_url(@game), notice: t('notice.update.game')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    tournament = Tournament.find(@game.tournament_id)
    @game.destroy
    redirect_to tournament_url(tournament), notice: t('notice.destroy.game')
  end

  private

  def set_game
    @game = Game.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to games_url
  end

  def game_params
    params.require(:game).permit(:tournament_id, :game_type, :stage, :stadium_id, :game_date, :start_time,
                                 :home_team_id, :home_goal, :visitor_team_id, :visitor_goal, :game_protocol)
  end

  def stadium_formhelper
    @stadia = Stadium.formhelper
  end
end
