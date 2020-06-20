class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :question
  has_many :likes, dependent: :destroy

  include AASM

  aasm  whiny_transitions: false do
    state :created, initial: true
    state :inactive
    state :active


    event :activate  do
      transitions from: [:created, :inactive], to: :active
    end

    event :deactivate do
      transitions from: :active, to: :inactive
    end
  end
end
