require 'rails_helper'
describe Payment do
  describe '#create' do
    it "last_nameがない場合は登録できないこと" do
      payment = build(:payment, card_id: "aaaaaaaaaaa")
      payment.valid?
      expect(payment.errors[:card_id]).to include("を入力してください")
    end
  end
end
