class HomeTabs < ViewObject
  def html
    safe_join tabs
  end

  private

  def tabs
    [home_tab,
    courses_tab,
    schedule_tab,
    contacts_tab].compact
  end

  def home_tab
    build_tab t("layouts.header.home"),
      root_path, :home
  end

  def about_tab
    build_tab t("layouts.header.about"),
      root_path, :about
  end

  def courses_tab
    build_tab t("layouts.header.courses"),
      courses_path, :courses
  end

  def schedule_tab
    build_tab t("layouts.header.schedule"),
      course_schedules_path, :course_schedules
  end

  def news_tab
    build_tab t("layouts.header.news"),
      news_index_path, :news
  end

  def contacts_tab
    build_tab t("layouts.header.contact"),
      new_feedback_path, :feedbacks
  end

  def build_tab text, path, tab_name
    content_tag :li, class: tab_class(tab_name) do
      link_to text, path
    end
  end

  def tab_class tab
    active_class = active?(tab) ? "active" : ""
    [active_class].compact.join(" ")
  end

  def active? tab
    return true if tab.to_s == context.controller_name
    false
  end
end
