module ApplicationHelper

  def error_messages_for model_instance
    if model_instance.errors.any?
      render :partial => 'error_messages', :locals => { :errors => model_instance.errors }
    end
  end

  def navigation_menu
      menu_items = [ { :text => "Home", :path => home_path },
                     { :text => "Repositories", :path => repositories_path } ]

      html_class = menu_items.each_with_object({}) do |item, hash|
        text = item[:text]
        first_path_segment = "/#{request.path.split('/')[1]}" # /tournaments/introduction returns "/tournaments"
        hash[text] = first_path_segment == item[:path] ? 'selected' : ''
      end

      render :partial => "navigation", :locals => { :menu_items => menu_items, :html_class => html_class }
    end
end
