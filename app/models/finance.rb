class Finance < ApplicationRecord

	before_validation :set_finance_date, on: :create

	enum category: [:income, :expense]
	ENUM_ENTITY = {"income" => 0, "expense" => 1}

	scope :finance_expense, -> { where(:category=>1) }
    scope :today, -> { where(:expense_date => Date.today, :category=>1)}
	scope :expense_date, -> { where("? BETWEEN startDate AND endDate", Date.today)}

	def set_finance_date
		self.expense_date = Date.today if self.expense_date.blank?
	end


	def self.search(bill)
	    if bill
	      where('expense_date LIKE ? ' , "%#{bill}%").having("finances.category = 1")
	    else
	      all
	    end
  	end
  	
end
