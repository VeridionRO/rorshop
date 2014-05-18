require 'spec_helper'

describe "GET /admin/products/new" do

  it "displays name, description and price" do
    visit new_admin_product_path
    page.should have_content('Nume')
    page.should have_content('Descriere')
    page.should have_content('Pret')
    page.should have_content('Imagine')
    page.should have_xpath('//input[@value="Salveaza"]')
  end

  it "saves the product to the database" do
    visit new_admin_product_path
    fill_in "Nume", with: "Nume_Produs"
    fill_in "Descriere", with: "Descriere_Produs"
    fill_in "Pret", with: 21.31
    click_button "Salveaza"
    page.should have_content('Nume_Produs')
    page.should have_content('Descriere_Produs')
    page.should have_content(21.31)
    page.should have_content('Produsul a fost salvat')
  end

end
