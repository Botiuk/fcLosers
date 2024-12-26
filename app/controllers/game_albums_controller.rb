# frozen_string_literal: true

class GameAlbumsController < ApplicationController
  before_action :authenticate_press_service!
  before_action :set_game_album, only: :destroy
  before_action :my_formhelpers, only: %i[new create]

  def new
    if params[:game_id].present?
      @game_album = GameAlbum.new(game_id: params[:game_id])
      @game = Game.find(params[:game_id])
    elsif params[:album_id].present?
      @game_album = GameAlbum.new(album_id: params[:album_id])
      @album = Album.find(params[:album_id])
    else
      redirect_to albums_url
    end
  end

  def create
    @game_album = GameAlbum.new(game_album_params)
    @game = Game.find(@game_album.game_id) if @game_album.game_id.present?
    @album = Album.find(@game_album.album_id) if @game_album.album_id.present?
    if @game_album.save
      game = Game.find(@game_album.game_id)
      redirect_to game_path(game), notice: t('notice.create.game_album')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    game = Game.find(@game_album.game_id)
    @game_album.destroy
    redirect_to game_url(game), notice: t('notice.destroy.game_album')
  end

  private

  def set_game_album
    @game_album = GameAlbum.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to albums_url
  end

  def game_album_params
    params.require(:game_album).permit(:album_id, :game_id)
  end

  def my_formhelpers
    @games = Game.formhelper
    @albums = Album.formhelper
  end
end
