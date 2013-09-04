# == Schema Information
#
# Table name: news
#
#  id                 :integer          not null, primary key
#  title              :string(255)
#  message            :string(255)
#  order              :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#

require 'spec_helper'

describe New do
  pending "add some examples to (or delete) #{__FILE__}"
end
