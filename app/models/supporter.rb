class Supporter
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia
  include Geocoder::Model::Mongoid

  COUNTER_START = 10_003

  geocoded_by :address
  after_validation :geocode          # auto-fetch coordinates

  field :first_name,    type: String
  field :last_name,     type: String
  field :street,        type: String
  field :zip,           type: Integer
  field :city,          type: String
  field :email,         type: String
  field :support,       type: String # Indicates the type of support
  field :li_membership, type: Boolean, default: false
  field :age_category,  type: String
  field :coordinates,   type: Array
  field :comments,      type: String
  field :language,      type: String
  field :unsubscribed,  type: Boolean, default: false
  field :duplicate,     type: Boolean, default: false

  validates :first_name,   presence: true
  validates :last_name,    presence: true
  validates :street,       presence: true
  validates :zip,          presence: true
  validates :city,         presence: true
  validates :email,        presence: true, uniqueness: true, format: /.+@.+\..+/i
  validates :support,      presence: true
  validates :age_category, presence: true
  validates :language,     presence: true

  def self.counter
    actual = count.to_i
    actual > COUNTER_START ? actual : COUNTER_START
  end

  def address
    "#{street}, #{zip}, #{city}, Switzerland"
  end
end
