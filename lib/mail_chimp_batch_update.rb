class MailChimpBatchUpdate
  def self.update_all(api_key, list_id)
    subscribers = []
    mailchimp = Mailchimp::API.new(api_key)

    Supporter.each_with_index do |supporter, index|
      subscribers.push(subscriber supporter)
      if index.modulo(20) == 0
        mailchimp.lists.batch_subscribe(list_id, subscribers, false, true, false)
        subscribers = []
      end
    end

    mailchimp.lists.batch_subscribe(list_id, subscribers, false, true, false)
  end

  def self.subscriber(supporter)
    { 'EMAIL' => { 'email' => supporter.email }, 'language' => supporter.language, :EMAIL_TYPE => 'html',
      :merge_vars => {
        'EMAIL' => supporter.email,
        'FNAME' => supporter.first_name,
        'LNAME' => supporter.last_name,
        'SUPPORT' => supporter.support,
        'MEMBERSHIP' => supporter.li_membership.to_s,
        'AGE' => supporter.age_category,
        'LANG' => supporter.language
      } }
  end
end
