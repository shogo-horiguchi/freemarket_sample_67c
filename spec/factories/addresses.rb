FactoryBot.define do

  factory :address do
    last_name             {"阿部"}
    first_name            {"晋三"}
    last_name_kana        {"アベ"}
    first_name_kana       {"シンゾウ"}
    postal_code           {"1550000"}
    prefecture            {"東京都"}
    city                  {"渋谷区"}
    street                {"道玄坂１−１−１"}
    building              {"フリマビル９階"}
    telephone             {"03-6543-1234"}
  end

end
