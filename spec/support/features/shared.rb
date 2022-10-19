def sign_in(user)
  visit sign_in_users_path
  within '#sign_in_form' do
    find('input#user_email').set user.email
    find('input#user_password').set '123456789'
  end
  click_button I18n.t('sign_in')
end

def created_three_task
  @task_1 = Task.create(:title => Faker::Job.title , :content => Faker::Job.field, :user_id => user.id)
  @task_2 = Task.create(:title => Faker::Job.title , :content => Faker::Job.field, :user_id => user.id)
  @task_3 = Task.create(:title => Faker::Job.title , :content => Faker::Job.field, :user_id => user.id)
end

def tasks(user)
  @first_low = Task.create(:title => Faker::Job.title , :content => Faker::Job.field, :user_id => user.id, :created_at => Time.now + 1.days, :end_at => Time.now + 10.days, :priority => 'low' )

  @second_normal = Task.create(:title => Faker::Job.title , :content => Faker::Job.field, :user_id => user.id, :created_at => Time.now + 3.days, :end_at => Time.now + 12.days, :priority => 'normal' )
  
  @third_hgih = Task.create(:title => Faker::Job.title , :content => Faker::Job.field, :user_id => user.id, :created_at => Time.now + 5.days, :end_at => Time.now + 14.days, :priority => 'high' )
end
