require 'rails_helper'

RSpec.describe Api::V1::PropertiesController, type: :controller do
  describe "POST #wishlist" do
    before do
      @user = create(:user)
      @property = create(:property)

      @auth_headers = @user.create_new_auth_token
      request.env["HTTP_ACCEPT"] = 'application/json'
    end

    context "with valid params and tokens" do
      before do
        request.headers.merge!(@auth_headers)
      end

      it "add to wishlist" do
        post :add_to_wishlist, params: {id: @property.id}
        @property.reload
        expect(@property.wishlists.last.id).to eql(Wishlist.last.id)
      end
    end

    context "with invalid tokens" do
      it "can't add to wishlist" do
        post :add_to_wishlist, params: {id: @property.id}
        expect(response.status).to eql(401)
      end
    end
  end

  describe "DELETE #wishlist" do
    before do
      @user     = create(:user)
      @property = create(:property)
      @wishlist = create(:wishlist, user: @user, property: @property)

      @auth_headers = @user.create_new_auth_token
      request.env["HTTP_ACCEPT"] = 'application/json'
    end

    context "with valid params and tokens" do
      before do
        request.headers.merge!(@auth_headers)
      end

      it "remove from wishlist" do
        delete :remove_from_wishlist, params: {id: @property.id}
        expect(Wishlist.all.count).to eql(0)
      end
    end

    context "with invalid tokens" do
      it "can't add to wishlist" do
        delete :remove_from_wishlist, params: {id: @property.id}
        expect(response.status).to eql(401)
      end

      it "whishlist keep existing" do
        delete :remove_from_wishlist, params: {id: @property.id}
        expect(Wishlist.all.count).not_to eql(0)
      end
    end
  end
end
