@api @rest
Feature: REST API Validation
As an API consumer
I want secure and reliable API behavior
So that I can safely integrate with the system

Background:
Given the API base URL is available
And the content type is "application/json"

==========================
Auth Token Validation
==========================

@security @auth @smoke
Scenario: Access API with valid authentication token
Given a valid authentication token is issued
When the client sends a GET request to "/resources" with the valid token
Then the response status code should be 200
And the response body should contain the requested resource data

@security @auth @regression
Scenario: Access API with missing authentication token
When the client sends a GET request to "/resources" without an authentication token
Then the response status code should be 401
And the response body should contain an "Unauthorized" error message

@security @auth @regression
Scenario: Access API with invalid or expired authentication token
Given an invalid or expired authentication token
When the client sends a GET request to "/resources" with the invalid token
Then the response status code should be 401
And the response body should indicate token validation failure

==========================
CRUD Operations
==========================

@smoke @crud
Scenario: Create a new resource
Given a valid authentication token is issued
And a valid request payload for resource creation
When the client sends a POST request to "/resources"
Then the response status code should be 201
And the response body should contain the created resource details
And the resource should be persisted in the system

@smoke @crud
Scenario: Retrieve an existing resource
Given a valid authentication token is issued
And a resource exists with ID "123"
When the client sends a GET request to "/resources/123"
Then the response status code should be 200
And the response body should contain the correct resource details

@regression @crud
Scenario: Update an existing resource
Given a valid authentication token is issued
And a resource exists with ID "123"
And a valid request payload for update
When the client sends a PUT request to "/resources/123"
Then the response status code should be 200
And the response body should reflect the updated resource data
And the changes should be persisted in the system

@regression @crud
Scenario: Delete an existing resource
Given a valid authentication token is issued
And a resource exists with ID "123"
When the client sends a DELETE request to "/resources/123"
Then the response status code should be 204
And the resource should no longer exist in the system

==========================
Error Handling (4xx & 5xx)
==========================

@negative @regression
Scenario: Request resource with invalid ID format
Given a valid authentication token is issued
When the client sends a GET request to "/resources/invalid-id"
Then the response status code should be 400
And the response body should contain validation error details

@negative @regression
Scenario: Request non-existing resource
Given a valid authentication token is issued
When the client sends a GET request to "/resources/99999"
Then the response status code should be 404
And the response body should contain a "Resource not found" message

@negative @regression
Scenario: Server error handling
Given a valid authentication token is issued
And the server encounters an unexpected internal error
When the client sends a GET request to "/resources"
Then the response status code should be 500
And the response body should contain a generic error message
And no sensitive system details should be exposed

==========================
Rate Limiting
==========================

@security @performance
Scenario: Exceed API rate limit
Given a valid authentication token is issued
And the API rate limit is 100 requests per minute
When the client sends more than 100 requests within one minute
Then the response status code should be 429
And the response should include rate limit exceeded details
And a retry-after header should be present

==========================
Schema Validation
==========================

@contract @regression
Scenario: Validate response schema for GET resource
Given a valid authentication token is issued
And a resource exists with ID "123"
When the client sends a GET request to "/resources/123"
Then the response status code should be 200
And the response body should match the defined JSON schema
And all mandatory fields should be present with correct data types

@contract @negative
Scenario: Validate request schema for resource creation
Given a valid authentication token is issued
And an invalid request payload missing mandatory fields
When the client sends a POST request to "/resources"
Then the response status code should be 400
And the response body should contain schema validation error details