#encoding: utf-8

require 'spec_helper'
RSpec.describe V1::UsersController, type: :controller do
  before(:all) do
    @group = create(:group)
    @item = create(:item, :group_uid => @group.uid)
    @empty_item = create(:item, :group_uid => @group.uid, :in_stock=>0)
  end

  it 'group success' do
  end


end