# frozen_string_literal: true

class ContactLog < ApplicationRecord
  belongs_to :requesting_user, class_name: 'User'
  belongs_to :requested_user, class_name: 'User'
  belongs_to :pet
end
