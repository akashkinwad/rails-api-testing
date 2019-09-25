class ItemSerializer < ActiveModel::Serializer
  # attributes to be serialized
  attributes :id, :name, :created_at, :updated_at
  # model association
  belongs_to :todo
end
