FactoryBot.define do

  factory :user do
    nickname              {"abe"}
    email                 {"kkk@gmail.com"}
    password              {"00000000"}
    password_confirmation {"00000000"}
    last_name             {"阿部"}
    first_name            {"晋三"}
    last_name_kana        {"アベ"}
    first_name_kana       {"シンゾウ"}
    birth_date            {"1991-09-23"}
  end

end
