Feature: Interacting with a Safe
  Scenario: About a safe
    Given I have a safe
    Then the PIN should be 123456
    And the PIN should be 6 digits

  Scenario: Successfully setting the PIN to a safe
    Given I have a safe
    When I set the PIN to 111111
    Then the PIN should be 111111
    And the PIN should be 6 digits

  Scenario: Unsuccessfully setting the PIN to a safe
    Given I have a safe
    When I set the PIN to 1
    Then the display shows ERROR
    And the PIN should be 123456
    And the PIN should be 6 digits

  Scenario: Unlocking a safe
    Given I have a safe
    And the safe is locked
    And the door is closed
    Then the display is empty
    When I hit the key button
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
    Then the display shows 6
    And the display shows OPEN
    And the safe is unlocked
    And the door can be opened

  Scenario: Locking a safe
    Given I have a safe
    And the safe is unlocked
    And the door is closed
    Then the display shows OPEN
    When I close the door
    And I hit the lock button
    Then the door is locked
    And the door is closed
    And the display shows CLOSED

  Scenario: Forgetting key button
    Given I have a safe
    And the safe is locked
    And the door is closed
    When I hit the 1 button
    Then the display shows ERROR
    When I hit any button except the key button
    Then the display shows ERROR

  Scenario: Wrong Code
    Given I have a safe
    And the door is locked
    And the door is closed
    When I hit the key button
    And I hit the 1 button
    When I hit the 2 button
    When I hit the 4 button
    When I hit the 3 button
    When I hit the 5 button
    When I hit the 6 button
    Then the display is empty
    And the safe is locked

  Scenario: Setting a new code
    Given I have a safe
    And the safe is unlocked
    And the door is open
    When I hit the PIN button
    And I hit the 7 button
    And I hit the 7 button
    And I hit the 7 button
    And I hit the 3 button
    And I hit the 3 button
    And I hit the 3 button
    And I hit the PIN button
    Then the display shows CODE
    And the safe is unlocked
    When I close the door
    And I hit the lock button
    Then the safe is locked
    And the door is closed
    When I hit the key button
    And I hit the 7 button
    When I hit the 7 button
    When I hit the 7 button
    When I hit the 3 button
    When I hit the 3 button
    When I hit the 3 button
    And the display shows OPEN
    And the safe is unlocked
    And the door can be opened


