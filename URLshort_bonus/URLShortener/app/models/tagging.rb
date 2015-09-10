class Tagging < ActiveRecord::Base
  # validates [:topic_id, :url_id], presence: true, uniqueness: true

  belongs_to(
    :tagtopic,
    :class_name => 'Tagtopic',
    :foreign_key => :topic_id,
    :primary_key => :id
  )

  belongs_to(
    :url,
    :class_name => 'ShortenedUrl',
    :foreign_key => :url_id,
    :primary_key => :id
  )
end
