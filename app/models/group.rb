class Group < ApplicationRecord
    has_ancestry
    
    def items
        Item.where(:group_uid=>self.uid)
    end
end
