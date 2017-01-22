require 'rails_helper'

RSpec.describe Address, type: :model do
  describe "Methodo #geocode" do
    before do
      @address = Address.create(country: 'Brazil', state: 'Sao Paulo',     city: 'Sao Paulo', neighborhood: 'Bela Vista', street: 'Av Paulista', number: '1000')
      @latitude = @address.latitude
      @longitude = @address.longitude
    end

    context "coordenadas equals" do
      it "verification latitude" do
        @address = Address.create(country: 'Brazil', state: 'Sao Paulo',     city: 'Sao Paulo', neighborhood: 'Bela Vista', street: 'Av Paulista', number: '1000')
        @address.reload
        expect(@address.latitude).to eql(@latitude)
      end

      it "verification longitude" do
        @address = Address.create(country: 'Brazil', state: 'Sao Paulo',     city: 'Sao Paulo', neighborhood: 'Bela Vista', street: 'Av Paulista', number: '1000')
        @address.reload
        expect(@address.longitude.to_f).to eql(@longitude.to_f)
      end
    end

    context "coordenadas not equals" do
      it "verification latitude" do
        @address = Address.create(country: 'Brazil', state: 'Parana',     city: 'Toledo', neighborhood: 'Jardim Recanto', street: 'Gilmar Pastre', number: '86')
        @address.reload
        expect(@address.latitude).not_to eql(@latitude)
      end

      it "verification longitude" do
        @address = Address.create(country: 'Brazil', state: 'Parana',     city: 'Toledo', neighborhood: 'Jardim Recanto', street: 'Gilmar Pastre', number: '86')
        @address.reload
        expect(@address.longitude.to_f).not_to eql(@longitude.to_f)
      end
    end
  end
end
