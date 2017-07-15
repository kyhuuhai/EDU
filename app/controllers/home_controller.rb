class HomeController < ApplicationController
  def index
    @courses = Course.newest.limit Settings.home.courses_limit
    @trainers = User.trainers.includes(:image).limit Settings.home.trainers_limit
    @course = Course.find_by on_slider_index: true
  end
end
