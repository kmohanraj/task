class FinancesController < ApplicationController
	before_action :set_new_finance, only: [:index]


	def index
        finances = Finance.search(params[:bill])
		finances = Finance.finance_expense if params[:bill] == "finance_expense"
		finances = Finance.today if params[:bill] == "today"
	    finances  = Finance.all if params[:bill].nil?
		@finances = finances.paginate(page: params[:page]).order("created_at DESC")
		respond_to do |format|
		format.html
		format.json {render json: @finances, status: :ok}
		end 
	end

	def search
    index
    render :index
  end

	def create
		@finance_created = Finance.new(name: params[:finance][:name], desc: params[:finance][:desc], category: params[:category].to_i, amount: params[:finance][:amount])
		# @finance_created = Finance.new(finance_params)
		respond_to do |format|
		  if @finance_created.save
			format.json {render json: @finance_created, status: :created}
			format.js
			format.html {redirect_to root_path, flash: {success: "Fiannce Saved Successfully"}}
		  else
			format.json {render json: @finance_created.errors.full_messages, status: :unprocessable_entity}
			format.js
			format.html {redirect_to fiannces_path, flash: {error: @finance_created.errors.full_messages}}
		  end
		end
	end


	private

	def finance_params(params)
		params.require(:finance).permit(:name, :desc, :amount, :category )
	end

	def set_new_finance
		@finance = Finance.new
	end
end
