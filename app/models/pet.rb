# frozen_string_literal: true

class Pet < ApplicationRecord
  IMAGE_TYPE = %r{\Aimage/.*\z}.freeze
  MIN_PICTURES_COUNT = 2
  MAX_PICTURES_COUNT = 5
  THUMBNAIL_TRANSFORMATION = { resize: '320x320' }.freeze

  enum gender: %i[female male]
  enum situation: %i[found lost for_adoption]

  belongs_to :breed, optional: true
  belongs_to :user
  has_many_attached :pictures

  validates :name, :breed, :gender, presence: true, if: :lost? || :for_adoption?
  validates :age, numericality: { only_integer: true }, allow_nil: true
  validates :situation, :address, presence: true
  validates :pictures,
            attached: true,
            content_type: IMAGE_TYPE,
            limit: { min: MIN_PICTURES_COUNT, max: MAX_PICTURES_COUNT }
  validate :latitude_or_longitude_blank

  default_scope { where(deactivated_at: nil) }

  scope :with_deactivated, -> { unscope(where: :deactivated_at) }
  scope :sorted_by_creation_date, ->(order) { order(created_at: order) }

  after_create_commit :create_thumbnails

  state_machine :state, initial: :unprocessed do
    event :process do
      transition unprocessed: :processed
    end

    state :unprocessed do
      def thumbnails
        pictures
      end
    end

    state :processed do
      def thumbnails
        pictures.collect do |picture|
          picture.variant(THUMBNAIL_TRANSFORMATION)
        end
      end
    end
  end

  def self.genders_for_select
    genders.keys.collect do |gender|
      [I18n.t("activerecord.attributes.pet.genders.#{gender}"), gender]
    end
  end

  def self.address_for_select(situation:)
    where(situation: situation).order(:address).pluck(:address)
  end

  def create_thumbnails
    CreatePetThumbnailsWorker.perform_async(id)
  end

  def latitude_or_longitude_blank
    errors.add(:base, :latitude_or_longitude_blank) if latitude.blank? || longitude.blank?
  end
end
