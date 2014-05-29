class PostSerializer < ActiveModel::Serializer
  cached

  attributes :id, :link, :title, :body, :created_at, :updated_at

  def cache_key
    object
  end
end
