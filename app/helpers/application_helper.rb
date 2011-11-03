module ApplicationHelper
  
  def title
    base_title = "Dinner with Family"
    
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
end
