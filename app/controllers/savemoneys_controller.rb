class SavemoneysController < ApplicationController
  def create
    @results = MagasinProduit.getMeilleurPrix(current_user)
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end
end
