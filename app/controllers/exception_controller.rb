class ExceptionController < ApplicationController
  def not_found
    @exception = env["action_dispatch.exception"]
    
  end
end
