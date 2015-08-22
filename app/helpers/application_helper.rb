module ApplicationHelper

  def alert_type(type)
    if type == 'notice'
      'ui info message container'
    else
      'ui negative message container'
    end
  end

end
