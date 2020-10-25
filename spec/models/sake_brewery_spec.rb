require 'rails_helper'

RSpec.describe SakeBrewery, type: :model do
	before do
		@sake_brewery = FactoryBot.build(:sake_brewery)
	end

	describe 'バリデーションのテスト' do
		it '酒蔵名、酒蔵住所があれば有効であること' do
			expect(@sake_brewery).to be_valid
		end

		it '酒蔵名は一意であること' do
			FactoryBot.create(:sake_brewery)
			@sake_brewery.valid?
			except(@sake_brewery.errors[:sake_brewery]).to include("は既に存在します")
		end

		it '酒蔵名が入力されていないと無効であること' do
			@sake_brewery.brewery_name = ""
			@sake_brewery.valid?
			expect(@sake_brewery.errors[:brewery_name]).to include("を入力してください")
		end

		it '所在地が入力されていないと無効であること' do
			@sake_brewery.brewery_prefecture = ""
			@sake_brewery.brewery_prefecture.valid?
			expect(@sake_brewery.brewery_prefecture.errors[:brewery_prefecture]).to include("を入力してください")
		end
	end

	describe 'メソッドのテスト' do
		context 'addressメソッドのテスト'　do

			it '都道府県と市町村が合体していること' do
				expect(@sake_brewery.address).to eq "北海道札幌市"
			end
		end

		context 'searchメソッドのテスト' do

			it '完全一致を選択した際、完全一致のデータを表示すること' do
				expect(SakeBrewery.search( "perfect_match", "テスト酒造" )).to include(@sake_brewery)
			end

			it '完全一致を選択した際、完全一致でないデータは表示されないこと' do
				expect(SakeBrewery.search( "perfect_match", "テスト" )).not_to include(@sake_brewery)
			end

			it '部分一致を選択した際、部分一致のデータを表示すること' do
				expect(SakeBrewery.search( "partial_match", "テスト" )).to include(@sake_brewery)
			end

			it '部分一致を選択した際、不一致のデータは表示されないこと' do
				expect(SakeBrewery.search( "partial_match", "aaaa" )).not_to include(@sake_brewery)
			end
		end
	end

end
