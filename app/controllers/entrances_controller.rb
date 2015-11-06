class EntrancesController < InheritedResources::Base

  private

    def entrance_params
      params.require(:entrance).permit(:name, :description)
    end
end

