Feature: See Home Page
	In order to go to HomePage
	As a customer
	I need to go to the first page

	Scenario: See Header buttons
		Given I go to the HomePage
		Then I should see the Header buttons

	Scenario: See favorite products to the first page
		Given I have the following products:
		| name      | description   | price   |
    | Product 1 | Description 1 | $99.99  |
    | Product 2 | Description 2 | $100.00 |
    | Product 3 | Description 3 | $99.99  |
    | Product 4 | Description 4 | $99.99  |
		And I go to the HomePage
		Then I should see the favorite products