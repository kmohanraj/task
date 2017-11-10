namespace :finance_rake do
	task :create => :environment do
		seed_finance
	end

	def seed_finance
		JSON.parse(open("#{Rails.root}/docs/finances.json").read).each do |finance_json|
			finance = Finance.new(finance_json)
			finance.save!
		end
	end
end