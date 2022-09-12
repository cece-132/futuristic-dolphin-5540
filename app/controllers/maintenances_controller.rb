class MaintenancesController < ApplicationController
  def create
    maintenance_request = Maintenance.create(ride_id: params[:ride_id], mechanic_id: params[:mechanic_id])
    redirect_to mechanic_path(params[:mechanic_id])
  end
end