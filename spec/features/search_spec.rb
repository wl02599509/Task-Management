require 'rails_helper'

RSpec.feature "Searches", type: :feature do
  before do
    user = create(:user)
    user.tasks << create_list(:task, 5, :in_progress)
    user.tasks << create_list(:task, 5, :to_be_started)
    user.tasks << create_list(:task, 5, :done)
    sign_in user
  end

  context 'Search by' do
    scenario 'state: to_be_started' do
      within '#search' do
        fill_in 'task_keyword', with: I18n.t('to_be_started')
      end
      click_on I18n.t('search')
      expect(page).to have_content I18n.t('to_be_started')
      expect(page).not_to have_content I18n.t('in_progress')
      expect(page).not_to have_content I18n.t('done')
    end

    scenario 'state: in_progress' do
      within '#search' do
        fill_in 'task_keyword', with: I18n.t('in_progress')
      end
      click_on I18n.t('search')
      expect(page).to have_content I18n.t('in_progress')
      expect(page).not_to have_content I18n.t('to_be_started')
      expect(page).not_to have_content I18n.t('done')
    end

    scenario 'state: done' do
      within '#search' do
        fill_in 'task_keyword', with: I18n.t('done')
      end
      click_on I18n.t('search')
      expect(page).to have_content I18n.t('done')
      expect(page).not_to have_content I18n.t('to_be_started')
      expect(page).not_to have_content I18n.t('in_progress')
    end

    scenario 'title' do
      task_keyword = Task.find_by(:state => 'done')
      task_not_found = Task.find_by(:state => 'in_progress')
      within '#search' do
        fill_in 'task_keyword', with: task_keyword.title
      end
      click_on I18n.t('search')
      expect(page).to have_content task_keyword.title
      expect(page).not_to have_content task_not_found.title
    end
  end
end
