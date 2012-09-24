class Building < Maglev::Model
  remote_attributes :name, :photo_url, :history

  collection_path '/buildings'
  member_path '/buildings/:id'
end