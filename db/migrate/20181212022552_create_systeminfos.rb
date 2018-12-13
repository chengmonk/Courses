class CreateSysteminfos < ActiveRecord::Migration
  def change
    create_table :systeminfos do |t|
      t.string :semester
      t.datetime :cs_start
      t.datetime :cs_end

      t.timestamps null: false
    end
  end
end
