Feature: Interacting with a Safe
  Scenario: About a safe
    Given I have a safe
    Then the PIN should be 123456
    And the PIN should be 6 digits

