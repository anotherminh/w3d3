class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true

  has_many(
    :submitted_url,
    :class_name => 'ShortenedUrl',
    :foreign_key => :submitter_id,
    :primary_key => :id
  )

  has_many(
    :visits,
    :class_name => 'Visit',
    :foreign_key => :user_id,
    :primary_key => :id
  )

  has_many(
    :visited_urls,
    -> { distinct },
    :through => :visits,
    :source => :shortened_url
  )

  def self.does_email_exist?(email)
    self.exists?(:email => email)
  end
end
