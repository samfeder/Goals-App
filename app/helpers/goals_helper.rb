module GoalsHelper

  def goal_title(goal)
    goal.completed ? "#{goal.title} (completed!)" : goal.title
  end


end
