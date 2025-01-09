import SwiftUI
import CoreLocation
import AVFoundation

struct ContentView: View {
    @State private var showSOSAlert = false
    @State private var currentLocation: CLLocationCoordinate2D?
    @State private var isRecording = false
    @State private var emergencyContacts: [String] = []  // Start with an empty list
    @State private var newContactName = ""
    @State private var newContactNumber = ""
    @State private var recorder: AVAudioRecorder?
    @StateObject private var locationManagerDelegate = LocationDelegate()

    var body: some View {
        VStack {
            Text("Emergency SOS App")
                .font(.largeTitle)
                .padding()

            Button(action: {
                triggerSOSAlert()
            }) {
                Text("Send SOS Alert")
                    .font(.title)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }

            if let location = locationManagerDelegate.currentLocation {
                Text("Current Location: \(location.latitude), \(location.longitude)")
            } else {
                Text("Fetching location...")
                    .foregroundColor(.gray)
            }

            Button(action: {
                toggleRecording()
            }) {
                Text(isRecording ? "Stop Recording" : "Start Recording")
                    .font(.title)
                    .padding()
                    .background(isRecording ? Color.green : Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }

            Divider()
                .padding(.vertical)

            Text("Emergency Contacts")
                .font(.headline)
            List(emergencyContacts, id: \.self) { contact in
                Text(contact)
            }

            HStack {
                TextField("Name", text: $newContactName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Number", text: $newContactNumber)
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding()

            Button(action: addEmergencyContact) {
                Text("Add Contact")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }

            Spacer()
        }
        .onAppear {
            locationManagerDelegate.setupLocationManager()
        }
        .alert(isPresented: $showSOSAlert) {
            Alert(title: Text("SOS Alert Sent!"),
                  message: Text("Your SOS alert has been sent to your contacts."),
                  dismissButton: .default(Text("OK")))
        }
    }

    private func triggerSOSAlert() {
        for contact in emergencyContacts {
            sendSMS(to: contact)
        }
        
        if let location = locationManagerDelegate.currentLocation {
            print("Sending Location: \(location.latitude), \(location.longitude)")
        }
        
        triggerPanicAlarm()
        showSOSAlert.toggle()
    }

    private func sendSMS(to contact: String) {
        print("Sending SMS to \(contact)...")
    }

    private func triggerPanicAlarm() {
        if let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") {
            var audioPlayer: AVAudioPlayer?
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.play()
            } catch {
                print("Error playing panic alarm sound: \(error.localizedDescription)")
            }
        }
    }

    private func toggleRecording() {
        if isRecording {
            stopRecording()
        } else {
            startRecording()
        }
        isRecording.toggle()
    }

    private func startRecording() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playAndRecord, mode: .default, options: .defaultToSpeaker)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)

            let settings: [String: Any] = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 44100.0,
                AVNumberOfChannelsKey: 2,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]
            
            let fileURL = FileManager.default.temporaryDirectory.appendingPathComponent("emergencyRecording.m4a")
            
            recorder = try AVAudioRecorder(url: fileURL, settings: settings)
            recorder?.record()
        } catch {
            print("Error starting audio recording: \(error.localizedDescription)")
        }
    }

    private func stopRecording() {
        guard let recorder = recorder else {
            print("Error: Audio recorder is not initialized.")
            return
        }
        recorder.stop()
    }

    private func addEmergencyContact() {
        guard !newContactName.isEmpty, !newContactNumber.isEmpty else {
            print("Error: Both name and number must be provided.")
            return
        }

        let newContact = "\(newContactName) - \(newContactNumber)"
        emergencyContacts.append(newContact)
        newContactName = ""
        newContactNumber = ""
    }
}

class LocationDelegate: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    @Published var currentLocation: CLLocationCoordinate2D?

    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let newLocation = locations.first {
            DispatchQueue.main.async {
                self.currentLocation = newLocation.coordinate
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get location: \(error.localizedDescription)")
    }
}
