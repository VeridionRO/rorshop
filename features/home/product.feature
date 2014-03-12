Feature: See product
  In order to see a product
  As a customer
  I need to access the product's page

Scenario: Go to an existing product's page
  Given I have a valid product with a image
  And I go to that product's page
  Then I should see the product's details