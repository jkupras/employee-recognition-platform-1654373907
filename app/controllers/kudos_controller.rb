class KudosController < ApplicationController
  before_action :set_kudo, only: %i[show edit update destroy]

  def index
    @kudos = Kudo.all
  end

  def show; end

  def new
    @kudo = Kudo.new
    @emails = Employee.pluck(:email)
  end

  def edit; end

  def create
    @kudo = Kudo.new(kudo_params)
    @kudo.giver = current_employee

    if @kudo.save
      redirect_to kudos_path, notice: 'Kudo was successfully created.'
    else
      render :new
    end
  end

  def update
    if @kudo.update(kudo_params)
      redirect_to @kudo, notice: 'Kudo was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @kudo.destroy
    redirect_to kudos_url, notice: 'Kudo was successfully destroyed.'
  end

  private

  def set_kudo
    @kudo = Kudo.find(params[:id])
  end

  def kudo_params
    params.require(:kudo).permit(:title, :content, :receiver_id)
  end
end
