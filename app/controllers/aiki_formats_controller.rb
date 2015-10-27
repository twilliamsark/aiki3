class AikiFormatsController < InheritedResources::Base

  private

    def aiki_format_params
      params.require(:aiki_format).permit(:name, :description)
    end
end

