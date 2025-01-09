# Emergency SOS App for iOS

## Description

The Emergency SOS App is a safety tool designed for users to quickly send an SOS alert, including their current location, to emergency contacts in times of need. This app allows users to add emergency contacts, start an audio recording for evidence, and trigger a panic alarm. The app utilizes the iOS location services to fetch the user’s current location and send that information along with the alert.

This project is built with SwiftUI and is designed to run on iPhone 16 with iOS 18.2. The app is aimed at providing an extra layer of safety for users who may be in dangerous or vulnerable situations. By sending emergency alerts, recordings, and location data, the app ensures that help can reach the user as quickly as possible.


## Features

-  SOS Alert: Trigger an SOS alert to all added emergency contacts.
-  Location Sharing: Sends the current GPS location to emergency contacts for quick response.
-  Panic Alarm: Plays an alarm sound to alert nearby people and deter potential threats.
-  Recording: Start recording audio to gather evidence that could be helpful in an emergency.
-  Add Emergency Contacts: Manually add or edit emergency contacts with their names and phone numbers.
-  Major Reason Why This is a Good Project for People's Safety

In emergency situations, every second counts. Having a quick and reliable way to alert others and share your location can be life-saving. 

This app addresses this critical need by providing a simple, intuitive interface that allows users to:

-  Send alerts to their loved ones instantly, without the need to manually dial emergency numbers.
-  Share their exact location, ensuring that rescuers or loved ones can find them quickly.
-  Record audio that could potentially serve as evidence in case of a dangerous situation.
-  By offering these features, the Emergency SOS App significantly enhances personal safety and can make a difference in critical moments, helping users feel secure and protected.


## Technologies Used

-  SwiftUI for building the app's user interface.
-  CoreLocation for fetching and sharing the user's location.
-  AVFoundation for playing the panic alarm and recording audio.
-  UserDefaults (if required) for storing emergency contacts locally.


## How to Use

-  Add Emergency Contacts: In the app, input the name and phone number of your emergency contacts in the provided fields and press "Add Contact."
-  Send SOS Alert: Press the "Send SOS Alert" button to immediately send a text alert with your current location to all saved emergency contacts.
-  Start/Stop Recording: Press the "Start Recording" button to begin recording audio. This can be helpful for capturing evidence. To stop, press "Stop Recording."
-   rigger Panic Alarm: An alarm sound will play to alert nearby people to your distress.


## Run the app on the iPhone 16 simulator or a physical device using iOS 18.2.
<img width="405" alt="Screenshot 2025-01-09 at 11 27 48 PM" src="https://github.com/user-attachments/assets/6fe0197d-ca0d-4df9-8f37-5288fcbb3b29" />
One can add the people he/she wants in their emergency contact list.

<img width="405" alt="Screenshot 2025-01-09 at 11 28 17 PM" src="https://github.com/user-attachments/assets/9dcf7714-121e-4928-bb1d-3837d79c12ad" />
By just clicking on the "Send SOS Alert" button, SOS Alert will be sent to people in the emergency contact list.

## Future Enhancements

-  Push Notifications: Notify emergency contacts when the SOS alert is sent.
-  User Authentication: Add user authentication for more secure access to the app.
-  Multiple Alert Options: Allow for multiple alert templates to be sent (e.g., family, friend, or professional contacts).
-  Automated Alerting: Enable automatic sending of alerts when the app detects an emergency based on predefined conditions.


## License
This project is open-source and available under the MIT License.
