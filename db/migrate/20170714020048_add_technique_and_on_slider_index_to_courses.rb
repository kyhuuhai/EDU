class AddTechniqueAndOnSliderIndexToCourses < ActiveRecord::Migration[5.0]
  def change
    add_column :courses, :technique, :string
    add_column :courses, :on_slider_index, :boolean, default: false
  end
end
