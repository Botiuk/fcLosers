# frozen_string_literal: true

class GameVideosController < ApplicationController
  before_action :authenticate_press_service!
  before_action :set_game_video, only: :destroy
  before_action :my_formhelpers, only: %i[new create]

  def new
    if params[:game_id].present?
      @game_video = GameVideo.new(game_id: params[:game_id])
      @game = Game.find(params[:game_id])
    elsif params[:video_id].present?
      @game_video = GameVideo.new(video_id: params[:video_id])
      @video = Video.find(params[:video_id])
    else
      redirect_to videos_url
    end
  end

  def create
    @game_video = GameVideo.new(game_video_params)
    @game = Game.find(@game_video.game_id) if @game_video.game_id.present?
    @video = Video.find(@game_video.video_id) if @game_video.video_id.present?
    if @game_video.save
      game = Game.find(@game_video.game_id)
      redirect_to game_path(game), notice: t('notice.create.game_video')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    game = Game.find(@game_video.game_id)
    @game_video.destroy
    redirect_to game_url(game), notice: t('notice.destroy.game_video')
  end

  private

  def set_game_video
    @game_video = GameVideo.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to videos_url
  end

  def game_video_params
    params.require(:game_video).permit(:video_id, :game_id)
  end

  def my_formhelpers
    @games = Game.formhelper
    @videos = Video.formhelper
  end
end
