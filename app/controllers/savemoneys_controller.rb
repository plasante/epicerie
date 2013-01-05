class SavemoneysController < ApplicationController
  def create
    @result = "Yo"
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end
end
