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
    @games = Game.includes(:home_team, :visitor_team).where(tournament_id: @tournament.id).order(:game_date, :stage)
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
    @cup = Tournament.where(schema_type: 'national_cup').order(start_date: :desc).first
    if @cup.present?
      cup_stages =  ['Фінал', '1/2', '1/4', '1/8', '1/16', '1/32', '1/64', 'Попередній етап']
      @cup_matches = Game.where(tournament_id: @cup.id).in_order_of(:stage, cup_stages)
    else
      redirect_to root_url
    end
  end

  def championship
    @championship = if params[:schema_type].present?
                      Tournament.where(schema_type: params[:schema_type]).order(start_date: :desc).first
                    else
                      Tournament.where(schema_type: 'national_champ').order(start_date: :desc).first
                    end
    if @championship.present?
      @championship_matches = Game.where(tournament_id: @championship.id).order('stage::integer')
      championship_teams_ids = TournamentTeam.where(tournament_id: @championship.id).pluck(:team_id)
      @championship_teams = Team.where(id: championship_teams_ids)
      tournament_table
    else
      redirect_to root_url
    end
  end

  private

  def tournament_table
    @tournament_table_records = []
    @championship_teams.each do |team|
      t_played = 0
      t_win = 0
      t_draw = 0
      t_lose = 0
      t_scored = 0
      t_missed = 0
      t_points = 0
      @championship_matches.each do |game|
        next unless game.home_goal.present? && game.visitor_goal.present?

        if team.id == game.home_team_id
          t_played += 1
          if game.home_goal > game.visitor_goal
            t_win += 1
            t_points += 3
          elsif game.home_goal == game.visitor_goal
            t_draw += 1
            t_points += 1
          else
            t_lose += 1
          end
          t_scored += game.home_goal
          t_missed += game.visitor_goal
        end

        next unless team.id == game.visitor_team_id

        t_played += 1
        if game.visitor_goal > game.home_goal
          t_win += 1
          t_points += 3
        elsif game.visitor_goal == game.home_goal
          t_draw += 1
          t_points += 1
        else
          t_lose += 1
        end
        t_scored += game.visitor_goal
        t_missed += game.home_goal
      end
      @tournament_table_records << { team_id: team.id, played: t_played, win: t_win, draw: t_draw, lose: t_lose,
                                     scored: t_scored, mised: t_missed, points: t_points }
    end
    @tournament_table_records.sort_by! { |record| [record[:points], record[:win], record[:draw], record[:played]] }
    @tournament_table_records.reverse!
  end

  def set_tournament
    @tournament = Tournament.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to tournaments_url
  end

  def tournament_params
    params.require(:tournament).permit(:name, :schema_type, :start_date, :end_date)
  end
end
