class Item < ApplicationRecord
    has_many :likes, counter_cache: true
    scope :random, -> {order("RANDOM()").limit(12)}

    self.per_page = 60

    def group
        Group.where(:uid=>self.group_uid).first
    end


    def self.te
        current_user = User.find(10)
        Item.where(:group_uid=>"b2d690ed-0040-11e6-affa-54271e090c05").
        joins("LEFT OUTER JOIN likes ON (likes.item_id = items.id)").
        select("
        items.title, 
        CASE coalesce(likes.id, 0) WHEN 0 THEN 'false'::boolean ELSE 'true' END AS user_like, 
        items.id")
    end

end