class ListSerializer < ActiveModel::Serializer
  attributes :id, :name, :item[:]
end
