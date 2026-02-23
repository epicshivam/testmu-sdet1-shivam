@api @regression
Feature: REST API core functionality, security, and schema validation
  As a consuming application
  I want the REST API to be secure, reliable, and strictly typed
  So that I can confidently integrate with its endpoints

  Background:
    Given the REST API service is running and accessible
    And the base URI is configured

  @auth @security
  Scenario Outline: API Authorization and Token Validation
    When a "GET" request is made to the "/users/profile" endpoint with an "<token_state>" Authorization header
    Then the API should respond with status code "<status_code>"
    And the response body should contain the message "<expected_message>"

    Examples:
      | token_state | status_code | expected_message         |
      | valid       | 200         | Success                  |
      | invalid     | 401         | Unauthorized             |
      | expired     | 401         | Token has expired        |
      | missing     | 403         | Forbidden: Access Denied |

  @crud @smoke
  Scenario Outline: Full CRUD lifecycle for a resource
    Given an authorized API client
    When a "<method>" request is made to "<endpoint>" with the required payload
    Then the API should respond with status code "<status_code>"
    And the database state should reflect the "<operation>" operation

    Examples:
      | operation | method | endpoint    | status_code |
      | Create    | POST   | /users      | 201         |
      | Read      | GET    | /users/{id
} | 200         |
      | Update    | PUT    | /users/{id
} | 200         |
      | Delete    | DELETE | /users/{id
} | 204         |

  @error-handling @negative
  Scenario Outline: Graceful handling of client and server errors
    Given an authorized API client
    When a request triggers a "<error_type>" condition
    Then the API should respond with status code "<status_code>"
    And the response should follow the standard error JSON format

    Examples:
      | error_type               | status_code |
      | Resource not found       | 404         |
      | Bad request malformed    | 400         |
      | Internal server failure  | 500         |
      | Service unavailable      | 503         |

  @security @rate-limiting
  Scenario: Enforcing API rate limits to prevent abuse
    Given an authorized API client
    When the client sends 105 requests to the "/data" endpoint within 1 minute
    Then the first 100 requests should return status code 200
    But the subsequent 5 requests should return status code 429
    And the response header should include "Retry-After"

  @schema @validation
  Scenario: Strict JSON Schema validation for response payloads
    Given an authorized API client
    When a "GET" request is made to the "/users/{id}" endpoint
    Then the API should respond with status code 200
    And the response body must strictly conform to the "user-profile-schema.json" specification