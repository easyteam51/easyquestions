class Question < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :destroy

  validates :title, presence: true, length: { maximum: 255 }
  validates :body, presence: true, length: { maximum: 65535 }
end
