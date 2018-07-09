require 'rails_helper'
require 'support/universe'
require 'pp'

RSpec.describe Sector, type: :model do
  before :all do
    create_closed_universe
  end

  after :all do
    Universe.destroy
  end
end
