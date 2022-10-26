class TaskTimeJob
  include Sidekiq::Job

  def self.perform(end_tasks)
    ActionCable.server.broadcast("time_notice", "#{end_tasks} is nearly ended.")
  end
end
