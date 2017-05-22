module DeviseHelper
  def devise_error_messages!
    return "" unless devise_error_messages?

    resource.errors.full_messages.each do |message|
      flash[:error] = message
    end
  end

  def devise_error_messages?
    !resource.errors.empty?
  end

end