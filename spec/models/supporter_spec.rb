require 'rails_helper'

describe Supporter do
  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:last_name) }
  it { is_expected.to validate_presence_of(:street) }
  it { is_expected.to validate_presence_of(:zip) }
  it { is_expected.to validate_presence_of(:city) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email) }
  it { is_expected.to validate_presence_of(:support) }
  it { is_expected.to validate_presence_of(:age_category) }
  it { is_expected.to validate_presence_of(:language) }

  describe '.counter' do
    it 'counts only from a certain number on' do
      allow(Supporter).to receive(:count)  { 12 }

      expect(Supporter.counter).to eq Supporter::COUNTER_START

      allow(Supporter).to receive(:count)  { Supporter::COUNTER_START + 12 }

      expect(Supporter.counter).to eq Supporter::COUNTER_START + 12
    end
  end
end
