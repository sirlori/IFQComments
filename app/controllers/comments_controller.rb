class CommentsController < ApplicationController
  include CommentsHelper
  skip_before_action :verify_authenticity_token, only: [:get_comments]

  # GET /comments
  # GET /comments.json
  def index
  end

# prendi url
# metodo che estrae id(con mechanize)
# metodo che avendo l'id prende i commenti
# metodo effettua il parsing dei commenti con una struttura ben definita

  def get_comments
    url = params[:ifq_url]
    
    comments_id = get_comments_id(url)    
    unparsed_comments = get_unparsed_comments(comments_id)
    comments = parse_comments(unparsed_comments)
    respond_to do |format|
      format.json {render json: {comments: comments}}
    end
  end

end
