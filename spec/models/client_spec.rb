require 'rails_helper'

RSpec.describe Client, type: :model do
  presence = [
    :address,
    :company
  ]

  presence.each do |p|
    it { should validate_presence_of(p) }
  end
end
