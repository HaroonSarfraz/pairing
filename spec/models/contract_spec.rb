require 'rails_helper'

RSpec.describe Contract, type: :model do
  let(:customer) { create(:customer) }
  let(:contract) { create(:contract, customer: customer) }

  context "when contract doesnt change" do
    it 'creates correct invoices' do
      contract.change_premium(:monthly, 2000, 1.month.ago)
      InvoiceRunnerJob.perform_now

      expect(contract.invoices.count).to eq(1)
      expect(contract.active_invoices.sum(&:amount)).to eq(2000)
    end
  end

  context "when contract premiums goes down changes" do
    it 'create new Traceable Contract' do
      contract.change_premium(:monthly, 1000, 1.month.ago)

      expect(contract.traceable_contracts.count).to eq(2)
    end

    it 'creates two invoices(duplicate with updated premium)' do
      contract.change_premium(:monthly, 2000, 1.month.ago)
      InvoiceRunnerJob.perform_now
      contract.change_premium(:monthly, 1000, 1.month.ago)
      InvoiceRunnerJob.perform_now

      expect(contract.invoices.count).to eq(2)
      expect(contract.invoices.all.sum(&:amount)).to eq(3000)
    end
  end
end
