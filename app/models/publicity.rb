class Publicity
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip

  has_mongoid_attached_file :avatar,
                            path: ':attachment/:id/:style.:extension',
                            styles: {
                              original: ['1920x1680>', :jpg],
                              small:    ['100x100#',   :jpg],
                              medium:   ['250x250',    :jpg],
                              large:    ['500x500>',   :jpg]
                            },
                            convert_options: { all: '-background white -flatten +matte' }

  embedded_in :supporter

  field :state, type: String, default: 'pending' # Possible states: pending, approved
  field :organisation, type: String
  field :statement, type: String

  validates :state,     presence: true
  validates :avatar,    presence: true
  validates :statement, presence: true
  validates_attachment_content_type :avatar, content_type: /\Aimage/
end
