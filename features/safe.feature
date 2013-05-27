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

  Scenario: Unlocking a safe
    Given I have a safe
    Then the display shows nothing
    When I hit the KEY button
    And I hit the 1 button
    Then the display shows 1
    When I hit the 2 button
    Then the display shows 2
    When I hit the 3 button
    Then the display shows 3
    When I hit the 4 button
    Then the display shows 4
    When I hit the 5 button
    Then the display shows 5
    When I hit the 6 button
    Then the display shows OPEN
    And the safe should be unlocked
    And the door can be opened

  Scenario: Locking a safe
    Given I have a safe
    And the safe is unlocked
    Then the display shows OPEN
    When I close the door
    And I hit the LOCK button
    Then the safe should be locked
    And the door should be closed
    And the display shows CLOSED
