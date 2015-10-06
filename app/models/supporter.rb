class Supporter
  include Mongoid::Document
  include Mongoid::Timestamps
  include Geocoder::Model::Mongoid

  geocoded_by :address
  after_validation :geocode          # auto-fetch coordinates

  field :first_name,   type: String
  field :last_name,    type: String
  field :street,       type: String
  field :zip,          type: Integer
  field :city,         type: String
  field :email,        type: String
  field :support,      type: String # Indicates the type of support
  field :age_category, type: String
  field :coordinates,  type: Array

  validates :first_name,   presence: true
  validates :last_name,    presence: true
  validates :street,       presence: true
  validates :zip,          presence: true
  validates :city,         presence: true
  validates :email,        presence: true, uniqueness: true
  validates :support,      presence: true
  validates :age_category, presence: true

  def address
    "#{street}, #{zip}, #{city}, Switzerland"
  end
end
