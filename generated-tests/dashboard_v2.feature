@dashboard @regression
Feature: Dashboard functionality, data integrity, and UI rendering
  As a platform user
  I want to view a reliable, responsive, and secure dashboard
  So that I can analyze my data accurately

  Background:
    Given the platform backend is running and populated with test data

  @ui @performance
  Scenario: Asynchronous loading of dashboard widgets
    Given a user is logged in successfully
    When the user navigates to the main dashboard
    Then a loading skeleton should be displayed for all widgets
    And all widgets should fully render within 3 seconds
    And no "Failed to load data" errors should be present on the page

  @data @accuracy
  Scenario: Verifying dashboard metric accuracy against backend data
    Given a user is logged in with access to sales metrics
    When the user views the "Total Revenue" widget
    Then the displayed revenue figure should match the sum of all closed deals in the database
    And the percentage growth indicator should accurately reflect the month-over-month calculation

  @ui @sorting
  Scenario Outline: Applying filters and sorting to dashboard data tables
    Given the user is viewing the "Recent Activity" data table on the dashboard
    When the user clicks the column header to sort by "<column_name>" in "<sort_direction>" order
    Then the table rows should immediately reorder to reflect the "<sort_direction>" sorting of "<column_name>"
    And the data pagination should remain intact

    Examples:
      | column_name | sort_direction |
      | Date        | Ascending      |
      | Date        | Descending     |
      | Status      | Ascending      |
      | User        | Descending     |

  @ui @responsive
  Scenario Outline: Dashboard layout adapts to different viewport sizes
    Given the user is logged in
    When the user views the dashboard on a "<device_type>" with viewport "<resolution>"
    Then the dashboard layout should adjust to fit the screen without horizontal scrolling
    And the navigation menu should transition to a "<menu_state>"

    Examples:
      | device_type | resolution | menu_state      |
      | Desktop     | 1920x1080  | Sidebar visible |
      | Tablet      | 768x1024   | Collapsed icon  |
      | Mobile      | 375x667    | Hamburger menu  |

  @security @roles
  Scenario: Widget visibility is restricted based on user RBAC permissions
    Given a user is logged in with a "Standard User" role
    When the user views the dashboard
    Then the user should see the "My Tasks" and "Team Activity" widgets
    But the "System Settings" and "Revenue Projections" widgets should not be visible
    When an "Admin" user views the exact same dashboard
    Then all widgets including "System Settings" and "Revenue Projections" should be visible