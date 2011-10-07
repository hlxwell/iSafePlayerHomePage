module ApplicationHelper
  def top_menu
    # <li>
    #   Home
    # </li>
    # <li>
    #   <a href='/'>Feedback</a>
    # </li>
    # <li class='no_right'>
    #   <a href='/'>About</a>
    # </li>
    
    output_html = ""
    [
      ["Home", root_path],
      ["Feedback", feedbacks_path, true]
      # ["About", about_path, true] 
    ].each do |title, path, is_last_one|
      options = is_last_one ? {:class => 'no_right'} : {}
      content = current_page?(path) ? title : content_tag(:a, title, :href => path)      
      output_html << content_tag(:li, content, options)
    end
    output_html
  end
end
