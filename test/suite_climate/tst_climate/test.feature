Feature: Adjust driver AC temperature

  Scenario: Change AC value down and up

    Given the application "Outpace Square" is started
    When The user taps on the AC decrease button 1 times
    Then the AC temperature should be set to 20.5 in the dock