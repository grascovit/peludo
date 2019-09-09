# frozen_string_literal: true

require 'active_storage/attachment'

module ActiveStorage
  class Attachment
    after_create_commit :new_attachment_created

    def new_attachment_created
      record.new_attachment_callback
    end
  end
end
