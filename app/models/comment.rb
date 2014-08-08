class Comment < ActiveRecord::Base
  validates :content, :commentable_id, :user_id, :commentable_type, presence: true

  belongs_to(
    :author,
    class_name: "User",
    foreign_key: :user_id
  )

  belongs_to :commentable, polymorphic: true


end
