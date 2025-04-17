@guy
Feature: sample karate test script
for help, see: https://github.com/karatelabs/karate/wiki/IDE-Support

    Background:
    * url 'https://conduit-api.bondaracademy.com/api/tags'

    Scenario: get all users and then get the first user by id
     Given url 'https://conduit-api.bondaracademy.com/api/tags'
     When method get
     Then status 200
