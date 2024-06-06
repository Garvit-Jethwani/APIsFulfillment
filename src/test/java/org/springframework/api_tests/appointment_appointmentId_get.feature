# ********RoostGPT********

# Test generated by RoostGPT for test karate-vtal-appointment using AI Type Claude AI and AI Model claude-3-opus-20240229
# 
# Feature file generated for /appointment/{appointmentId}_get for http method type GET 
# RoostTestHash=b69bb60b36
# 
# 

# ********RoostGPT********
Feature: Retrieve Appointment API

  Background:
    * def urlBase = karate.properties['url.base'] || karate.get('urlBase', 'http://localhost:4010')
    * url urlBase
    * def token = karate.properties['AUTH_TOKEN']
    * configure headers = { 'Authorization': '#(token)' }

  Scenario: Retrieve appointment successfully
    Given path '/appointment/SA-562403'
    When method GET
    Then status 200
    And match response ==
      """
      {
        control: {
          type: 'S',
          code: '200',
          message: 'Ok'
        },
        appointments: {
          id: 'SA-562403',
          lifeCycleStatus: 'Não atribuído',
          occurrences: [
            {
              creationDateTime: '#regex .*2021-12-07.*',
              startDate: '#regex .*2021-10-09.*',
              finishDate: '#regex .*2021-10-09.*',
              reason: 'Teste Vtal CW',
              reasonDetail: 'Teste Vtal CW'
            }
          ]
        }
      }
      """

  Scenario: Bad request error
    Given path '/appointment/invalid'
    When method GET
    Then status 400
    And match response ==
      """
      {
        control: {
          type: 'E',
          code: '400',
          message: 'Bad Request'
        }
      }
      """

  Scenario: Unauthorized error
    Given path '/appointment/SA-562403'
    And configure headers = { 'Authorization': 'invalid_token' }
    When method GET
    Then status 401
    And match response ==
      """
      {
        control: {
          type: 'E',
          code: '401',
          message: 'Unauthorized'
        }
      }
      """

  Scenario: Forbidden error
    Given path '/appointment/SA-562403'
    When method GET
    Then status 403
    And match response ==
      """
      {
        control: {
          type: 'E',
          code: '403',
          message: 'Forbidden - Scope Not Permitted'
        }
      }
      """

  Scenario: Appointment not found
    Given path '/appointment/SA-999999'
    When method GET
    Then status 404
    And match response ==
      """
      {
        control: {
          type: 'E',
          code: '404',
          message: 'Not Found'  
        }
      }
      """

  Scenario: Not acceptable error
    Given path '/appointment/SA-562403'
    When method GET
    Then status 406
    And match response ==
      """
      {
        control: {
          type: 'E',
          code: '406',
          message: 'Not Acceptable'
        }
      }
      """

  Scenario: Precondition failed error
    Given path '/appointment/SA-562403'
    When method GET
    Then status 412
    And match response ==
      """
      {
        control: {
          type: 'E',
          code: '412',
          message: 'Precondition Failed'
        }
      }
      """

  Scenario: Too many requests error
    Given path '/appointment/SA-562403'
    When method GET
    Then status 429
    And match response ==
      """
      {
        control: {
          type: 'E',
          code: '429',
          message: 'Too Many Requests - Exceeded Quota'
        }
      }
      """

  Scenario: Internal server error
    Given path '/appointment/SA-562403'
    When method GET
    Then status 500
    And match response ==
      """
      {
        control: {
          type: 'T',
          code: '500',
          message: 'Internal Server Error'
        }
      }
      """

  Scenario: Service unavailable error
    Given path '/appointment/SA-562403'
    When method GET
    Then status 503
    And match response ==
      """
      {
        control: {
          type: 'T',
          code: '503',
          message: 'Service Unavailable'
        }
      }
      """

  Scenario: Gateway timeout error
    Given path '/appointment/SA-562403'
    When method GET
    Then status 504
    And match response ==
      """
      {
        control: {
          type: 'T',
          code: '504',
          message: 'Gateway Timeout'
        }
      }
      """