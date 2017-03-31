RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  #config.current_user_method(&:current_user)

  ## == Cancan ==
  #config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar true

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app
    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
  config.model 'Order' do
    list do
      field :aasm_state do
        label "Order State"
      end
      field :subtotal
      field :coupon
      field :user
      field :delivery
    end

    edit do
      field :aasm_state do
        label "Order State"
        partial 'order_form'
      end
      field :subtotal
      field :coupon
      field :user
      field :delivery
      field :order_items
    end
  end

  config.model 'Review' do
    edit do
      field :aasm_state do
        label "Review State"
        partial 'review_form'
      end
      field :title
      field :text_of_review
    end
  end

end
