require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('Project #update, #save, #delete', {:type => :feature}) do
  it('adds project, adds volunteer, clicks on project, adds volunteer to project, changes project name, deletes project') do
    visit('/')
    fill_in('project', :with => 'abcdefg')
    click_button('Add Project')
    expect(page).to have_content('abcdefg')
    fill_in('volunteer', :with => 'ben')
    click_button('Add Volunteer')
    expect(page).to have_content('ben')
    click_link('abcdefg')
    expect(page).to have_content('abcdefg')
    expect(page).to have_content('ben')
    check 'ben'
    click_button 'Update Project'
    fill_in 'name', :with => 'test'
    click_button 'Update Project'
    expect(page).to have_content 'test'
  end
end
