class Collection
  attr_accessor :collection_id
  attr_accessor :collection_name

  def initialize(collection_id, collection_name)
    @collection_id = collection_id
    @collection_name = collection_name
  end

end