# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Tasks', type: :feature do
  context 'CRUD' do
    let(:task) { create(:task) }
    let(:user) { User.find(task.user_id) }

    before do
      sign_in(user)
    end

    scenario 'root' do
      expect(page).to have_content(I18n.t('task_index'))
    end

    scenario '#index created_at desc' do
      created_three_task
      visit root_path
      expect(page).to have_selector('tr#task_line:nth-child(1)', text: @task_3.title)
      expect(page).to have_selector('tr#task_line:nth-child(2)', text: @task_2.title)
      expect(page).to have_selector('tr#task_line:nth-child(3)', text: @task_1.title)
      expect(page).not_to have_selector('tr#task_line:nth-child(1)', text: @task_1.title)
    end

    scenario '#new' do
      click_on I18n.t('add_task')
      within '#new_task' do
        fill_in 'task_title', with: Faker::Job.title
        fill_in 'task_content', with: Faker::Job.field
      end
      click_on I18n.t('submit')
      expect(page).to have_content(I18n.t('task_created'))
    end

    scenario '#edit' do
      task
      click_on I18n.t('edit_task')
      within '.edit_task' do
        fill_in 'task_title', with: Faker::Job.title
        fill_in 'task_content', with: Faker::Job.field
      end
      click_on I18n.t('submit')
      expect(page).to have_content(I18n.t('task_updated'))
    end

    scenario '#destroy' do
      Capybara.current_driver = :selenium_chrome_headless
      task
      sign_in user
      accept_confirm do
        click_on I18n.t('delete_task')
      end
      expect(page).to have_content(I18n.t('task_deleted'))
      expect(page).not_to have_content(task.title)
      Capybara.use_default_driver
    end

    scenario '#show' do
      task
      visit root_path
      click_on task.title
      expect(page).to have_content(task.title)
      expect(page).to have_content(task.content)
      expect(page).to have_content(I18n.t('back_to_task_index'))
    end
  end

  context "Order" do
    let(:user) { create(:user) }
    before do
      tasks(user)
      sign_in user
    end

    scenario 'by created_at' do
      click_on I18n.t('task_created_at')
      expect(page).to have_selector('tr#task_line:nth-child(1)', text: @third_hgih.title)
      expect(page).to have_selector('tr#task_line:nth-child(2)', text: @second_normal.title)
      expect(page).to have_selector('tr#task_line:nth-child(3)', text: @first_low.title)
    end

    scenario 'by end_at' do
      click_on I18n.t('end_at')
      expect(page).to have_selector('tr#task_line:nth-child(1)', text: @first_low.title)
      expect(page).to have_selector('tr#task_line:nth-child(2)', text: @second_normal.title)
      expect(page).to have_selector('tr#task_line:nth-child(3)', text: @third_hgih.title)
    end

    scenario 'by priority' do
      visit root_path
      click_on I18n.t('task_priority')
      expect(page).to have_selector('tr#task_line:nth-child(1)', text: @third_hgih.title)
      expect(page).to have_selector('tr#task_line:nth-child(2)', text: @second_normal.title)
      expect(page).to have_selector('tr#task_line:nth-child(3)', text: @first_low.title)
    end
  end

  context 'Change state' do
    scenario '#to in_progress' do
      Capybara.current_driver = :selenium_chrome_headless
      task_start = create(:task, :to_be_started)
      sign_in(User.find(task_start.user_id))
      click_on I18n.t('link_in_progress')
      expect(page).to have_content I18n.t('in_progress')
      expect(page).not_to have_content I18n.t('to_be_started')
      expect(page).not_to have_content I18n.t('done')
      Capybara.use_default_driver
    end

    scenario '#to done' do
      Capybara.current_driver = :selenium_chrome_headless
      task_progress = create(:task, :in_progress)
      sign_in(User.find(task_progress.user_id))
      click_on I18n.t('link_done')
      expect(page).to have_content I18n.t('done')
      expect(page).not_to have_content I18n.t('to_be_started')
      expect(page).not_to have_content I18n.t('in_progress')
      Capybara.use_default_driver
    end
  end
end
