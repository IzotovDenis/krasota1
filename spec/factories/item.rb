FactoryBot.define do

  factory :item do
    sequence :uid do |n|
      "uid-#{n}"
    end
    sequence :title do |n|
      "tovar-#{n}"
    end
    in_stock { 3 }
    price { 100 }
  end

  factory :group do
    sequence :uid do |n|
      "uid-#{n}"
    end

    sequence :title do |n|
      "group-#{n}"
    end
  end
  
  factory :order do

    factory :formed_order do
      received {false }
      received_at {nil} 
      formed {true}
      formed_at {"2018-10-04 03:15:38"}
      comment {nil}
      is_paid {nil}
      info { {"firstname" => 'ivan', "lastname" => 'ivanov', "thirdname"=> 'ivanovich', "city" => 'ussuriisk'}}
    end

    initialize_with { new(attributes) }
  end

  factory :payment do
    
  end


  factory :user do
    tel { '1233'}
    password { '2322'}
    password_confirmation { '2322'}
  end

  factory :auth_token do
    val { 'test' }
  end
  end