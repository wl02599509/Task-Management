def search_tasks(user)
  @ruby = Task.create(:title => 'Ruby', :content => 'Ruby', :state => 'to_be_started', :user_id => user.id)

  @python = Task.create(:title => 'Python', :content => 'Python', :state => 'in_progress', :user_id => user.id)

  @go = Task.create(:title => 'Go', :content => 'Go', :state => 'done', :user_id => user.id)
end