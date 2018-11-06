#encoding: utf-8

require 'spec_helper'
RSpec.describe Admin::UsersController, type: :controller do

    before(:each) do
        get :create, params: { user: {firstname: 'first', tel: '79147113340'}}
        @json = JSON.parse(response.body)
    end

    it 'admin create user without errors' do
        expect(@json["errors"]).to eq(nil)
    end

    it 'admin"s created user has id' do
        expect(@json["user"]["id"].class).to eq(Integer)
    end

    it 'admin"s created user has attribute created_from_1c true' do
        expect(@json["user"]["created_from_1c"]).to eq(true)
    end

end

RSpec.describe Admin::UsersController, type: :controller do
    before(:all) do
        @user = create(:user)
    end

    before(:each) do
        get :update, params: { id: @user.id, user: {firstname: 'first', tel: '79147113340', discount: 3}}
        @json = JSON.parse(response.body)
    end

    it 'admin can update user' do
        expect(@json["errors"]).to eq(nil)
    end

    it 'admin can update user firstname' do
        expect(@json["user"]["firstname"]).to eq('first')
    end

    it 'admin can update user discount' do
        expect(@json["user"]["discount"]).to eq(3)
    end

end