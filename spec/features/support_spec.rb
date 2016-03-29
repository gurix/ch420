require 'rails_helper'

feature 'Support announcement' do
  scenario 'User announces support' do
    allow_any_instance_of(SupportersController).to receive(:input_to_fast?).and_return(false)
    visit root_path

    fill_in 'Vorname', with: 'Christoph'
    fill_in 'Nachname', with: 'Blocher'
    fill_in 'Strasse/Nr.', with: 'Wängirain 53'
    fill_in 'Postleitzahl', with: '8704'
    fill_in 'Ort', with: 'Herrliberg'
    fill_in 'E-Mail', with: 'blocher@blocher.ch'
    fill_in 'Kommentar / Feedback', with: 'Test text'

    choose 'Ich unterschreibe eine Volksinitiative für die Legalisierung von Cannabis und helfe aktiv Unterschriften in meiner Umgebung zu sammeln.'

    choose 'Ich bin über 64 Jahre alt'

    check 'Ich bin interessiert an einer Mitgliedschaft beim Verein Legalize it! (50 Franken pro Jahr)'

    expect { click_button 'Unterstützung zusichern' }.to change { Supporter.count }.by(1)
    supporter = Supporter.find_by(email: 'blocher@blocher.ch')
    expect(supporter.coordinates).to eq [8.618589100000001, 47.2926304]
    expect(supporter.comments).to eq 'Test text'
    expect(supporter.language).to eq 'de'
    expect(supporter.li_membership).to eq true
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
