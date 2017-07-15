class Course < ApplicationRecord
  has_many :images, as: :imageable, dependent: :destroy
  has_many :course_schedules, dependent: :destroy
  has_many :registrations, through: :course_schedules

  has_one :newest_schedule,
    -> {where("start_date >= ?", Date.today).order(start_date: :desc)},
    class_name: CourseSchedule.name, foreign_key: :course_id

  accepts_nested_attributes_for :images, allow_destroy: true
  
  scope :popular, -> do
    left_joins(:registrations).group(:id)
      .order("COUNT(registrations.id) DESC").first Settings.courses.popular
  end
  scope :newest, -> do
    includes(:newest_schedule, :images)
      .order("course_schedules.start_date desc nulls last")
  end
  scope :by_words, -> words{where("LOWER(name) LIKE ?", "%#{words.downcase}%")}

  enum status: {opening: 0, closed: 1}

  validates :name, presence: true, length: {
    maximum: Settings.courses.max_name_length,
    minimum: Settings.courses.min_name_length}
  validates :description, presence: true, length: {
    maximum: Settings.courses.max_description_length,
    minimum: Settings.courses.min_description_length}
  validates :cost, presence: true, numericality: {greater_than_or_equal_to: 0}
  validates :content, presence: true

  def images_attributes= attributes
    self.images.delete_all
    super
  end
end
