Feature: sample karate test script
  for help, see: https://github.com/karatelabs/karate/wiki/IDE-Support

  Background:
    * url 'https://jsonplaceholder.typicode.com'

  Scenario: get all users and then get the first user by id
    Given path 'users'
    When method get
    Then status 200

    * def first = response[0]

    Given path 'users', first.id
    When method get
    Then status 200

  Scenario: create a user and then get it by id
    * def user =
      """
      {
        "name": "Test User",
        "username": "testuser",
        "email": "test@user.com",
        "address": {
          "street": "Has No Name",
          "suite": "Apt. 123",
          "city": "Electri",
          "zipcode": "54321-6789"
        }
      }
      """

    Given url 'https://jsonplaceholder.typicode.com/users'
    And request user
    When method post
    Then status 201

    * def id = response.id
    * print 'created id is: ', id

    Given path id
    # When method get
    # Then status 200
    # And match response contains user

  Scenario: survey completion escapes reflected email input
    Given url 'http://localhost:8080/AltoroJ/survey_questions.jsp'
    And param step = 'a'
    And header Referer = 'http://localhost:8080/AltoroJ/survey_questions.jsp'
    When method get
    Then status 200

    And param step = 'b'
    And header Referer = 'http://localhost:8080/AltoroJ/survey_questions.jsp?step=a'
    When method get
    Then status 200

    And param step = 'c'
    And header Referer = 'http://localhost:8080/AltoroJ/survey_questions.jsp?step=b'
    When method get
    Then status 200

    And param step = 'd'
    And header Referer = 'http://localhost:8080/AltoroJ/survey_questions.jsp?step=c'
    When method get
    Then status 200

    And param step = 'email'
    And header Referer = 'http://localhost:8080/AltoroJ/survey_questions.jsp?step=d'
    When method get
    Then status 200

    * def payload = '<script>alert(1)</script>'
    And param step = 'done'
    And param txtEmail = payload
    And header Referer = 'http://localhost:8080/AltoroJ/survey_questions.jsp?step=email'
    When method get
    Then status 200
    And match response contains '&lt;script&gt;alert(1)&lt;/script&gt;'
    And match response !contains '<script>alert(1)</script>'
  
