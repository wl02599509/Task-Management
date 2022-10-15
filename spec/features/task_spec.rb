# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Tasks', type: :feature do
  scenario 'root' do
    visit root_path
    expect(page).to have_content(I18n.t('task_index'))
  end

  scenario '#index created_at desc' do
    task_1 = create(:task)
    task_2 = create(:task)
    task_3 = create(:task)
    visit root_path
    expect(page).to have_selector('tr#task_line:nth-child(1)', text: task_3.title)
    expect(page).to have_selector('tr#task_line:nth-child(2)', text: task_2.title)
    expect(page).to have_selector('tr#task_line:nth-child(3)', text: task_1.title)
    expect(page).not_to have_selector('tr#task_line:nth-child(1)', text: task_1.title)
  end

  scenario '#new' do
    visit root_path
    click_on I18n.t('add_task')
    within '#new_task' do
      fill_in 'task_title', with: Faker::Job.title
      fill_in 'task_content', with: Faker::Job.field
    end
    click_on I18n.t('submit')
    expect(page).to have_content(I18n.t('task_created'))
  end

  scenario '#edit' do
    task = create(:task)
    visit root_path
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
    task = create(:task)
    visit root_path
    accept_confirm do
      click_on I18n.t('delete_task')
    end
    expect(page).to have_content(I18n.t('task_deleted'))
    expect(page).not_to have_content(task.title)
    expect(page).not_to have_content(task.content)
    Capybara.use_default_driver  
  end

  scenario '#show' do
    task = create(:task)
    visit root_path
    click_on task.title
    expect(page).to have_content(task.title)
    expect(page).to have_content(task.content)
    expect(page).to have_content(I18n.t('back_to_task_index'))
  end

  scenario 'order by created_at' do
    task_first_create = create(:task, :created_first_end_first)
    task_second_create = create(:task, :created_last_end_last)
    visit root_path
    click_on I18n.t('task_created_at')
    expect(page).to have_selector('tr#task_line:nth-child(1)', text: task_second_create.title)
    expect(page).to have_selector('tr#task_line:nth-child(2)', text: task_first_create.title)
  end

  scenario 'order by end_at' do
    task_first_end = create(:task, :created_first_end_first)
    task_second_end = create(:task, :created_last_end_last)
    visit root_path
    click_on I18n.t('end_at')
    expect(page).to have_selector('tr#task_line:nth-child(1)', text: task_first_end.title)
    expect(page).to have_selector('tr#task_line:nth-child(2)', text: task_second_end.title)
  end
end
