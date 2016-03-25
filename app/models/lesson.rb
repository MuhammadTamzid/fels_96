class Lesson < ActiveRecord::Base
  include PublicActivity::Common
  belongs_to :user
  belongs_to :category
  has_many :lesson_words

  validate :dates_check, :on :update

  before_create :init_words
  #before_update :dates_check
  before_update :total_result

  accepts_nested_attributes_for :lesson_words

  scope :search_by_category, ->category_id {where category_id: category_id}
  scope :search_by_user, ->user_id {where user_id: user_id}
  scope :in_last_month, ->{
    where("created_at BETWEEN ? AND ? ",
      1.month.ago.beginning_of_month.strftime("%Y-%m-%d"),
      1.month.ago.end_of_month.strftime("%Y-%m-%d"))
  }

  private
  def init_words
    @words = self.category.words.not_learn(self.user.id).sample 10
    @words.each do |word|
      self.lesson_words.build word_id: word.id
    end
  end

  def total_result
    self.lesson_result = total_correct_answer
  end

  def total_correct_answer
    lesson_words.select{|lesson_word| lesson_word.word_answer.correct? unless
      lesson_word.word_answer.nil?}.count
  end

  def dates_check
    if self.lesson_words.map {|attribute| attribute[:word_answer_id].blank?}
      errors.add(:password, "cannot be blank")
    end
  end
end

#map{|attribute| attribute[:word_answer_id].blank?}
