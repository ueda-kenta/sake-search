require 'rails_helper'

RSpec.describe Post, type: :model do
  before do
    @post = FactoryBot.build(:post)
  end

  describe 'バリデーションのテスト' do
    it '酒名、紹介文があれば有効であること' do
      expect(@post).to be_valid
    end

    it '酒名が無ければ無効であること' do
      @post.sake_name = ''
      @post.valid?
      expect(@post.errors[:sake_name]).to include('を入力してください')
    end

    it '酒名が２０字以内であること' do
      @post.sake_name = 'a' * 21
      @post.valid?
      expect(@post.errors[:sake_name]).to include('は20文字以内で入力してください')
    end

    it '紹介文が無ければ無効であること' do
      @post.sake_text = ''
      @post.valid?
      expect(@post.errors[:sake_text]).to include('を入力してください')
    end

    it '紹介文が１４０字以内であること' do
      @post.sake_text = 'a' * 141
      @post.valid?
      expect(@post.errors[:sake_text]).to include('は140文字以内で入力してください')
    end
  end

  describe 'メソッドのテスト' do
    it 'searchメソッドのテスト' do
      it '完全一致を選択した際、完全一致のデータを表示すること' do
        expect(Post.search('perfect_match', 'テスト酒')).to include(@post)
      end

      it '完全一致を選択した際、完全一致でないデータは表示されないこと' do
        expect(Post.search('perfect_match', 'テス')).not_to include(@post)
      end

      it '部分一致を選択した際、部分一致のデータを表示すること' do
        expect(Post.search('partial_match', 'テス')).to include(@post)
      end

      it '部分一致を選択した際、不一致のデータは表示されないこと' do
        expect(Post.search('partial_match', 'aaaa')).not_to include(@post)
      end
    end
  end
end
