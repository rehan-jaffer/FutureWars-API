require './lib/mixins/policy_object'

class CreateCorporationPolicy

  include PolicyObject

  def initialize(current_user, corporation_name)
    @current_user = current_user
    @corporation_name = corporation_name
  end

  private

   def conditions
      [
       ['Must specify a corporation name', @corporation_name.present?],
       ['Corporation already exists with that name', Corporation.where(name: @corporation_name).count.zero?],
       ['You are already in a corporation', !@current_user.in_a_corporation?]
      ]
    end
end
