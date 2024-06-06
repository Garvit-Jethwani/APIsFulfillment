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

  Scenario Outline: Search available time slots
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
    And match response.control.code == 200
    And match response.control.message == 'OK'
    And match response.slots == '#array'
    And match each response.slots contains { id: '#string', startDate: '#string', finishDate: '#string', expireIn: '#number' }

    Examples:
      | read('searchTimeSlot_get.csv') |

  Scenario: Search time slots with invalid address ID
    Given path '/searchTimeSlot'
    And param addressId = 0
    And param associatedDocument = 'VTT001'
    And param startDate = '2021-05-21T13:00:00'
    And param finishDate = '2021-06-04T13:00:00'
    And param orderType = 'Instalacao'
    And param productType = ['Banda Larga']
    When method GET
    Then status 400
    And match response.control.type == 'E'
    And match response.control.code == 400
    And match response.control.message == 'Bad Request'

  Scenario: Search time slots with unauthorized access
    Given path '/searchTimeSlot'
    And param addressId = 17713
    And param associatedDocument = 'VTT001'
    And param startDate = '2021-05-21T13:00:00'
    And param finishDate = '2021-06-04T13:00:00'
    And param orderType = 'Instalacao'
    And param productType = ['Banda Larga']
    When method GET
    Then status 401
    And match response.control.type == 'E'
    And match response.control.code == 401
    And match response.control.message == 'Unauthorized'

  Scenario: Search time slots with forbidden scope
    Given path '/searchTimeSlot'
    And param addressId = 17713
    And param associatedDocument = 'VTT001'
    And param startDate = '2021-05-21T13:00:00'
    And param finishDate = '2021-06-04T13:00:00'
    And param orderType = 'Instalacao'
    And param productType = ['Banda Larga']
    When method GET
    Then status 403
    And match response.control.type == 'E'
    And match response.control.code == 403
    And match response.control.message == 'Forbidden - Scope Not Permitted'
