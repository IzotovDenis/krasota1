class Item < ApplicationRecord

    def group
        Group.where(:uid=>self.group_uid).first
    end

end
