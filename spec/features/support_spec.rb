require 'rails_helper'

feature 'Support' do
  scenario 'User announces support' do
    visit root_path

    fill_in 'Vorname', with: 'Christoph'
    fill_in 'Nachname', with: 'Blocher'
    fill_in 'Strasse/Nr.', with: 'Wängirain 53'
    fill_in 'Postleitzahl', with: '8704'
    fill_in 'Ort', with: 'Herrliberg'
    fill_in 'E-Mail', with: 'blocher@blocher.ch'
    fill_in 'Kommentar / Feedback', with: 'Test text'

    choose 'Ich würde eine Volksinitiative für die Legalisierung von Cannabis unterschreiben und helfe aktiv Unterschriften in meiner Umgebung zu sammeln.'

    choose 'Ich bin über 64 Jahre alt'

    check 'Ich bin interessiert an einer Mitgliedschaft beim Verein Legalize it! (50 Franken pro Jahr)'

    sleep 5 # Do a real sleep to have a real integration test

    expect(ActionMailer::Base.deliveries.count).to eq 0
    expect_any_instance_of(SupportersController).to receive(:mailchimp_registration).and_return(true)

    expect { click_button 'Unterstützung zusichern' }.to change { Supporter.count }.by(1)
    # expect(ActionMailer::Base.deliveries.count).to eq 1
    supporter = Supporter.find_by(email: 'blocher@blocher.ch')
    expect(supporter.coordinates).to eq [8.618589100000001, 47.2926304]
    expect(supporter.comments).to eq 'Test text'
    expect(supporter.language).to eq 'de'
    expect(supporter.li_membership).to eq true
  end

  scenario 'A bot tries to enter data' do
    stub_const('ApplicationController::INPUT_TIMEOUT', 600.seconds)

    visit root_path

    click_button 'Unterstützung zusichern'

    expect(page).to have_content 'Ihre Eingabe war zu schnell.'

    # Test twice just to be sure that it's not become an update action
    click_button 'Unterstützung zusichern'

    expect(page).to have_content 'Ihre Eingabe war zu schnell.'
  end
end
