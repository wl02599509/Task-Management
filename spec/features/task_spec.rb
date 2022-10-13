# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Tasks', type: :feature do
  scenario 'root' do
    visit root_path
    expect(page).to have_content('Task Index')
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
    click_on 'Add Task'
    within '#new_task' do
      fill_in 'task_title', with: Faker::Job.title
      fill_in 'task_content', with: Faker::Job.field
    end
    click_on 'Submit'
    expect(page).to have_content('Task Created')
  end

  scenario '#edit' do
    task = create(:task)
    visit root_path
    click_on 'edit'
    within '.edit_task' do
      fill_in 'task_title', with: Faker::Job.title
      fill_in 'task_content', with: Faker::Job.field
    end
    click_on 'Submit'
    expect(page).to have_content('Task Updated!')
  end

  scenario '#destroy' do
    Capybara.current_driver = :selenium_chrome_headless
    task = create(:task)
    visit root_path
    accept_confirm do
      click_on 'delete'
    end
    expect(page).to have_content('Task Deleted!')
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
    expect(page).to have_content('back to task index')
  end
end
