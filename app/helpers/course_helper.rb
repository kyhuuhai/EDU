module CourseHelper
  def load_link course
    if course.newest_schedule
      course_schedule_path course.newest_schedule
    else
      course_path course
    end
  end

  def load_register_time schedule
    if schedule.present? && schedule.is_opening?
      l(schedule.start_date, format: :day_month_year) + " - " +
      l(schedule.end_date, format: :day_month_year)
    else
      t "courses.index.coming_soon"
    end
  end

  def load_schedule_time day, start_time, end_time
    t("day_of_week.#{CourseSchedule::DAY_OF_WEEK[day]}") + ": " +
    l(start_time, format: :hour_minute) + " - " +
    l(end_time, format: :hour_minute)
  end

  def set_class_active course_schedule, schedule
    "schedule-active" if course_schedule && (course_schedule == schedule)
  end

  def appear_cost cost
    content_tag :p, class: "price" do
      concat number_to_currency cost, precision: 0, delimiter: ".", format: "%n "
      concat content_tag :span, Settings.courses.money_unit, class: "currency"
    end
  end
end
