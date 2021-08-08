class TraceableContract < ApplicationRecord
  belongs_to :contract
  has_many :invoices, dependent: :destroy

  enum payment_period: { monthly: 0, anually: 1 }

  scope :active, -> { where(outdated_at: nil) }
end
