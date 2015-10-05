require 'rails_helper'

feature 'Support announcement' do
  scenario 'User announces support' do
    visit root_path

    fill_in 'Vorname', with: 'Christoph'
    fill_in 'Nachname', with: 'Blocher'
    fill_in 'Strasse/Nr.', with: 'Wängirain 53'
    fill_in 'Postleitzahl', with: '8704'
    fill_in 'E-Mail', with: 'blocher@blocher.ch'
    fill_in 'E-Mail', with: 'blocher@blocher.ch'

    choose 'Ich unterschreibe eine Volksinitiative für die Freigabe von Cannabis und helfe aktiv Unterschriften in meiner Umgebung zu sammeln.'

    choose 'Ich bin über 64 Jahre alt'

    expect { click_button 'Unterstützung zusichern' }.to change { Supporter.count }.by(1)
  end
end
