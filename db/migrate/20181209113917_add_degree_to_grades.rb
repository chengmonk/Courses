class AddDegreeToGrades < ActiveRecord::Migration
  def change
    add_column :grades, :degree, :boolean
  end
end
