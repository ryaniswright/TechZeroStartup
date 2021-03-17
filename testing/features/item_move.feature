Feature: list item movement
    Scenario: move an item from today to tomorrow
        Given we have an item in todays list
            When we move it to tomorrow
            Then it will appear in tomorrows list