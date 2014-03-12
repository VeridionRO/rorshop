Feature: See Home Page
  In order to go to HomePage
  As a customer
  I need to go to the first page
  
  Scenario: See favorite products with images on HomePage
    Given I have products with images
    When I go to the HomePage
    Then I should see the products