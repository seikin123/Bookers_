class Commenter < ApplicationRecord
  belongs_to :user
  belongs_to :book
end
