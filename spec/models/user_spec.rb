require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'バリデーションのテスト' do
    it '姓、名、ニックネーム、メールアドレス、パスワードがあれば有効であること' do
      expect(@user).to be_valid
    end

    it '姓が無ければ無効であること' do
      @user.last_name = ''
      @user.valid?
      expect(@user.errors[:last_name]).to include('を入力してください')
    end

    it '姓が８文字以内であること' do
      @user.last_name = 'a' * 9
      @user.valid?
      expect(@user.errors[:last_name]).to include('は8文字以内で入力してください')
    end

    it '名が無ければ無効であること' do
      @user.first_name = ''
      @user.valid?
      expect(@user.errors[:first_name]).to include('を入力してください')
    end

    it '名が８文字以内であること' do
      @user.first_name = ''
      @user.valid?
      expect(@user.errors[:first_name]).to include('は8文字以内で入力してください')
    end

    it 'メールアドレスがなければ無効な状態であること' do
      @user.email = ''
      @user.valid?
      expect(@user.errors[:email]).to include('を入力してください')
    end

    it '自己紹介文が140文字以下であること' do
      @user.profile_text = 'a' * 141
      @user.valid?
      expect(@user.errors[:profile_text]).to include('は140文字以内で入力してください')
    end

    it 'パスワードが6文字以上でなければ無効であること' do
      @user.password = 'a' * 5
      @user.valid?
      expect(@user.errors[:password]).to include('は6文字以上で入力してください。')
    end
  end
  describe 'メソッドのテスト' do
    context 'searchメソッドのテスト' do
      it '完全一致を選択した際、完全一致のデータを表示すること' do
        expect(User.search('perfect_match', 'test1')).to include(@user)
      end

      it '完全一致を選択した際、完全一致でないデータは表示されないこと' do
        expect(User.search('perfect_match', 'tes')).not_to include(@user)
      end

      it '部分一致を選択した際、部分一致のデータを表示すること' do
        expect(User.search('partial_match', 'tes')).to include(@user)
      end

      it '部分一致を選択した際、不一致のデータは表示されないこと' do
        expect(User.search('partial_match', 'aaaa')).not_to include(@user)
      end
    end

    context 'followメソッドのテスト' do
    end

    context 'unfollowメソッドのテスト' do
    end
  end
end
