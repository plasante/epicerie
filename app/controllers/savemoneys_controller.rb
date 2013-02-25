class SavemoneysController < ApplicationController
  def create
    @results = MagasinProduit.all(:limit => 3)
    @results2 = ListeItem.getMeilleurPrix(current_user)
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end
end
