class ErrorsController < ApplicationController
  layout 'errors'

  def not_found
  	render(:status => 404, :turbolinks => false)
  end

  def internal_server_error
  	render(:status => 500, :turbolinks => false)
  end
end
