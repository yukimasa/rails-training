require 'rails_helper'

describe 'タスク管理機能', type: :system do
  describe '一覧表示機能' do

    # ユーザーAを作成しておく
    let(:user_a) { FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com') }
    # ユーザーBを作成しておく
    let(:user_b) { FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com') }

    before do
      # 作成者がユーザーAであるタスクを作成しておく
      FactoryBot.create(:task, name: '最初のタスク', user: user_a)

      # ユーザーAでログインする
      # 1. ログイン画面にアクセスする
      visit login_path
      # 2. メールアドレスを入力する
      fill_in 'メールアドレス', with: login_user.email
      # 3. パスワードを入力する
      fill_in 'パスワード', with: login_user.password
      # 4. 「ログインする」ボタンを押す
      click_button 'ログインする'
    end

    context 'ユーザーAがログインしている時' do
      let(:login_user) { user_a }

      it 'ユーザーAが作成したタスクが表示される' do
        # 作成済みのタスクの名称が画面上に表示されていることを確認
        expect(page).to have_content '最初のタスク'
      end
    end

    context 'ユーザーBがログインしている時' do
      let(:login_user) { user_b }

      it 'ユーザーAが作成したタスクが表示されない' do
        # ユーザーAが作成したタスクの名称が画面上に表示されていないことを確認
        expect(page).not_to have_content '最初のタスク'
      end
    end
  end
end
