class Tagtopic < ActiveRecord::Base

  has_many(
    :taggings,
    :class_name => 'Tagging',
    :foreign_key => :topic_id,
    :primary_key => :id
  )

  has_many(
    :urls,
    :through => :taggings,
    :source => :url
  )
end
