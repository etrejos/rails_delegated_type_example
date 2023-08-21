class Entry < ApplicationRecord
  delegated_type :entryable, types: %w[Comment Message], dependent: :destroy
end
