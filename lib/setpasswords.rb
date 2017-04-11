helper = ApplicationController.helpers

never_signed_in = Supporter.where(sign_in_count: nil)
never_signed_in.each_with_index { |u, i| puts "#{i} #{u.email}"; u.update_attributes password: "#{u.support}#{helper.number_with_delimiter(u.zip, delimiter: ',')}" }
