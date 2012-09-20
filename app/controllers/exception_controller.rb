class ExceptionController < ApplicationController
  def show_error
    @exception = env["action_dispatch.exception"]
    @status_code     = ActionDispatch::ExceptionWrapper.new(env, @exception).status_code
    @rescue_response = ActionDispatch::ExceptionWrapper.rescue_responses[@exception.class.name]

    render :show_error, status: @status_code, layout: true
  end
end
