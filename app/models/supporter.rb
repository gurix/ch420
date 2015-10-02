class Supporter
  include Mongoid::Document

  field :first_name, type: String
  field :last_name,  type: String
  field :street,     type: String
  field :zip,        type: Integer
  field :email,      type: String
  field :support,    type: String # Indicates the type of support
  field :votable,    type: Boolean

  field :age_category, type: String

  validates :email,   presence: true, uniqueness: true
  validates :support, presence: true
end
