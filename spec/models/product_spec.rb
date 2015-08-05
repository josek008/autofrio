# == Schema Information
#
# Table name: products
#
#  id                 :integer          not null, primary key
#  comments           :string(255)
#  reference          :string(255)
#  category_id        :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  photo_file_name    :string(255)
#  photo_content_type :string(255)
#  photo_file_size    :integer
#  photo_updated_at   :datetime
#

require 'spec_helper'

describe Product do
	let(:product) { FactoryGirl.create(:product) }

	subject { product }

	it { should be_valid }
	it { should respond_to(:comments) }
	it { should respond_to(:reference) }
	it { should respond_to(:photo) }
	it { should respond_to(:category) }
	it { should respond_to(:lines) }
	it { should respond_to(:brands) }

	it 'is invalid with comments exceeding 200 characters' do
		FactoryGirl.build(:product, comments: "#{'a'*300}").should_not be_valid
	end

	it 'is invalid with a reference exceeding 100 characters' do
		FactoryGirl.build(:product, reference: "#{'a'*200}").should_not be_valid
	end

	it 'is invalid without comments' do
		FactoryGirl.build(:product, comments: nil).should_not be_valid
	end

	it 'is invalid without a reference' do
		FactoryGirl.build(:product, reference: nil).should_not be_valid
	end

	it 'is valid when comments are less than 200 characters' do
		FactoryGirl.build(:product, comments: "#{'a'*200}").should be_valid
	end

	it 'is valid with a reference less than 100 characters' do
		FactoryGirl.build(:product, reference: "#{'a'*100}").should be_valid
	end

	describe '.search_with' do
		let!(:uppercase_category) { FactoryGirl.create(:category, name: "COMPRESORES") }
		let!(:lowcase_brand) { FactoryGirl.create(:brand, name: "renault") }
		let!(:mixedcase_line) { FactoryGirl.create(:line, name: "LoGaN", brand: lowcase_brand) }
		let!(:product_one) { FactoryGirl.create(:product, reference: "ReFerencIa", comments: "comenTarios", category: uppercase_category, lines: [mixedcase_line]) }
		let!(:product_two) { FactoryGirl.create(:product, reference: "refErencia 2", comments: "comentarios 2") }

		context 'with case-insensitive input search' do
			it 'returns a set of products' do
				expect(Product.search_with("RenA")).to eq([product_one])
				expect(Product.search_with("log")).to eq([product_one])
				expect(Product.search_with("comPresorEs")).to eq([product_one])
			end
		end
	end

	describe 'associations' do

		let!(:new_line) { FactoryGirl.create(:line, products: [product]) }
		let!(:another_line) { FactoryGirl.create(:line, products: [product]) }
		let!(:third_line) { FactoryGirl.create(:line, products: [product]) }

		it 'is invalid without a category' do
			FactoryGirl.build(:product, category: nil).should_not be_valid
		end

		it 'is invalid without applicable lines' do
			FactoryGirl.build(:product, lines: []).should_not be_valid
		end

		context 'when deleting a product' do
			it 'should destroys any link with applicable lines' do
				lines = product.lines.to_a
				product.destroy
				expect(lines).not_to be_empty
				lines.each do |line|
					expect(line.products).not_to include(product)
				end
			end
		end

		context 'when filtering' do
			let!(:pretty_category) { FactoryGirl.create(:category) }
			let!(:brand_one) { FactoryGirl.create(:brand, name: "Kia") }
			let!(:brand_two) { FactoryGirl.create(:brand, name: "Hummer") }
			let!(:brand_three) { FactoryGirl.create(:brand, name: "Alfa Romeo") }
			let!(:line_one) { FactoryGirl.create(:line, name: "Picanto", brand: brand_one) }
			let!(:line_two) { FactoryGirl.create(:line, name: "H5", brand: brand_one) }
			let!(:line_three) { FactoryGirl.create(:line, name: "Codensa", brand: brand_one) }
			let!(:line_four) { FactoryGirl.create(:line, name: "Cerato", brand: brand_two) }
			let!(:line_five) { FactoryGirl.create(:line, name: "Sportage", brand: brand_three) }
			let!(:new_product) { FactoryGirl.create(:product, category: pretty_category, lines: [line_one, line_two, line_three, line_four, line_five]) }

			describe '.filtered_by' do

				it 'returns a set of products when using category filter only' do
					options = { category: pretty_category.id }
					expect(Product.filtered_by(options)).to eq([new_product])
				end

				it 'returns a set of products when using brand filter only' do
					options = { brand: brand_one.id }
					expect(Product.filtered_by(options)).to eq([new_product])
				end

				it 'returns a set of products when using line filter only' do
					options = { line: line_one.id }
					expect(Product.filtered_by(options)).to eq([new_product])
				end

				it 'returns a set of products with all possible filters present' do
					options = { category: pretty_category.id, brand: brand_one.id, line: line_one.id }			
					expect(Product.filtered_by(options)).to eq([new_product])
				end
			end

			describe '.available_filters' do

				context 'with BRANDS option' do
					it 'returns an ordered set of brands for this group of products' do
						options = { category: pretty_category.id, return_brands: true }
						expect(Product.available_filters(options)).to eq([brand_three, brand_two, brand_one])
					end
				end

				context 'with LINES option' do
					it 'returns an orderet set of lines for this group of products' do
						options = { category: pretty_category.id, brand: brand_one.id, return_lines: true }
						expect(Product.available_filters(options)).to eq([line_three, line_two, line_one])
					end
				end
			end
		end
	end
end
