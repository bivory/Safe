Feature: Interacting with a Safe
  Scenario: About a safe
    Given I have a safe
    Then the PIN should be 123456
    And the PIN should be 6 digits

  Scenario: Unsuccessfully setting the PIN to a safe
    Given I have a safe
    When I hit the PIN button
    And I hit the 1 button
    And I hit the PIN button
    Then the display shows ERROR
    And the PIN should be 123456
    And the PIN should be 6 digits
