require 'spec_helper'

describe "Static pages" do

  subject { page }

  describe "Home page" do
    before { visit root_path }

    it { should have_selector('h1',    text: 'Science Game Reviews') }
    it { should have_selector('title', text: full_title('Helping to bring science games to the classroom')) }
    it { should_not have_selector 'title', text: '| Home' }
  end

  describe "About page" do
    before { visit about_path }

    it { should have_selector('h1',    text: 'About') }
    it { should have_selector('title', text: full_title('About')) }
  end

  describe "Contact page" do
    before { visit contact_path }

    it { should have_selector('h1',    text: 'Contact') }
    it { should have_selector('title', text: full_title('Contact')) }
  end

  describe "Privacy page" do
    before { visit privacy_path }

    it { should have_selector('h1',    text: 'Privacy') }
    it { should have_selector('title', text: full_title('Privacy')) }
  end
end