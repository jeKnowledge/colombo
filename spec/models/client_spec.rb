require 'rails_helper'

RSpec.describe Client, type: :model do
  it { should validate_presence_of(:email) }
end
