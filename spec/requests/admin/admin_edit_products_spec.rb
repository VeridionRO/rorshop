require 'spec_helper'

describe "Admin::EditProducts" do
  describe "GET /admin_edit_products" do
    it "works! (now write some real specs)" do
      product = FactoryGirl.create(:product)
      visit "/admin/products/#{product.id}/edit"
      
      page.should have_content('Nume')
      page.should have_content('Descriere')
      page.should have_content('Pret')

      find_field('product_name').value.should eq(product.name)
      find_field('product_description').value.should eq(product.description)
      find_field('product_price').value.should eq(product.price.to_s)

      fill_in "Nume", with: "Nume_Produs 2"
      fill_in "Descriere", with: "Descriere_Produs 2"
      fill_in "Pret", with: 31.31
      click_button "Salveaza"

      page.should have_content('Nume_Produs 2')
      page.should have_content('Descriere_Produs 2')
      page.should have_content(31.31)
      page.should have_content('Produsul a fost salvat')
    end
  end
end