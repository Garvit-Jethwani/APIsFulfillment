# ********RoostGPT********

# Test generated by RoostGPT for test karate-vtal-appointment using AI Type Claude AI and AI Model claude-3-opus-20240229
# 
# Feature file generated for /searchTimeSlot_get for http method type GET 
# RoostTestHash=0e2f009f7e
# 
# 

# ********RoostGPT********
Feature: Search Time Slot API

  Background:
    * def urlBase = karate.properties['url.base'] || karate.get('urlBase', 'http://localhost:4010')
    * url urlBase
    * def authToken = karate.properties['AUTH_TOKEN']
    * configure headers = { 'Authorization': '#(authToken)' }

  Scenario Outline: Retrieve Search Time Slot - Successful Response
    Given path '/searchTimeSlot'
    And param addressId = <addressId>
    And param subscriberId = <subscriberId>
    And param associatedDocument = <associatedDocument>
    And param startDate = <startDate>
    And param finishDate = <finishDate>
    And param orderType = <orderType>
    And param addressChangeFlag = <addressChangeFlag>
    And param productType = <productType>
    And param priorityFlag = <priorityFlag>
    And param priorityReason = <priorityReason>
    When method GET
    Then status 200
    And match response.control.type == 'S'
    And match response.control.code == '200'
    And match response.control.message == 'OK'
    And match response.slots == '#array'
    And match each response.slots contains { id: '#string', startDate: '#string', finishDate: '#string', expireIn: '#number' }

    Examples:
      | read('searchTimeSlot_get.csv') |

  Scenario: Retrieve Search Time Slot - Bad Request
    Given path '/searchTimeSlot'
    And param addressId = 'invalid'
    When method GET
    Then status 400
    And match response.control.type == 'E'
    And match response.control.code == '400'
    And match response.control.message == 'Bad Request'

  Scenario: Retrieve Search Time Slot - Unauthorized
    Given path '/searchTimeSlot'
    And param addressId = 17713
    And configure headers = { 'Authorization': 'invalidToken' }
    When method GET
    Then status 401
    And match response.control.type == 'E'
    And match response.control.code == '401'
    And match response.control.message == 'Unauthorized'

  Scenario: Retrieve Search Time Slot - Forbidden
    Given path '/searchTimeSlot'
    And param addressId = 17713
    And configure headers = { 'Authorization': 'expiredToken' }
    When method GET
    Then status 403
    And match response.control.type == 'E'
    And match response.control.code == '403'
    And match response.control.message == 'Forbidden - Scope Not Permitted'

  Scenario: Retrieve Search Time Slot - Not Found
    Given path '/invalidEndpoint'
    When method GET
    Then status 404
    And match response.control.type == 'E'
    And match response.control.code == '404'
    And match response.control.message == 'Not Found'
