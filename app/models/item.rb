class Item < ApplicationRecord
    
    self.per_page = 10

    def group
        Group.where(:uid=>self.group_uid).first
    end

end