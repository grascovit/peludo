# frozen_string_literal: true

module Pets
  module Filterable
    DEFAULT_PAGE = 1
    API_PAGE_SIZE = 10

    def api_filter_params
      {
        situation: params[:situation],
        page: params[:page] || DEFAULT_PAGE,
        per_page: API_PAGE_SIZE,
        breed_id: params[:breed_id],
        gender: params[:gender],
        address: params[:address]
      }
    end
  end
end
