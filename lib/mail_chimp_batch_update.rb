class MailChimpBatchUpdate
  def initialize(api_key, list_id)
    @mailchimp = Mailchimp::API.new(api_key)
    @list_id = list_id
  end

  def update_all
    subscribers = []

    Supporter.each_with_index do |supporter, index|
      subscribers.push(subscriber supporter)
      if index.modulo(20) == 0
        batch_subscribe(subscribers)
        subscribers = []
      end
    end

    batch_subscribe(subscribers)
  end

  def batch_subscribe(subscribers)
    @mailchimp.lists.batch_subscribe(@list_id, subscribers, false, true, false)
  end

  def subscriber(supporter)
    { 'EMAIL' => { 'email' => supporter.email }, 'language' => supporter.language, :EMAIL_TYPE => 'html',
      :merge_vars => {
        'EMAIL' => supporter.email,
        'FNAME' => supporter.first_name,
        'LNAME' => supporter.last_name,
        'SUPPORT' => supporter.support,
        'MEMBERSHIP' => supporter.li_membership.to_s,
        'AGE' => supporter.age_category,
        'LANG' => supporter.language,
        'ZIP' => supporter.zip } }
  end

  def update_unsubscibed
    unsubscribed_members = @mailchimp.lists.members(@list_id, 'unsubscribed', limit: 100)
    unsubscribed_members['data'].each do |member|
      Supporter.where(email: member['email']).each do |supporter|
        supporter.update_attributes unsubscribed: true
      end
    end
  end
end
