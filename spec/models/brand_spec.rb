# == Schema Information
#
# Table name: brands
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  photo_file_name    :string(255)
#  photo_content_type :string(255)
#  photo_file_size    :integer
#  photo_updated_at   :datetime
#

require 'spec_helper'

describe Brand do
	let(:main_brand) { FactoryGirl.create(:brand) }
	let(:line_under_main_brand) { FactoryGirl.create(:line, brand: main_brand) }

	subject { main_brand }

	it { should be_valid }
	it { should respond_to(:name) }
	it { should respond_to(:lines) }
	it { should respond_to(:products) }
	it { should respond_to(:photo) }

	it 'is invalid without a name' do
		FactoryGirl.build(:brand, name: nil).should_not be_valid
	end

	context 'when created/saved without logic order' do
		let!(:new_brand) { FactoryGirl.create(:brand, name: "Brand 321") }
		let!(:other_brand) { FactoryGirl.create(:brand, name: "Brand 2") }
		let!(:different_brand) { FactoryGirl.create(:brand, name: "Brand 574") }

		it 'returns an ordered set of brands' do
			expect(Brand.all.to_a).to eq([other_brand, new_brand, different_brand])
		end
	end

	describe 'associations' do
		let!(:brand_without_products) { FactoryGirl.create(:brand) }
		let!(:test_product) { FactoryGirl.create(:product, lines: [line_under_main_brand]) }
		let!(:test_product_2) { FactoryGirl.create(:product, lines: [line_under_main_brand]) }
		let!(:test_product_3) { FactoryGirl.create(:product, lines: [line_under_main_brand]) }

		context 'when there arent products created' do
			it 'gets filtered from returned array' do
				expect(Brand.with_products).to eq([main_brand])
			end
		end

		context 'when deleting a brand' do
			it 'should destroy associated lines' do
				lines = main_brand.lines.to_a
				main_brand.destroy
				expect(lines).not_to be_empty
				lines.each do |line|
					expect(Line.where(id: line.id)).to be_empty
				end
			end

			it 'should destroy any link to associated products' do
				products = main_brand.products.to_a
				main_brand.destroy
				expect(products).not_to be_empty
				products.each do |product|
					expect(product.brands.to_a).not_to include(main_brand)
				end
			end
		end
	end
end
