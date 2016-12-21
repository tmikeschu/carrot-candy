module RewardsHelper
  def submit_button_name(reward)
    return "Add Reward" if reward.new_record?
    "Update Reward"
  end
end