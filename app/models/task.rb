class Task < ApplicationRecord
  belongs_to :order
  belongs_to :user
end
