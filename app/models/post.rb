class Post < ApplicationRecord
  belongs_to :user
  belongs_to :category

  # orders posts in descending order by the creation date
  default_scope -> { includes(:user).order(created_at: :desc) }
end
