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
end
