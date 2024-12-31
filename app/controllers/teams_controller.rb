# frozen_string_literal: true

class TeamsController < ApplicationController
  before_action :authenticate_press_service!
  before_action :set_our_teams_ids, only: :index
  before_action :set_team, only: %i[edit update]

  def index
    @pagy, @teams = pagy(Team.order(:name, :represent), limit: 20)
  rescue Pagy::OverflowError
    redirect_to teams_url(page: 1)
  end

  def new
    @team = Team.new
  end

  def edit; end

  def create
    @team = Team.new(team_params)
    if @team.save
      redirect_to teams_url, notice: t('notice.create.team')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @team.update(team_params)
      redirect_to teams_url, notice: t('notice.update.team')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_team
    @team = Team.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to teams_url
  end

  def team_params
    params.require(:team).permit(:team_type, :name, :represent, :team_logo)
  end
end
