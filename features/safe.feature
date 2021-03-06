Feature: Interacting with a Safe
  Scenario: About a safe
    Given I have a safe
    And the PIN should be 6 digits

  Scenario: Unsuccessfully setting the PIN to a safe
    Given I have a safe
    When I hit the PIN button
    And I hit the 1 button
    And I hit the PIN button
    Then the display shows ERROR
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
    When the door is closed
    And I hit the LOCK button
    Then the safe should be locked
    And the door should be closed
    And the display shows CLOSED

  Scenario: Forgetting key button
    Given I have a safe
    And the safe is locked
    And the door is closed
    When I hit the 1 button
    Then the display shows ERROR
    When I hit the 2 button
    Then the display shows ERROR
    When I hit the 3 button
    Then the display shows ERROR
    When I hit the 4 button
    Then the display shows ERROR
    When I hit the 5 button
    Then the display shows ERROR
    When I hit the 6 button
    Then the display shows ERROR
    When I hit the 7 button
    Then the display shows ERROR
    When I hit the 8 button
    Then the display shows ERROR
    When I hit the 9 button
    Then the display shows ERROR
    When I hit the 0 button
    Then the display shows ERROR
    When I hit the LOCK button
    Then the display shows ERROR

  Scenario: Wrong Code
    Given I have a safe
    And the safe is locked
    And the door is closed
    When I hit the KEY button
    And I hit the 1 button
    When I hit the 2 button
    When I hit the 4 button
    When I hit the 3 button
    When I hit the 5 button
    When I hit the 6 button
    Then the display shows nothing
    And the safe should be locked

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
    And the PIN should be 6 digits
    And the safe should be unlocked
    When the door is closed
    And I hit the LOCK button
    Then the safe should be locked
    And the door should be closed
    When I hit the KEY button
    And I hit the 7 button
    When I hit the 7 button
    When I hit the 7 button
    When I hit the 3 button
    When I hit the 3 button
    When I hit the 3 button
    And the display shows OPEN
    And the safe should be unlocked
    And the door can be opened

  Scenario: Locking an already locked safe
    Given I have a safe
    And the safe is locked
    And the door is closed
    When I hit the LOCK button
    Then the safe should be locked
    And the door should be closed
    And the display shows ERROR

  Scenario: Locking a safe that has an open door
    Given I have a safe
    And the safe is unlocked
    And the door is open
    When I hit the LOCK button
    Then the safe should be unlocked
    And the door should be open
    And the display shows ERROR
