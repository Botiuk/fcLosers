# frozen_string_literal: true

class VideosController < ApplicationController
  before_action :authenticate_press_service!, except: :index
  before_action :set_video, only: %i[edit update destroy]

  def index
    @pagy, @videos = pagy(Video.order(created_at: :desc, name: :desc), limit: 9)
  rescue Pagy::OverflowError
    redirect_to videos_url(page: 1)
  end

  def new
    @video = Video.new
  end

  def edit; end

  def create
    @video = Video.new(video_params)
    if @video.save
      redirect_to videos_url, notice: t('notice.create.video')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @video.update(video_params)
      redirect_to videos_url, notice: t('notice.update.video')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @video.destroy
    redirect_to videos_url, notice: t('notice.destroy.video')
  end

  private

  def set_video
    @video = Video.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to videos_url
  end

  def video_params
    params.require(:video).permit(:name, :youtube_id)
  end
end
