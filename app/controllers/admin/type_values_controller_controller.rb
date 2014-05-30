class Admin::TypeValuesControllerController < ApplicationController
  def create
    @type_value = TypeValue.new(type_values_params)
    if @type_value.save
      flash[:success] = 'Valoarea a fost salvat'
    else
      flash[:error] = 'Valoarea nu a fost salvat'
    end
    path = "/admin/types/#{params[:type_value][:type_id]}/edit"
    render :js => "window.location = \"#{path}\""
  end

  private

    def type_values_params
      params.require(:type_value).permit(:type_id, :value)
    end
end
