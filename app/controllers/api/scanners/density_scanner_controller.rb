class Api::Scanners::DensityScannerController < ApplicationController

  def density
    service = DensityScanService.call(current_user, Sector.find(density_scan_params[:id]))
    if service.success?
      render json: service.result
    else
      render json: service.errors
    end
  end

  def holoscan

  end

  private
   
    def density_scan_params
      params.permit(:id)
    end

end
