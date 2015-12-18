class Api::V1::WordsController < ApplicationController
  load_and_authorize_resource

  def index
    render(
      json: ActiveModel::ArraySerializer.new(
        Word.all,
        each_serializer: WordSerializer,
        root: "words"
      )
    )

    # render json: Word.all, serializer: ActiveModel::ArraySerializer, each_serializer: WordSerializer
    # render json: Word.all, each_serializer: WordSerializer
  end

  def show
    render json: WordSerializer.new(@word)

    # render json: @word, serializer: WordSerializer
  end
end
