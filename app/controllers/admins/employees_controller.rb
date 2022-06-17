module Admins
  class EmployeesController < ApplicationController
    before_action :set_employee, only: %i[edit update destroy]

    def index
      @employees = Employee.all
    end

    def edit; end

    def update
      if params[:employee][:password].blank? && params[:employee][:password_confirmation].blank?
        params[:employee].delete(:password)
        params[:employee].delete(:password_confirmation)
      end

      if @employee.update(employee_params)
        redirect_to admins_employees_path, notice: 'Employee was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @employee.destroy
      redirect_to admins_employees_path, notice: 'Employee was successfully destroyed.'
    end

    private

    def set_employee
      @employee = Employee.find(params[:id])
    end

    def employee_params
      params.require(:employee).permit(:email, :number_of_available_kudos, :password, :password_confirmation)
    end
  end
end
