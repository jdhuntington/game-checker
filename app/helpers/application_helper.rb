module ApplicationHelper
  def site_title(my_turns)
    prefix = my_turns.empty? ? '' : "(#{my_turns.length}) "
    prefix + 'My Turns'
  end
end
