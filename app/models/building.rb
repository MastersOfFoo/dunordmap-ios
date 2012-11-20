class Building < RemoteModule::RemoteModel
  attr_accessor :latitude, :longitude, :name, :history, :image

  collection_url 'buildings'
  member_url 'buildings/:id'
  custom_urls :search_url => collection_url + "/search"


  def self.search(latitude, longitude, &block)
    get(search_url, :query => {:latitude => latitude, :longitude => longitude}) do |response, json|
      buildings = json["buildings"].map do |building_params|
        Building.new(building_params)
      end
      block.call(buildings)
    end
  end
end