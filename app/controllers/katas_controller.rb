class KatasController < InheritedResources::Base

  private

    def kata_params
      params.require(:kata).permit(:name)
    end
end

