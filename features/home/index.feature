Feature: See Home Page
	In order to go to HomePage
	As a customer
	I need to go to the first page

	Scenario: See favorite products to the first page
		Given I have the following products:
		| name       | description    |
	    | Product 10 | Description 10 |
	    | Product 1  | Description 1  |
	    | Product 2  | Description 2  |
	    | Product 3  | Description 3  |
	    | Product 4  | Description 4  |
	    | Product 5  | Description 5  |
	    | Product 6  | Description 6  |
	    | Product 7  | Description 7  |
	    | Product 8  | Description 8  |
	    | Product 9  | Description 9  |
		And I go to the HomePage
		Then I should see the last 9 products
	
	Scenario: See Header buttons
		Given I go to the HomePage
		Then I should see the Header buttons