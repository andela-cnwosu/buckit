class ItemSerializer < ActiveModel::Serializer
  include DateFormatter

  attributes :id, :name, :date_created, :date_modified, :done
end
