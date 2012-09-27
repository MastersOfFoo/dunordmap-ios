class Building < RemoteModule::RemoteModel
  attr_accessor :name

  collection_url 'buildings'
  member_url 'buildings/:id'
end