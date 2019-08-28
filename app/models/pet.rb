# frozen_string_literal: true

class Pet < ApplicationRecord
  IMAGE_TYPE = %r{\Aimage/.*\z}.freeze
  MIN_PICTURES_COUNT = 2
  MAX_PICTURES_COUNT = 5
  THUMBNAIL_TRANSFORMATION = { resize: '320x320' }.freeze

  enum gender: %i[female male]
  enum situation: %i[found lost]

  belongs_to :breed, optional: true
  belongs_to :user
  has_many_attached :pictures

  validates :name, :breed, :gender, presence: true, if: :lost?
  validates :age, numericality: { only_integer: true }, allow_nil: true
  validates :situation, :address, :latitude, :longitude, presence: true
  validates :pictures,
            attached: true,
            content_type: IMAGE_TYPE,
            limit: { min: MIN_PICTURES_COUNT, max: MAX_PICTURES_COUNT }

  default_scope { where(deactivated_at: nil) }

  scope :with_deactivated, -> { unscope(where: :deactivated_at) }

  after_create_commit :create_thumbnails

  def self.genders_for_select
    genders.keys.collect do |gender|
      [I18n.t("activerecord.attributes.pet.genders.#{gender}"), gender]
    end
  end

  def create_thumbnails
    CreateThumbnailsWorker.perform_async(id)
  end

  state_machine :state, initial: :without_thumbnail do
    event :process do
      transition without_thumbnail: :with_thumbnail
    end

    state :without_thumbnail do
      def thumbnails
        pictures
      end
    end

    state :with_thumbnail do
      def thumbnails
        pictures.collect do |picture|
          picture.variant(THUMBNAIL_TRANSFORMATION)
        end
      end
    end
  end
end
