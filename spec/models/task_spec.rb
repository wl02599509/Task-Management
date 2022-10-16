require 'rails_helper'

RSpec.describe Task, type: :model do
  it "validates title presence" do
    title_valid = build(:task)
    title_nil = build(:task, :title_nil)
    expect(title_valid).to be_valid
    expect(title_nil).not_to be_valid
  end

  it "validates title length" do
    title_valid = build(:task, :title_50)
    title_overlength = build(:task, :title_51)
    expect(title_valid).to be_valid
    expect(title_overlength).not_to be_valid
  end

  it "validates content presence" do
    content_valid = build(:task)
    content_nil = build(:task, :content_nil)
    expect(content_valid).to be_valid
    expect(content_nil).not_to be_valid
  end

  it "validates content length" do
    content_valid = build(:task, :content_150)
    content_overlength = build(:task, :content_151)
    expect(content_valid).to be_valid
    expect(content_overlength).not_to be_valid
  end

  it ".search_state_i18n" do
    keyword_1 = '待處理'
    keyword_2 = '進行中'
    keyword_3 = '完成'
    expect(Task.search_state_i18n(keyword_1)).to eq 'to_be_started'
    expect(Task.search_state_i18n(keyword_2)).to eq 'in_progress'
    expect(Task.search_state_i18n(keyword_3)).to eq 'done'
  end

  it ".search" do
    ruby = Task.create(:title => 'Ruby', :content => 'Ruby', :state => 'to_be_started')
    python = Task.create(:title => 'Python', :content => 'Python', :state => 'in_progress')
    go = Task.create(:title => 'Go', :content => 'Go', :state => 'done')
    
    expect(Task.search('待處理')).to include ruby
    expect(Task.search('待處理')).not_to eq include python && go
    expect(Task.search('進行中')).to include python
    expect(Task.search('進行中')).not_to eq include ruby && go
    expect(Task.search('完成')).to include go
    expect(Task.search('完成')).not_to eq include ruby && python
  end

  it ".search" do
    ruby = Task.create(:title => 'Ruby', :content => 'Ruby', :state => 'to_be_started')
    python = Task.create(:title => 'Python', :content => 'Python', :state => 'in_progress')
    go = Task.create(:title => 'Go', :content => 'Go', :state => 'done')
    
    expect(Task.search('R')).to include ruby
    expect(Task.search('R')).not_to include python && go
    expect(Task.search('P')).to include python
    expect(Task.search('o')).to include python && go
    expect(Task.search('o')).not_to include ruby
    expect(Task.search('G')).to include go
    expect(Task.search('G')).not_to include ruby && python
  end
end
