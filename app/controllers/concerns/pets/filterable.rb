# frozen_string_literal: true

module Pets
  module Filterable
    DEFAULT_PAGE = 1
    API_PAGE_SIZE = 10
    WEB_PAGE_SIZE = 9

    def api_filter_params
      {
        situation: params[:situation],
        page: params[:page] || DEFAULT_PAGE,
        per_page: API_PAGE_SIZE,
        breed_id: params[:breed_id],
        gender: params[:gender],
        address: params[:address],
        distance: params[:distance],
        latitude: params[:latitude],
        longitude: params[:longitude]
      }
    end

    def web_filter_params(situation:)
      {
        page: params[:page] || DEFAULT_PAGE,
        per_page: WEB_PAGE_SIZE,
        breed_id: params[:breed_id],
        gender: params[:gender],
        address: params[:address]
      }.merge(situation: situation)
    end
  end
end
