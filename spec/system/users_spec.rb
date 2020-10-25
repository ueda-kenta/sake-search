require 'rails_helper'

RSpec.describe "Users", type: :system do
	let(:user){FactoryBot.create(:user)}

	describe 'ユーザー認証のテスト' do
		describe 'ユーザー新規登録' do
			before do
				visit new_user_registration_path
			end
			context '新規登録画面' do
				it '新規登録に成功する' do
					fill_in '姓', with "テスト"
					fill_in '名', with "太郎"
					fill_in 'ニックネーム', with "test"
					fill_in 'メールアドレス', with "test@test"
					fill_in 'パスワード', with "aaaaaa"
					click_button '新規登録'
					expect(page).to have_content 'アカウント登録が完了しました'
				end

				it '新規登録に失敗する' do
					fill_in '姓', with ""
					fill_in '名', with ""
					fill_in 'ニックネーム', with ""
					fill_in 'メールアドレス', with ""
					fill_in 'パスワード', with ""
					click_button '新規登録'
					expect(page).to have_content '保存されませんでした'
				end
			end
		end
		discribe 'ユーザーログイン' do
			before do
				visit new_user_session_path
			end
			context 'ログイン画面' do
				it 'ログインに成功する' do
					fill_in "ニックネーム", with: user.nickname
					fill_in 'パスワード', with: user.password
					click_button 'ログイン'
					expect(page).to have_content 'ログインしました。'
				end
				it 'ログインに失敗する' do
					fill_in 'ニックネーム', with: ''
					fill_in 'パスワード', with: ''
					click_button 'ログイン'
					expect(page).to have_content '不正です'
				end
			end
		end
	end

	describe 'ユーザーのテスト' do
		before do
			visit new_user_session_path
			fill_in 'ニックネーム', with: user.nickname
			fill_in 'パスワード', with: user.password
			click_button 'ログイン'
		end

		describe 'マイページのテスト' do
			it 'ドロワーメニューからマイページへ遷移し、編集リンクが表示される' do
				visit user_path(user)
				expect(page).to have_content('編集する')
			end
		end
		describe '編集ページのテスト' do
			it '編集画面へ遷移' do
				visit edit_user_path(user)
				expect(current_path).to eq edit_user_path(user)
			end
			it '編集に成功する' do
				visit edit_user_path(user)
				fill_in '姓', with: 'テスト'
				fill_in '名', with: '花子'
				fill_in 'ニックネーム', with: 'テストさん'
				click_button '変更を保存'
				expect(page).to have_content '変更しました'
				expect(page).to have_content 'テスト 花子'
				expect(page).to have_content 'テストさん'
				expect(current_path).to eq user_path(user)
			end
			it '編集に失敗する' do
				visit edit_user_path(user)
				fill_in '姓', with: ''
				fill_in '名', with: ''
				fill_in 'ニックネーム', with: ''
				click_button '変更を保存'
				expect(page).to have_content '入力されていません'
				expect(current_path).to eq edit_user_path(user)
			end
		end
	end
end
