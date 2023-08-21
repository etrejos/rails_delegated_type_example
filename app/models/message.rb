class Message < ApplicationRecord
  include Entryable
  belongs_to :user
  has_many :comments
end
