module ApplicationHelper

  def link_class(page)
    if params[:action] == page
      { class: 'selected' }
    end
  end  

  def full_title(page_title)
    base_title = 'Ninetab'
    if page_title.empty?
      base_title
    else
      "#{base_title} - #{page_title}"
    end
  end

end
