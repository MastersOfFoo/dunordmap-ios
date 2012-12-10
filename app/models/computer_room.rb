class ComputerRoom < RemoteModule::RemoteModel
  attr_accessor :name, :available

  collection_url 'computer_rooms'

  def self.all(&block)
    get(collection_url) do |response, json|
      computer_rooms = json["computer_rooms"].map do |computer_room_params|
        ComputerRoom.new(computer_room_params)
      end
      block.call(computer_rooms)
    end
  end
end
