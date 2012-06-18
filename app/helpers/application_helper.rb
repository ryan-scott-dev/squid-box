module ApplicationHelper

  def error_messages_for model_instance
    if model_instance.errors.any?
      render :partial => 'error_messages', :locals => { :errors => model_instance.errors }
    end
  end

end
