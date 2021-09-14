require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '登録できるとき' do
      it 'nickname, email, password, password_confirmation, voice_id, profileがあれば登録できる' do
        expect(@user).to be_valid
      end
      it 'passwordとpassword_confirmationが6文字以上英字と数字の混合であれば登録できる' do
        @user.password = 'aaa000'
        @user.password_confirmation = 'aaa000'
        expect(@user).to be_valid
      end
    end

    context '登録できないとき' do
      it 'nicknameが空だと登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空だと登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it '重複したemailが存在する場合登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'emailに@が含まれていない場合登録できない' do
        @user.email = 'hogefuga.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'passwordが空だと登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'password_confirmationが空だと登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = 'aaa000'
        @user.password_confirmation = 'q1q1q1'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'ageが未選択だと登録できない' do
        @user.age_id = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Age can't be blank")
      end
      it 'ageで1が選択された場合は保存できない' do
        @user.age_id = 1
        @user.valid?
        expect(@user.errors.full_messages).to include("Age can't be blank")
      end
      it 'sexが未選択だと登録できない' do
        @user.sex_id = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Sex can't be blank")
      end
      it 'sexで1が選択された場合は保存できない' do
        @user.sex_id = 1
        @user.valid?
        expect(@user.errors.full_messages).to include("Sex can't be blank")
      end
      it 'voiceが未選択だと登録できない' do
        @user.voice_id = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Voice can't be blank")
      end
      it 'voiceで1が選択された場合は保存できない' do
        @user.voice_id = 1
        @user.valid?
        expect(@user.errors.full_messages).to include("Voice can't be blank")
      end
      it 'platformが未選択だと登録できない' do
        @user.platform_id = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Platform can't be blank")
      end
      it 'platformで1が選択された場合は保存できない' do
        @user.platform_id = 1
        @user.valid?
        expect(@user.errors.full_messages).to include("Platform can't be blank")
      end
      it 'favoriteが未選択だと登録できない' do
        @user.favorite_id = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Favorite can't be blank")
      end
      it 'favoriteで1が選択された場合は保存できない' do
        @user.favorite_id = 1
        @user.valid?
        expect(@user.errors.full_messages).to include("Favorite can't be blank")
      end
      it 'profileが空だと登録できない' do
        @user.profile = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Profile can't be blank")
      end
    end
  end
end
