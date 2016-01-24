Feature: Creating a job
  In order to offer for a job
  As a business owner
  I need a job posting web page

  Criteria of acceptance:
  - the form will have required fields that will ensure all jobs have the same fields completed
  - all fields will be validated
  - the job will have a predefined number of types available: Developer, Designer, Product Owner and Quality Assurance
  - the job will have a Position, a company, a text description and an email
  - the publish token should be created automatically, without user interaction

  Scenario: Publishing a job page
    Given I am on "/"
    When I press "Add new job"
    Then I am on "/new"

  Scenario Outline: Define job types
    Given I am on "/new"
    When I select "<type>" from "job[type]"
    Then I should see "<type>" in the "option" element
  Examples:
    | type              |
    | Developer         |
    | Designer          |
    | Product Owner     |
    | Quality Assurance |

  Scenario: New job formular
    Given I am on "/new"
    And I fill in the following:
      | job[position]    | PHP Developer      |
      | job[company]     | Jobeet Inc.        |
      | job[location]    | Bucharest, Romania |
      | job[description] | Lorem ipsum        |
      | job[type]        | Development        |
      | job[email]       | test@test.com      |
    When I press "Add new job"
    Then I should be on "/preview"
    And I should see "Preview new job:"
    And I should see "Check the email for confirmation" in the "div#flash" element

  @fixtures
  Scenario Outline: Approving a job
    Given I have a new job with the details:
      | position    | PHP Developer      |
      | company     | Jobeet Inc.        |
      | location    | Bucharest, Romania |
      | description | Lorem ipsum        |
      | type        | Development        |
      | email       | test@test.com      |
    And I am on "/token/<token>"
    When I press "Publish new job"
    Then I am on "/"
    And I should see "<token>" in the "i.token" element
  Examples:
    | token |
    | 1     |