class Message < ApplicationRecord
  #  belongs_to :player

  scope :unread, -> { where(read: false) }
end
