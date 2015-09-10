class ShortenedUrl < ActiveRecord::Base
  validates :submitter_id, presence: true
  validates :short_url, presence: true, uniqueness: true
  validates :long_url, presence: true

  def self.random_code
    random = SecureRandom::urlsafe_base64
    self.exists?(:short_url => random) ? self.random_code : random
  end

  def self.create_for_user_and_long_url!(user, long_url)
    ShortenedUrl.create!({submitter_id: user.id, long_url: long_url, short_url: self.random_code})
  end

  belongs_to(
    :submitter,
    :class_name => 'User',
    :foreign_key => :submitter_id,
    :primary_key => :id
  )

  has_many(
    :visits,
    :class_name => 'Visit',
    :foreign_key => :short_url_id,
    :primary_key => :id
  )

  has_many(
    :visitors,
    -> { distinct },
    :through => :visits,
    :source => :user
    )

  has_many(
    :taggings,
    :class_name => 'Tagging',
    :foreign_key => :url_id,
    :primary_key => :id
  )

  has_many(
    :tagtopic,
    :through => :taggings,
    :source => :tagtopic
  )

  def num_clicks
    self.visits.count
  end

  def num_uniques
    self.visitors.count
  end

  def num_recent_uniques
    self.visitors.where('visits.created_at >= ?', 10.minutes.ago).count
  end
end
