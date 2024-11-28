# frozen_string_literal: true

class TournamentTeamsController < ApplicationController
  before_action :authenticate_press_service!
  before_action :set_tournament_team, only: :destroy
  before_action :team_formhelper, only: %i[new create]

  def new
    if params[:tournament_id].present?
      @tournament = Tournament.find(params[:tournament_id])
      @tournament_team = TournamentTeam.new(tournament_id: params[:tournament_id])
    else
      redirect_to tournaments_url
    end
  end

  def create
    @tournament_team = TournamentTeam.new(tournament_team_params)
    @tournament = Tournament.find(@tournament_team.tournament_id)
    if @tournament_team.save
      redirect_to tournament_url(@tournament), notice: t('notice.create.tournament_team')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    tournament = Tournament.find(@tournament_team.tournament_id)
    @tournament_team.destroy
    redirect_to tournament_url(tournament), notice: t('notice.destroy.tournament_team')
  end

  private

  def set_tournament_team
    @tournament_team = TournamentTeam.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to tournaments_url
  end

  def tournament_team_params
    params.require(:tournament_team).permit(:tournament_id, :team_id)
  end

  def team_formhelper
    @teams = Team.formhelper
  end
end
