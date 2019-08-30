# frozen_string_literal: true

class PetQuery
  attr_reader :relation

  def initialize(relation = Pet.all)
    @relation = relation
  end

  def filter(params = {}) # rubocop:disable Metrics/AbcSize
    result = relation.with_attached_pictures
    result = result.where(situation: params[:situation]) unless params[:situation].blank?
    result = result.where(breed_id: params[:breed_id]) unless params[:breed_id].blank?
    result = result.where(gender: params[:gender]) unless params[:gender].blank?
    result = result.where('LOWER(address) LIKE ?', "%#{params[:address].downcase}%") unless params[:address].blank?
    result = result.page(params[:page]).per(params[:per_page]) unless params[:page].blank?
    result
  end
end
