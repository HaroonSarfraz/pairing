class Contract < ApplicationRecord
  belongs_to :customer
  has_many :traceable_contracts, dependent: :destroy
  has_one :active_traceable_contract, -> { where(outdated_at: nil) }, class_name: :TraceableContract

  has_many :invoices, through: :traceable_contracts
  has_many :active_invoices, through: :traceable_contracts, source: :invoices

  delegate :premium, :activated_at, :payment_period, to: :active_traceable_contract

  def change_premium(payment_period, new_premium, active_from = Time.current)
    active_traceable_contract.update(outdated_at: Time.current)
    traceable_contracts.create(payment_period: payment_period, premium: new_premium, activated_at: active_from)
  end
end
