require 'elasticsearch/model'

class Post < ActiveRecord::Base
  validates :title, :body, :user_id, presence: true

  belongs_to :user
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  has_many :responses, -> { order(created_at: :desc) }, dependent: :destroy
  has_many :responders, through: :responses, source: :user
  has_many :likes, as: :likeable
  has_many :likers, through: :likes, source: :user
  has_many :bookmarks, as: :bookmarkable
  has_many :bookmarkers, through: :bookmarks, source: :user

  delegate :username, to: :user

  scope :recent, -> { order(created_at: :desc) }
  scope :latest, ->(number) { recent.limit(number) }
  scope :top_stories, ->(number) { order(likes_count: :desc).limit(number) }
  scope :published, -> { where.not(published_at: nil) }
  scope :drafts, -> { where(published_at: nil) }
  

  mount_uploader :picture, PictureUploader

  # will_pagination configuration
  self.per_page = 5

  include SearchablePost

  def self.tagged_with(name)
    Tag.find_by!(name: name).posts
  end

  def all_tags=(names)
    self.tags = names.split(",").map do |name|
      Tag.where(name: name.strip).first_or_create!
    end
  end

  def all_tags
    tags.map(&:name).join(", ")
  end

  def publish
    self.published_at = Time.zone.now
    save
  end

  def save_as_draft
    self.published_at = nil
    save
  end

  def unpublish
    self.published_at = nil
  end

  def published?
    published_at.present?
  end

  def words
    body.split(' ')
  end

  def word_count
    words.size
  end
end

# Delete the previous posts index in Elasticsearch
Post.__elasticsearch__.client.indices.delete index: Post.index_name rescue nil

# Create the new index with the new mapping
Post.__elasticsearch__.client.indices.create \
  index: Post.index_name,
  body: { settings: Post.settings.to_hash, mappings: Post.mappings.to_hash }

# Index all post records from the DB to ElasticsearchPost.import

Post.import