class Supporter
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  ## Confirmable
  # field :confirmation_token,   type: String
  # field :confirmed_at,         type: Time
  # field :confirmation_sent_at, type: Time
  # field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time
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
