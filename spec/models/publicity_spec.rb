require 'rails_helper'

describe Publicity do
  it { is_expected.to be_embedded_in(:supporter) }

  it { is_expected.to validate_presence_of(:state) }
  it { is_expected.to validate_presence_of(:statement) }
  it { is_expected.to validate_presence_of(:avatar) }
end
