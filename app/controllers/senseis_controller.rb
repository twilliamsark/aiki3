class SenseisController < InheritedResources::Base

  private

    def sensei_params
      params.require(:sensei).permit(:name)
    end
end

