# AQI App
<img width="469" alt="Screenshot 2024-06-24 at 4 37 42 PM" src="https://github.com/mgable1995/AQIApp/assets/24579819/e1c07e72-b1b3-44ac-b722-61b110f570f1">
<img width="469" alt="Screenshot 2024-06-24 at 4 38 00 PM" src="https://github.com/mgable1995/AQIApp/assets/24579819/9cc3ad6f-7b4b-4318-ba7e-9a6711d53e5e">

#Features
- Fetch data of AQI by using the lat/lon of your current location.
- Also have the option to search by city name.
- Friendly name and brief explanation of AQI result.
- Color coded for better user contextualization of AQI data.
- Horizontally swipable cards to see yesterday, today, and tomorrow's AQI data.

# Improvements/Enhancement ideas

- Unit tests are very basic, I could have spent some more time to improve upon them.
- API key is simply a variable in the network manager, which would obviously not fly in a real world example. Considered putting into keychain to show secure storage, but even then we should not store API keys in this manner.
- Certain edge cases of error handling were not covered, but wanted to keep things simple and cover the bulk of the common use cases. Things like empty states and UI for error states, rather than a simple popup when the API fails.
- NetworkManager is very basic, rather than splitting it up into a proper networking layer with an enum to hit different endpoints. Figured I'd keep it simple for the sake of the app.
- The UI is not the prettiest, but again, wanted to keep things basic and not spend too much time on it.
- Could probably pre-fetch the first call for AQI data for current location before presenting the HomeViewController.
