module RewardsHelper
  def submit_button_name(reward)
    return "Add Reward" if reward.new_record?
    "Update Reward"
  end

  def alphabetize_rewards(rewards)
    rewards.sort_by { |reward| reward.name }
  end
end