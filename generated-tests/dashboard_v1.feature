@dashboard @ui
Feature: Dashboard Functionality
As an authenticated user
I want to view and interact with the dashboard
So that I can monitor key information relevant to my role

Background:
Given the user is authenticated
And the user has access to the dashboard
And the system data services are available

@smoke @regression
Scenario: Dashboard widgets load successfully
When the user navigates to the dashboard
Then all configured widgets should be displayed
And each widget should load without error
And a loading indicator should disappear after data is rendered

@regression
Scenario: Dashboard displays accurate data
Given relevant data exists in the system
When the user views the dashboard
Then each widget should display data consistent with the backend data source
And calculated metrics should match expected business rules
And timestamps should reflect the latest available data

@regression
Scenario: Filter functionality updates dashboard data
Given the dashboard contains filter options
When the user applies a valid filter criteria
Then the dashboard widgets should refresh
And displayed data should reflect the selected filter
And only records matching the filter criteria should be shown

@regression
Scenario: Sort functionality orders data correctly
Given the dashboard contains sortable data fields
When the user applies ascending sort on a data column
Then the data should be displayed in ascending order
When the user applies descending sort on the same data column
Then the data should be displayed in descending order

@regression @responsive
Scenario: Dashboard layout adapts to different screen sizes
Given the user accesses the dashboard from a desktop device
Then the layout should display widgets in a multi-column format
When the user accesses the dashboard from a tablet device
Then the layout should adjust to a medium-width format
When the user accesses the dashboard from a mobile device
Then the layout should adjust to a single-column format
And no content should overlap or be truncated

@security @regression
Scenario: Permission-based widget visibility
Given multiple user roles exist in the system
When a user with restricted permissions accesses the dashboard
Then only widgets allowed for that role should be visible
And restricted widgets should not be accessible
When a user with administrative permissions accesses the dashboard
Then all role-authorized widgets should be visible