require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:name) }
  it { should validate_length_of(:name).is_at_most(50) }
  it { should validate_length_of(:email).is_at_most(244) }
  it { should allow_value('a@a.com', '12@12.c').for(:email) }
  it { should_not allow_value('a@a', '1', 'a.a').for(:email) }
end
