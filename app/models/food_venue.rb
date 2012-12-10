class FoodVenue < RemoteModule::RemoteModel
  attr_accessor :name, :menus

  collection_url 'food_venues'
  member_url 'food_venues/:id'

  def self.all(&block)
    get(collection_url) do |response, json|
      food_venues = json["food_venues"].map do |food_venue_params|
        FoodVenue.new(food_venue_params)
      end
      block.call(food_venues)
    end
  end
end
