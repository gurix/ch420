require 'rails_helper'

feature 'Publicity' do
  let(:supporter) { create :supporter, first_name: 'Hans', last_name: 'Muster' }
  let(:admin) { create :supporter, admin: true }
  
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

  scenario 'non admin users cannot manage pending publicities' do
      visit admin_publicities_path
      expect(page.status_code).to eq 403
  end
  context 'management' do
    
    
    before { sign_in(admin) }
    
    scenario 'an administrator approves a pending announcement' do
      create :publicity, state: :pending, supporter: supporter

      # Already declined, so we don't list it'
      create :publicity, state: :declined, supporter: create(:supporter, first_name: 'Donald', last_name: 'Trump') 
      
      visit admin_publicities_path

      expect(page).to have_content 'Hans Muster'
      expect(page).not_to have_content 'Donald Trump'

      click_link 'Bearbeiten'

      fill_in 'Organisation', with: 'Free Hemp Association'
      fill_in 'Statement', with: 'Marihuana ist die Heilung der Nation, Alkohol die Zerstörung.'
      attach_file('publicity_avatar', "#{Rails.root}/spec/support/fixtures/image.jpg")
      choose 'Das Statement wurde Veröffentlicht'
      
      click_button 'Speichern'

      expect(page).not_to have_content 'Hans Muster'
    end
  end
end