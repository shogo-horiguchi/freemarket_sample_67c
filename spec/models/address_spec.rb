require 'rails_helper'
describe Address do
  describe '#create' do
    it "last_nameがない場合は登録できないこと" do
      address = build(:address, last_name: "")
      address.valid?
      expect(address.errors[:last_name]).to include("を入力してください")
    end

    it "first_nameがない場合は登録できないこと" do
      address = build(:address, first_name: "")
      address.valid?
      expect(address.errors[:first_name]).to include("を入力してください")
    end

    it "last_name_kanaがない場合は登録できないこと" do
      address = build(:address, last_name_kana: "")
      address.valid?
      expect(address.errors[:last_name_kana]).to include("を入力してください")
    end

    it "first_name_kanaがない場合は登録できないこと" do
      address = build(:address, first_name_kana: "")
      address.valid?
      expect(address.errors[:first_name_kana]).to include("を入力してください")
    end

    it "postal_codeがない場合は登録できないこと" do
      address = build(:address, postal_code: "")
      address.valid?
      expect(address.errors[:postal_code]).to include("を入力してください")
    end

    it "prefectureがない場合は登録できないこと" do
      address = build(:address, prefecture: "")
      address.valid?
      expect(address.errors[:prefecture]).to include("を入力してください")
    end

    it "cityがない場合は登録できないこと" do
      address = build(:address, city: "")
      address.valid?
      expect(address.errors[:city]).to include("を入力してください")
    end

    it "streetがない場合は登録できないこと" do
      address = build(:address, street: "")
      address.valid?
      expect(address.errors[:street]).to include("を入力してください")
    end
  end
end
