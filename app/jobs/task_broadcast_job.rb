class TaskBroadcastJob < ApplicationJob
  queue_as :default

  def perform(task)
  	ActionCable.server.broadcast 'case_channel', message: render_task(task)
  end

  private
  	def render_task(task)
  		ApplicationController.renderer.render(partial: 'tasks/task', locals: { task: task })
  	end
end
