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
  pending "add some examples to (or delete) #{__FILE__}"
end
