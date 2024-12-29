# frozen_string_literal: true

class AlbumsController < ApplicationController
  before_action :authenticate_press_service!, except: %i[index show]
  before_action :set_album, only: %i[edit update show destroy]

  def index
    @pagy, @albums = pagy(Album.order(album_date: :desc), limit: 9)
  rescue Pagy::OverflowError
    redirect_to albums_url(page: 1)
  end

  def show
    @game_albums = GameAlbum.all
  end

  def new
    @album = Album.new
  end

  def edit; end

  def create
    @album = Album.new(album_params)
    if @album.save
      redirect_to album_url(@album), notice: t('notice.create.album')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    attachments = ActiveStorage::Attachment.where(id: params[:deleted_photo_ids])
    attachments.map(&:purge)

    if @album.update(album_params)
      redirect_to album_url(@album), notice: t('notice.update.album')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @album.destroy
    redirect_to albums_url, notice: t('notice.destroy.album')
  end

  private

  def set_album
    @album = Album.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to albums_url
  end

  def album_params
    params.require(:album).permit(:name, :album_date, photos: [])
  end
end
