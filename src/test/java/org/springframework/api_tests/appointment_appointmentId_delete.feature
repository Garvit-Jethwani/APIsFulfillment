# ********RoostGPT********

# Test generated by RoostGPT for test karate-vtal-appointment using AI Type Claude AI and AI Model claude-3-opus-20240229
# 
# Feature file generated for /appointment/{appointmentId}_delete for http method type DELETE 
# RoostTestHash=8ae4a840f9
# 
# 

# ********RoostGPT********
Feature: Delete Appointment API

  Background:
    * def urlBase = karate.properties['url.base'] || karate.get('urlBase', 'http://localhost:4010')
    * url urlBase
    * def AUTH_TOKEN = karate.properties['AUTH_TOKEN']

  Scenario Outline: Delete appointment with valid data
    Given path '/appointment/<appointmentId>'
    And param appointmentReason = '<appointmentReason>'
    And param appointmentComments = '<appointmentComments>'
    And header Authorization = AUTH_TOKEN
    When method DELETE
    Then status 200
    And match response.control.type == 'S'
    And match response.control.code == 200
    And match response.control.message == 'OK'

    Examples:
      | read('appointment_appointmentId_delete.csv') |

  Scenario: Delete appointment with invalid appointment ID
    Given path '/appointment/invalid-id'
    And param appointmentReason = 'Cancelamento Checkout'
    And header Authorization = AUTH_TOKEN
    When method DELETE
    Then status 400
    And match response.control.type == 'E'
    And match response.control.code == 400
    And match response.control.message == 'Bad Request'

  Scenario: Delete appointment without authorization token
    Given path '/appointment/SA-562403'
    And param appointmentReason = 'Cancelamento Checkout'
    When method DELETE
    Then status 401
    And match response.control.type == 'E'
    And match response.control.code == 401
    And match response.control.message == 'Unauthorized'

  Scenario: Delete appointment with forbidden scope
    Given path '/appointment/SA-562403'
    And param appointmentReason = 'Cancelamento Checkout'
    And header Authorization = 'invalid-token'
    When method DELETE
    Then status 403
    And match response.control.type == 'E'
    And match response.control.code == 403
    And match response.control.message == 'Forbidden - Scope Not Permitted'

  Scenario: Delete non-existent appointment
    Given path '/appointment/NA-123456'
    And param appointmentReason = 'Cancelamento Checkout'
    And header Authorization = AUTH_TOKEN
    When method DELETE
    Then status 404
    And match response.control.type == 'E'
    And match response.control.code == 404
    And match response.control.message == 'Not Found'
