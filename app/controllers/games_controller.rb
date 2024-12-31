# frozen_string_literal: true

class GamesController < ApplicationController
  before_action :authenticate_press_service!, except: %i[show calendar archive archive_search]
  before_action :set_our_teams_ids, only: %i[show archive archive_search]
  before_action :set_game, only: %i[edit update show destroy]
  before_action :stadium_formhelper, only: %i[new create edit update]

  def show
    video_ids = GameVideo.where(game_id: @game.id).pluck(:video_id)
    @videos = Video.where(id: video_ids)
    @game_videos = GameVideo.where(video_id: video_ids)
    album_ids = GameAlbum.where(game_id: @game.id).pluck(:album_id)
    @albums = Album.where(id: album_ids)
    @game_albums = GameAlbum.where(album_id: album_ids)
  end

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

  def calendar
    if params[:team].present?
      @team_id = 1 if params[:team] == 'first'
      @team_id = 2 if params[:team] == 'second'
      @team_id = 3 if params[:team] == 'u19'
    else
      @team_id = 1
    end
    calendar_for_team(@team_id)
  end

  def archive
    @pagy, @games = pagy(
      Game.includes(:home_team, :visitor_team).where(home_team_id: @our_ids, game_date: ...Time.zone.today)
          .or(Game.includes(:home_team, :visitor_team).where(visitor_team_id: @our_ids, game_date: ...Time.zone.today))
          .order(game_date: :desc), limit: 20
    )
  rescue Pagy::OverflowError
    redirect_to games_archive_url(page: 1)
  end

  def archive_search
    if params[:rival_name].blank?
      redirect_to games_archive_url, alert: t('alert.game.archive_search')
    else
      rival_ids = Team.where('lower(name) LIKE ?', "%#{params[:rival_name].downcase}%").ids
      @pagy, @games = pagy(
        Game.includes(:home_team, :visitor_team).where(game_date: ...Time.zone.today)
                                                .where(home_team_id: @our_ids, visitor_team_id: rival_ids)
            .or(Game.includes(:home_team, :visitor_team).where(game_date: ...Time.zone.today)
                                                        .where(home_team_id: rival_ids, visitor_team_id: @our_ids))
            .order(game_date: :desc), limit: 20
      )
      @search_params = params[:rival_name]
    end
  rescue Pagy::OverflowError
    redirect_to games_archive_url(page: 1)
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

  def calendar_for_team(team_id)
    @games = Game.includes(:home_team, :visitor_team).where(home_team_id: team_id).where('game_date > ?', 1.year.ago)
                 .or(Game.includes(:home_team, :visitor_team).where(visitor_team_id: team_id)
                         .where('game_date > ?', 1.year.ago))
                 .order(:game_date)
  end
end
