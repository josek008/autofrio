FactoryGirl.define do
	factory :brand do
		sequence(:name) { |n| "Brand #{n}" }
	end

	factory :line do
		sequence(:name) { |n| "Line #{n}" }
		brand
	end

	factory :category do
		sequence(:name) { |n| "Category #{n}" }
	end

	factory :product do
		comments "Lorem ipsum"
		sequence(:reference) { |n| "Reference #{n}" }
		category
		lines { [create(:line)] }
	end

end