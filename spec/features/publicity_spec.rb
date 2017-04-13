require 'rails_helper'

feature 'Publicity' do
  let(:supporter) { create :supporter }
  
  before { sign_in(supporter) }

  scenario 'User makes his announcement public' do
    visit root_path
    
    click_link 'Meine Unterstützung öffentlich kundtun ...'
    
    fill_in 'Organisation', with: 'Schweizer Volkspartei'
    fill_in 'Statement', with: 'Wir wollen ja eigentlich nur das Volk verarschen ;)'
    
    attach_file('publicity_avatar', "#{Rails.root}/spec/support/fixtures/image.jpg")
    
    click_button 'Zur Überprüfung einsenden'
    
    expect(page).to have_content 'Besten Dank die Daten werden überprüft.'
  end

  scenario 'User makes changes announcement' do

    create :publicity, supporter: supporter

    visit root_path
    
    click_link 'Statement neu einreichen'
    
    fill_in 'Organisation', with: 'Schweizer Volkspartei'
    fill_in 'Statement', with: 'Wir wollen ja eigentlich nur das Volk verarschen ;)'
    
    attach_file('publicity_avatar', "#{Rails.root}/spec/support/fixtures/image.jpg")
    
    click_button 'Zur Überprüfung einsenden'
    
    expect(page).to have_content 'Besten Dank die Daten werden überprüft.'
    expect(page).to have_content 'Die Veröffentlichung wurde noch nicht genehmigt'
  end
end