class SearchHelper
    prepend SimpleCommand 
        def self.string_find(string)
            d = []
            string.split(" ").each do |i|
                d << ["(#{i} | *#{i}*)"]
            end
            d = d.join(" & ")
            d = "( #{d} )"
            return d
        end
    end