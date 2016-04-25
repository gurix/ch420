RailsAdmin.config do |config|
  config.authorize_with do
    unless Rails.env.development?
      authenticate_or_request_with_http_basic('Administration') do |username, password|
        username == 'admin' && password == ENV['ADMIN_PASSWORD']
      end
    end
  end

  config.model 'Supporter' do
    configure :full_address do
      pretty_value do
        util = bindings[:object]
        %(#{util.first_name} #{util.last_name}
        <br/>
        #{util.street} <br/>
        #{util.zip} #{util.city}).html_safe
      end
      children_fields [:first_name, :last_name, :street, :zip, :city] # will be used for searching/filtering, first field will be used for sorting
      read_only true # won't be editable in forms (alternatively, hide it in edit section)
    end

    list do
      field :duplicate
      field :full_address
      field :email
      field :language
      field :support
      field :li_membership do
        label do
          'Member'
        end
      end
      field :first_name
      field :last_name
      field :street
      field :zip
      field :city
      field :created_at
      field :updated_at
    end
  end

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    # export
    # bulk_delete
    show
    edit
    delete
    # show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
