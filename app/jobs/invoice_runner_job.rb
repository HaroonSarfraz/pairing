class InvoiceRunnerJob < ApplicationJob
  queue_as :default

  def perform
    TraceableContract.active.monthly.where.not(activated_at: nil).where('activated_at <= ?', Time.current).each do |contract|
      date_from = contract.activated_at + contract.invoices.count.months
      months_missings = (Time.current.year * 12 + Time.current.month) - (date_from.year * 12 + date_from.month)

      months_missings.times do
        contract.invoices.create(amount: contract.premium)
      end
    end
  end
end
