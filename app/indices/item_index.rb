# coding: utf-8
ThinkingSphinx::Index.define :item, :with => :active_record do
    # fields
    indexes title, :sortable => true
    has created_at, updated_at
end
  