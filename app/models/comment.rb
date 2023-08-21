class Comment < ApplicationRecord
  include Entryable
  belongs_to :user
  belongs_to :message
end
