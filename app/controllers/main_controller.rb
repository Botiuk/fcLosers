# frozen_string_literal: true

class MainController < ApplicationController
  def index
    @articles = Article.where.not(published_at: nil)
                       .where.not('published_at > ?', DateTime.now)
                       .with_rich_text_content.articles_ordered.first(5)
  end

  def our_team
    if params[:team].present?
      team_players(params[:team])
      @coaches = Coach.where(which_team: params[:team]).coaches_ordered
    else
      team_players('first')
      @coaches = Coach.where(which_team: 'first').coaches_ordered
    end
  end

  private

  def team_players(team)
    @goalkeepers = Player.team_players_with_position(team, 'goalkeeper')
    @defenders = Player.team_players_with_position(team, 'defender')
    @midfielders = Player.team_players_with_position(team, 'midfielder')
    @forwards = Player.team_players_with_position(team, 'forward')
  end
end
