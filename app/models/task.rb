# frozen_string_literal: true

class Task < ApplicationRecord
  include AASM

  validates :title, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 150 }

  enum priority: { high: '0', normal: '1', low: '2' }

  aasm column: 'state' do
    state :to_be_started, initial: true
    state :in_progress, :done

    event :start do
      transitions from: :to_be_started, to: :in_progress
    end

    event :finish do
      transitions from: :in_progress, to: :done      
    end
  end

  def self.search_state_i18n(keyword)
    start = I18n.t('to_be_started')
    progress = I18n.t('in_progress')
    done = I18n.t('done')

    return @state = 'to_be_started' if keyword === start
    return @state = 'in_progress' if keyword === progress
    return @state = 'done' if keyword === done
    @state = nil
  end

  def self.search(search)
    keyword = search
    search_state_i18n(keyword)
    if @state
      self.where("state like ?", "%#{@state}%")
    else
      self.where("title like ?", "%#{keyword}%")
    end
  end
end
