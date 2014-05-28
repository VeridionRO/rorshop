class Admin::TypeValuesControllerController < ApplicationController
  def create
    @type_value = TypeValue.new(type_values_params)
    if @type_value.save

    else
      
    end
  end

  private

    def type_values_params
      params.require(:type_value).permit(:type_id, :value)
    end
end
