class CreateTagTopics < ActiveRecord::Migration
  def change
    create_table :tagtopics do |t|
      t.string :topic, null: false
    end
  end
end
