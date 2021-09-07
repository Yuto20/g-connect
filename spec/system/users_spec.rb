require 'rails_helper'

RSpec.describe "ユーザー新規登録", type: :system do
  before do
    @user = FactoryBot.build(:user)
  end

  def basic_auth(path)
    name = ENV["BASIC_AUTH_USER"]
    password = ENV["BASIC_AUTH_PASSWORD"]
    visit "http://#{name}:#{password}@#{Capybara.current_session.server.host}:# {Capybara.current_session.server.port}#{path}"
  end

  context 'ユーザー新規登録ができるとき' do 
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      # トップページに移動する
      basic_auth root_path
      visit root_path
      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')
      expect(page).to have_content('ログイン')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      image_path = Rails.root.join('public/images/test_image.png')
      fill_in 'ニックネーム',     with: @user.nickname
      fill_in 'メールアドレス',   with: @user.email
      fill_in 'パスワード',       with: @user.password
      fill_in 'パスワード(確認)', with: @user.password_confirmation
      select  '10代',             from: 'user[age_id]'
      select  '男性',             from: 'user[sex_id]'
      select  'あり',             from: 'user[voice_id]'
      fill_in 'プロフィール',     with: @user.profile
      # サインアップボタンを押すとユーザーモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(1)
      # トップページへ遷移したことを確認する
      expect(current_path).to eq(root_path)
      # 遷移したトップページにログアウトボタンや、ユーザー一覧ページに遷移するボタンが表示されていることを確認する
      expect(page).to have_content('ログアウト')
      # サインアップページへ遷移するボタンや、ログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end

  context 'ユーザー新規登録ができないとき' do
    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      # トップページに移動する
      visit root_path
      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')
      expect(page).to have_content('ログイン')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      image_path = Rails.root.join('public/images/test_image.png')
      fill_in 'ニックネーム',     with: ''
      fill_in 'メールアドレス',   with: ''
      fill_in 'パスワード',       with: ''
      fill_in 'パスワード(確認)', with: ''
      select  '--',               from: 'user[age_id]'
      select  '--',               from: 'user[sex_id]'
      select  '--',               from: 'user[voice_id]'
      fill_in 'プロフィール',     with: ''
      # サインアップボタンを押してもユーザーモデルのカウントは上がらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(0)
      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq user_registration_path
    end
  end
end

RSpec.describe 'ログイン', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
  context 'ログインができるとき' do
    it '保存されているユーザーの情報と合致すればログインができる' do
      # トップページに移動する
      visit root_path
      # トップページにログインページへ遷移するボタンと新規登録ページへ遷移するボタンがあることを確認する
      expect(page).to have_content('ログイン')
      expect(page).to have_content('新規登録')
      # ログインページへ遷移する
      visit new_user_session_path
      # 正しいユーザー情報を入力する
      fill_in 'メールアドレス', with: @user.email
      fill_in 'パスワード',     with: @user.password
      # ログインボタンを押す
      find('input[name="commit"]').click
      # トップページへ遷移することを確認する
      expect(current_path).to eq(root_path)
      # 遷移したトップページにログアウトボタンや、ユーザー一覧ページに遷移するボタン、現在ログイン中のユーザーの詳細画面に遷移するボタンが表示されていることを確認する
      expect(page).to have_content('ユーザーを検索する')
      expect(page).to have_content('ログアウト')
      # サインアップページへ遷移するボタンや、ログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end
  context 'ログインができないとき' do
    it '保存されているユーザーの情報と合致しないとログインができない' do
      # トップページに移動する
      visit root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('ログイン')
      # ログインページへ遷移する
      visit new_user_session_path
      # ユーザー情報を入力する
      fill_in 'メールアドレス', with: ''
      fill_in 'パスワード',     with: ''
      # ログインボタンを押す
      find('input[name="commit"]').click
      # ログインページへ戻されることを確認する
      expect(current_path).to eq(new_user_session_path)
    end
  end
end