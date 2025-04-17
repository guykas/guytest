
Feature: sample karate test script
    for help, see: https://github.com/karatelabs/karate/wiki/IDE-Support
  
    Background:
      * url 'https://reqres.in'
  
    Scenario: get all users and then get the first user by id
      Given path '/api/users/2'
      When method get
      Then status 200    

