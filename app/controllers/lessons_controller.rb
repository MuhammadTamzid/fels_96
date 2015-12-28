class LessonsController < ApplicationController
  load_and_authorize_resource

  def index
    @lessons = current_user.lessons.order("created_at DESC").decorate
  end

  def create
    @lesson.user = current_user
    if @lesson.save
      flash[:success] = t "lesson_started"
      LessonActivity.new(@lesson).create
      redirect_to edit_lesson_path @lesson
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @lesson.update_attributes lesson_params
      flash[:success] = t "lesson_submitted"
      LessonActivity.new(@lesson).update
      redirect_to lesson_path @lesson
    else
      render :edit
    end
  end

  def show
    @lesson = Lesson.find(params[:id]).decorate
  end

  private
  def lesson_params
    params.require(:lesson).permit :category_id, :user_id,
      lesson_words_attributes: [:id, :word_id, :word_answer_id]
  end

  def load_lesson
    @lesson = Lesson.find params[:id]
  end
end
