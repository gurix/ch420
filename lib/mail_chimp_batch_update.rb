class MailChimpBatchUpdate
  def self.update_all(api_key, list_id)
    subscribers = []
    Supporter.each do |supporter|
      subscriber = {
        'EMAIL' => { 'email' => supporter.email },
        'language' => supporter.language,
        :EMAIL_TYPE => 'html',
        :merge_vars => {
          'EMAIL' => supporter.email,
          'FNAME' => supporter.first_name,
          'LNAME' => supporter.last_name,
          'SUPPORT' => supporter.support,
          'MEMBERSHIP' => supporter.li_membership.to_s,
          'AGE' => supporter.age_category,
          'LANG' => supporter.language
        }
      }
      subscribers.push(subscriber)
    end

    mailchimp = Mailchimp::API.new(api_key)
    mailchimp.lists.batch_subscribe(list_id, subscribers, false, true, false)
  end
end
