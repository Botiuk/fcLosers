# frozen_string_literal: true

class PlayersController < ApplicationController
  before_action :authenticate_press_service!, except: :show
  before_action :set_player, only: %i[edit update show destroy]

  def index
    @pagy, @players = pagy(Player.players_ordered, limit: 20)
  rescue Pagy::OverflowError
    redirect_to players_url(page: 1)
  end

  def show; end

  def new
    @player = Player.new
  end

  def edit; end

  def create
    @player = Player.new(player_params)
    if @player.save
      redirect_to player_url(@player), notice: t('notice.create.player')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @player.update(player_params)
      redirect_to player_url(@player), notice: t('notice.update.player')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @player.destroy
    redirect_to players_url, notice: t('notice.destroy.player')
  end

  private

  def set_player
    @player = Player.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to players_url
  end

  def player_params
    params.require(:player).permit(:name, :surname, :date_of_birth, :which_team, :position, :player_number, :height,
                                   :weight, :leg, :player_photo, :player_biography)
  end
end
