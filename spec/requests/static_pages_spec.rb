require 'spec_helper'

describe "Static pages" do

  describe "Home page" do

    it "should have the content 'Science Game Reviews'" do
      visit '/static_pages/home'
      page.should have_content('Science Game Reviews')
    end
  end

  describe "About page" do

    it "should have the content 'About'" do
      visit '/static_pages/about'
      page.should have_content('About')
    end
  end

  describe "Contact page" do

    it "should have the content 'Contact'" do
      visit '/static_pages/contact'
      page.should have_content('Contact')
    end
  end

  describe "Privacy page" do

    it "should have the content 'Privacy'" do
      visit '/static_pages/privacy'
      page.should have_content('Privacy')
    end
  end
end