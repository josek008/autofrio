# == Schema Information
#
# Table name: lines
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  photo_file_name    :string(255)
#  photo_content_type :string(255)
#  photo_file_size    :integer
#  photo_updated_at   :datetime
#  brand_id           :integer
#

require 'spec_helper'

describe Line do
  let(:new_line) { FactoryGirl.create(:line) }
  
  subject { new_line }

  it { should be_valid }
  it { should respond_to(:name) }
  it { should respond_to(:brand) }
  it { should respond_to(:large_name) }
  it { should respond_to(:photo) }

  it 'is invalid without a name' do
  	FactoryGirl.build(:line, name: nil).should_not be_valid
  end

  describe 'associations' do
  	let!(:cool_brand) { FactoryGirl.create(:brand, name: 'Renault') }
  	let!(:better_brand) { FactoryGirl.create(:brand, name: 'Suzuki') }
  	let!(:line_with_products) { FactoryGirl.create(:line, name: 'Logan', brand: cool_brand) }
  	let!(:line_without_products) { FactoryGirl.create(:line, name: 'Grand Vitara', brand: better_brand) }
		let!(:test_product) { FactoryGirl.create(:product, lines: [line_with_products]) }
		let!(:test_product_2) { FactoryGirl.create(:product, lines: [line_with_products]) }
		let!(:test_product_3) { FactoryGirl.create(:product, lines: [line_with_products]) }

  	it 'returns a large name including parents name' do
  		expect(new_line.large_name).to eq("#{new_line.brand.name} - #{new_line.name}")
  	end

  	it 'returns a set of lines ordered by parents names' do
  		expect(Line.ordered_by_brand_name).to eq([line_with_products, line_without_products])
  	end

  	it 'returns a set of lines ordered by its names' do
  		expect(Line.ordered_by_name).to eq([line_without_products, line_with_products])
  	end

    it 'is invalid without a brand' do
      FactoryGirl.build(:line, brand: nil).should_not be_valid
    end

  	context 'when deleting a line' do
  		it 'should destroy any link to associated products' do
  			products = line_with_products.products.to_a
  			line_with_products.destroy
  			expect(products).not_to be_empty
  			products.each do |product|
  				expect(product.lines).not_to include(line_with_products)
  			end
  		end
  	end

  	context 'when there arent products created' do
  		it 'gets filtered from returned array' do
  			expect(Line.with_products).to eq([line_with_products])
  		end
  	end
  end

end
