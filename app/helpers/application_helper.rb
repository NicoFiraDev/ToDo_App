module ApplicationHelper
  def flash_class(type)
    case type
    when 'notice' then 'success'
    when 'alert' then 'error'
    end
  end
end
