class GroupHelper
    def self.set_columns
        Group.roots.each do |group|
            count = group.descendant_ids.count
            case count
			when 0..19
				columns = 1
			when 20..60
				columns = 2
			else
				columns = 3
            end
            group.update(:columns_count => columns)
        end
    end
end    