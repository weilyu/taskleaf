require 'rails_helper'

describe 'タスク管理機能', type: :system do

  let(:user_a) {FactoryBot.create(:user, name: 'userA', email: 'a@example.com')}
  let(:user_b) {FactoryBot.create(:user, name: 'userB', email: 'b.example.com')}
  let!(:task_a) {FactoryBot.create(:task, name: 'first task', user: user_a)}

  before do
    visit login_path
    fill_in 'メールアドレス', with: login_user.email
    fill_in 'パスワード', with: login_user.password
    click_button 'ログインする'
  end

  shared_examples_for 'ユーザAが作成したタスクが表示される' do
    it {expect(page).to have_content 'first task'}
  end

  describe '一覧表示機能' do

    context 'ユーザAがログインしているとき' do

      let(:login_user) {user_a}

      it_behaves_like 'ユーザAが作成したタスクが表示される'

    end

    context 'ユーザBがログインしているとき' do
      let(:login_user) {user_b}

      it 'ユーザAが作成したタスクが表示されない' do
        expect(page).to have_no_content 'first task'
      end

    end

  end

  describe '詳細表示機能' do

    context 'ユーザAがログインしているとき' do
      let(:login_user) {user_a}

      before do
        visit task_path(task_a)
      end

      it_behaves_like 'ユーザAが作成したタスクが表示される'

    end

  end

  describe '新規作成機能' do

    let(:login_user) {user_a}

    before do
      visit new_task_path
      fill_in '名称', with: task_name
      click_button '登録する'
    end

    context '新規作成画面で名称を入力したとき' do
      let(:task_name) {'新規作成のテストを書く'}

      it '確認画面へ遷移' do
        expect(page).to have_content '新規作成のテストを書く'
      end
    end

    context '新規作成画面で名称を入力しなかった場合' do
      let(:task_name) {''}

      it 'エラーとなる' do
        within '#error_explanation' do
          expect(page).to have_content '名称を入力してください'
        end
      end
    end

  end

  describe '編集機能' do
    let(:login_user) {user_a}

    before do
      visit edit_task_path(task_a)
      fill_in '名称', with: 'new name'
      fill_in '詳しい説明', with: 'new detail'
      click_button '更新する'
      visit task_path(task_a)
    end

    it do
      expect(page).to have_content 'new name'
      expect(page).to have_content 'new detail'
    end
  end

end
