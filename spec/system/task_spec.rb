require 'rails_helper'

describe 'task management', type: :system do
  describe 'index' do

    before do
      user_a = FactoryBot.create(:user, name: 'userA', email: 'a@example.com')
      FactoryBot.create(:task, name: 'first task', user: user_a)
    end

    context 'when user logged in' do

      before do
        visit login_path
        fill_in 'メールアドレス', with: 'a@example.com'
        fill_in 'パスワード', with: 'password'
        click_button 'ログインする'
      end

      it 'task displayed' do
        expect(page).to have_content 'first task'
      end

    end

  end


end