# == Schema Information
#
# Table name: categories
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

describe Category do
  let(:main_category) { FactoryGirl.create(:category) }

  subject { main_category }

  it { should be_valid }
  it { should respond_to(:name) }
  it { should respond_to(:products) }
  it { should respond_to(:photo) }

  it 'is invalid without a name' do
  	FactoryGirl.build(:category, name: nil).should_not be_valid
  end

  context 'when created/saved without logic order' do
    let!(:new_category) { FactoryGirl.create(:category, name: "Category 321") }
    let!(:other_category) { FactoryGirl.create(:category, name: "Category 2") }
    let!(:different_category) { FactoryGirl.create(:category, name: "Category 574") }

    it 'returns an ordered set of categories' do
      expect(Category.all.to_a).to eq([other_category, new_category, different_category])
    end
  end

  describe 'product associations' do
    let!(:category_without_products) { FactoryGirl.create(:category) }
    let!(:test_product) { FactoryGirl.create(:product, category: main_category) }
    let!(:test_product_2) { FactoryGirl.create(:product, category: main_category) }
    let!(:test_product_3) { FactoryGirl.create(:product, category: main_category) }

    it 'should destroy associated products' do
      products = main_category.products.to_a
      main_category.destroy
      expect(products).not_to be_empty
      products.each do |product|
        expect(Product.where(id: product.id)).to be_empty
      end
    end

    context 'when there arent products created' do
      it 'gets filtered from returned array' do
        expect(Category.with_products).to eq([main_category])
      end
    end
  end
end
