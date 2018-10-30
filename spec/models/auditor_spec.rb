require 'rails_helper'

RSpec.describe Auditor, type: :model do
  presence = [
    :rating,
    :qualifications,
    :cv
  ]

  presence.each do |p|
    it { should validate_presence_of(p) }
  end
end
