require 'rails_helper'

feature 'Support announcement' do
  scenario 'User announces support' do
    allow_any_instance_of(SupportersController).to receive(:input_to_fast?).and_return(false)
    visit root_path

    fill_in 'Vorname', with: 'Christoph'
    fill_in 'Nachname', with: 'Blocher'
    fill_in 'Strasse/Nr.', with: 'Wängirain 53'
    fill_in 'Postleitzahl', with: '8704'
    fill_in 'Ort', with: 'Hinterm Mond'
    fill_in 'E-Mail', with: 'blocher@blocher.ch'
    fill_in 'E-Mail', with: 'blocher@blocher.ch'

    choose 'Ich unterschreibe eine Volksinitiative für die Freigabe von Cannabis und helfe aktiv Unterschriften in meiner Umgebung zu sammeln.'

    choose 'Ich bin über 64 Jahre alt'

    expect { click_button 'Unterstützung zusichern' }.to change { Supporter.count }.by(1)
  end

  scenario 'A bot tries to enter data' do
    visit root_path

    click_button 'Unterstützung zusichern'

    expect(page).to have_content 'Ihre Eingabe war zu schnell.'
    
    # Test twice just to be sure that it's not become an update action
    click_button 'Unterstützung zusichern'

    expect(page).to have_content 'Ihre Eingabe war zu schnell.'
  end
end
