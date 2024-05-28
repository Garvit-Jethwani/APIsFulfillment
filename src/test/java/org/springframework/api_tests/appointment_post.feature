# ********RoostGPT********

# Test generated by RoostGPT for test karate-vtal-appointment using AI Type Claude AI and AI Model claude-3-opus-20240229
# 
# Feature file generated for /appointment_post for http method type POST 
# RoostTestHash=b7eaf9bc25
# 
# 

# ********RoostGPT********
Feature: Test /appointment endpoint

  Background:
    * def urlBase = karate.properties['url.base'] || karate.get('urlBase', 'http://localhost:4010')
    * url urlBase
    * def authToken = karate.properties['AUTH_TOKEN']

  Scenario Outline: Create Appointment - <status>
    * def requestBody = read('classpath:examples/appointment/<example>.json')
    Given path '/appointment'
    And header Authorization = authToken
    And request requestBody
    When method POST
    Then status <expectedStatus>
    And match response == read('classpath:examples/appointment/<example>_response.json')

    Examples:
      | read('appointment_post.csv') |

  Scenario: Create Appointment - Missing Required Fields
    * def requestBody = {}
    Given path '/appointment'
    And header Authorization = authToken
    And request requestBody
    When method POST
    Then status 400
    And match response.control.type == 'E'
    And match response.control.code == '400'
    And match response.control.message contains 'Bad Request'

  Scenario: Create Appointment - Invalid Slot ID
    * def requestBody = {"appointment": {"slot": {"id": "invalid_slot_id"}, "reason": "Some reason"}}
    Given path '/appointment'
    And header Authorization = authToken
    And request requestBody
    When method POST
    Then status 404
    And match response.control.type == 'E'
    And match response.control.code == '404'
    And match response.control.message contains 'Identificador do Slot não encontrado ou expirado'
