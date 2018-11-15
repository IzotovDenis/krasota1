class Page < ApplicationRecord
    validates :link, presence: true, uniqueness: true
    validates :title, presence: true
end
