module Admins
  class KudosController < ApplicationController
    before_action :set_kudo, only: %i[show destroy]

    def index
      @kudos = Kudo.all
    end

    def show; end

    def destroy
      @kudo.destroy
      redirect_to admins_kudos_path, notice: 'Kudo was successfully destroyed.'
    end

    private

    def set_kudo
      @kudo = Kudo.find(params[:id])
    end
  end
end
