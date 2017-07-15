class CoursesController < ApplicationController
  before_action :load_course, only: :show
  before_action :popular_courses

  def index
    @courses = load_by_search_word || load_course_default

    respond_to do |format|
      format.html
      format.js
    end
  end

  def show; end

  private

  def load_course
    @course = Course.includes(:images).find_by id: params[:id]
    return if @course
    flash[:error] = t ".not_found"
    redirect_to courses_path
  end

  def load_course_default
    Kaminari.paginate_array(Course.newest.to_a).page(params[:page])
      .per Settings.courses.per_page
  end

  def load_by_search_word
    Course.by_words(params[:words]).page(params[:page])
      .per Settings.courses.per_page if params[:words]
  end
end
