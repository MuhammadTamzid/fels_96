class WordSerializer < ActiveModel::Serializer
  attributes :id, :content, :category
  has_many :word_answers, serializer: WordAnswerSerializer

  def category
    object.category.name
  end
end
