#encoding: utf-8

require 'spec_helper'
RSpec.describe V1::GroupsController, type: :controller do
  before(:all) do
    @group = create(:group)
    @item = create(:item, :group_uid => @group.uid)
    @empty_item = create(:item, :group_uid => @group.uid, :in_stock=>0)
  end

  it 'group look like json' do
    get :show, params: { id: @group.id }
    expect(response.body).to look_like_json
  end

  it 'first item  not able' do
    get :show, params: { id: @group.id }
    json = JSON.parse(response.body)
    expect(json['items'][0]['able']).to eq(true)
  end

  it 'second item  not able' do
    get :show, params: { id: @group.id }
    json = JSON.parse(response.body)
    expect(json['items'][1]['able']).to eq(false)
  end

  it 'Group has item' do
    get :show, params: { id: @group.id }
    json = JSON.parse(response.body)
    expect(json['items'].length).to eq(2)
  end

  it 'return group, items, pageLoaded' do
    get :show, params: { id: @group.id }
    json = JSON.parse(response.body)
    expect(json.keys).to match_array(["group", "items", "pageLoaded"])
  end


end