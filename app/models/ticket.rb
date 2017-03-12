# == Schema Information
#
# Table name: tickets
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text(65535)
#  status      :integer          default("new")
#  reporter_id :integer
#  assignee_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Ticket < ApplicationRecord
  include AASM

  belongs_to :reporter, class_name: User.name
  belongs_to :assignee, class_name: User.name, required: false

  validates :title, presence: true, length: { in: 10..255 }
  validates :description, presence: true, length: { maximum: 5000 }

  enum status: {
    submitted: 0,
    assigned: 1,
    in_progress: 1,
    resolved: 2,
    closed: 3,
    reopened: 4
  }

  aasm column: :status, enum: true do
    state :submitted, initial: true
    state :assigned
    state :resolved
    state :closed
    state :reopened

    event :assign do
      transitions from: :submitted, to: :assigned
    end

    event :start do
      transitions from: [:assigned, :reopened], to: :in_progress
    end

    event :resolve do
      transitions from: :in_progress, to: :resolved
    end

    event :close do
      transitions from: :resolved, to: :closed
    end

    event :reopen do
      transitions from: :resolved, to: :reopened
    end
  end
end
