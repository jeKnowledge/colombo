require 'rails_helper'

RSpec.describe User, type: :model do
  presence = [
    :email
  ]

  presence.each do |p|
    it { should validate_presence_of(p) }
  end
end
