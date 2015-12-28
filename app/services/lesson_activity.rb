class LessonActivity
  def initialize lesson
    @lesson = lesson
  end

  def create
    @lesson.create_activity :create, owner: @lesson.user
  end

  def update
    @lesson.create_activity :update, owner: @lesson.user
  end
end
