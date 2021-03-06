class Corporation < ApplicationRecord
  has_one :ceo, foreign_key: 'ceo_id', class_name: 'Player'
  has_many :members, foreign_key: 'corporation_id', class_name: 'Player', dependent: :nullify

  validates :name, uniqueness: { case_sensitive: true }, presence: true

  scope :with_ceo, ->(id) { where(ceo_id: id) }

  def stream_id
    "corporation-#{id}"
  end
end
