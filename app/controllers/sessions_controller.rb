# frozen_string_literal: true

class SessionsController < Devise::SessionsController
  def create
    super
    resource.reactivate!
  end
end
