class Greenday
  include Mongoid::Document
  include Mongoid::Timestamps
  include Geocoder::Model::Mongoid
  include Mongoid::Paperclip

  before_save :delete_logo?

  has_mongoid_attached_file :logo,
                            path: ':attachment/:id/:style.:extension',
                            styles: {
                              original: ['1920x1680>', :jpg],
                              small:    ['100x100#',   :jpg],
                              medium:   ['250x250',    :jpg],
                              large:    ['500x500>',   :jpg]
                            },
                            convert_options: { all: '-background white -flatten +matte' }

  field :title, type: String
  field :address, type: String
  field :homepage, type: String
  field :description, type: String
  field :coordinates, type: Array

  geocoded_by :address
  after_validation :geocode # auto-fetch coordinates

  validates :title, presence: true
  validates :address, presence: true
  validates_attachment_content_type :logo, content_type: ['image/jpg', 'image/jpeg', 'image/png', 'image/gif']

  def delete_logo
    @delete_logo ||= '0'
  end

  attr_writer :delete_logo

  private

  def delete_logo?
    logo.clear if @delete_logo == '1'
  end
end
