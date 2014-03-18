def has_header_menus
  page.find("#topmenu").should have_content("Acasa")
  page.find("#topmenu").should have_content("Magazin Online")
  page.find("#topmenu").should have_content("Special")
  page.find("#topmenu").should have_content("FAQ's")
  page.find("#topmenu").should have_content("Stiri")
  page.find("#topmenu").should have_content("Contact")
end

def check_product_cell_display product
  page.find("#product-cell-#{product.id}").should have_content(product.name)
  page.find("#product-cell-#{product.id}").should have_link(product.name)
  page.should have_xpath("//img[@src='/assets/#{product.image[:uri]}']")
end

def check_product_display product
  page.should have_content(product.name)
  page.should have_content(product.description)
  page.should have_xpath("//img[@src='/assets/#{product.image[:uri]}']")
  has_neighbours product
end

def has_neighbours product
  previous_neighbour = product.neighbour(:previous)
  next_neighbour = product.neighbour(:next)
  
  if previous_neighbour
    page.should have_xpath("//a[@href='/product/#{previous_neighbour.id}']")
  else
    page.should_not have_css('.previous_page')
  end

  if next_neighbour
    page.should have_xpath("//a[@href='/product/#{next_neighbour.id}']")
  else
    page.should_not have_css('.next_page')
  end
end