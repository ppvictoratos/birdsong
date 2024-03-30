//
//  ContentView.swift
//  A2NiNG4K
//
//  Created by Petie Positivo on 4/18/22.
//

import Foundation
import SwiftUI
import CoreData
import Combine
import AVFoundation
import ComposableArchitecture

//TODO: resolve the following comments:
    //transparent backed group box consisting of 4 tracks with custom knobs and with some type of color varient
    //has + underneath. on tap { add tracks }
    // • • +

    //an animating metronome, when tapped it will make sounds. **always plays a "chiller" veresion of the sound before a recording commences**

    //an h stack with a bar in between the amount of bars the tracks have followed by the BPM it is at

    //an h stack that has the record/play/pause button along with skipping buttons in each direction by BARS

//TODO: take the form of the old content view and put it onto the normal content view, keep the functions for there now
struct ContentViewOLD: View {
    var timeHasPassed = false
    @State private var dropdown = false
    
    var body: some View {
        
        ZStack {
            VStack {
                HStack {
                    Spacer()
                    Text(timeHasPassed ? "song title" : "song metadata")
                    
                    Spacer(minLength: 120)
                    
                    HStack {
                        
                        Button(action: {
                            print("autosave. make a new song")
                        }) {
                            Image(systemName: "plus")
                        }
                        
                        Button(action: {
                            self.dropdown.toggle()
                        }) {
                            Image(systemName: "book")
                        }
                    }
                    Spacer()
                }.padding(.top, 75)
                
                TrackSlider(times: [1.0, 25.0, 25.0, 50.0])
                    .padding()
                
                BasicSoundControls(volume: 0.5)
            }

            //TODO: make this so that its not an offset.. lol
            TrackShelf()
                .offset(x: -90, y: dropdown ? -200 : -565.0)
                .animation(.easeInOut(duration: 1.0))
        }
    }
    
}

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        Text("Item at \(item.timestamp!, formatter: itemFormatter)")
                    } label: {
                        Text(item.timestamp!, formatter: itemFormatter)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

//MARK: HELPER METHODS

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

extension Date
{
    func toString( dateFormat format: String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}

func getCreationDate(for file: URL) -> Date {
    if let attributes = try? FileManager.default.attributesOfItem(atPath: file.path) as [FileAttributeKey: Any],
       let creationDate = attributes[FileAttributeKey.creationDate] as? Date {
        return creationDate
    } else {
        return Date()
    }
}

//MARK: PREVIEWS

struct ContentViewOLD_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewOLD().preferredColorScheme(.dark)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext).preferredColorScheme(.dark)
    }
}

struct BasicSoundControls_Previews: PreviewProvider {
    static var previews: some View {
        BasicSoundControls(volume: 0.5)
    }
}

struct TrackSliders_Previews: PreviewProvider {
    static var previews: some View {
        TrackSliders()    }
}

//TODO: Make this into it's own file. have a screen for the user to record their own audio/view other audio that has been recorded. make this list accessible on the main screen to put on each track

class AudioRecorder: NSObject, ObservableObject {
    
    override init() {
        super.init()
        fetchRecordings()
    }
    
    let objectWillChange = PassthroughSubject<AudioRecorder, Never>()
    
    var audioRecorder: AVAudioRecorder!
    
    var recordings = [Recording]()
    
    var recording = false {
        didSet {
            objectWillChange.send(self)
        }
    }
    
    func startRecording() {
        let recordingSession = AVAudioSession.sharedInstance()
        
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
        } catch {
            print("Failed to set up recording session")
        }
        
        let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let audioFilename = documentPath.appendingPathComponent("\(Date().toString(dateFormat: "dd-MM-YY_'at'_HH:mm:ss")).m4a")
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder.record()
            
            recording = true
        } catch {
            print("Could not start recording")
        }
    }
    
    func stopRecording() {
        audioRecorder.stop()
        recording = false
        
        fetchRecordings()
    }
    
    func fetchRecordings() {
        recordings.removeAll()
        
        let fileManager = FileManager.default
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let directoryContents = try! fileManager.contentsOfDirectory(at: documentDirectory, includingPropertiesForKeys: nil)
        
        for audio in directoryContents {
            let recording = Recording(fileURL: audio, createdAt: getCreationDate(for: audio))
            recordings.append(recording)
        }
        
        recordings.sort(by: { $0.createdAt.compare($1.createdAt) == .orderedAscending})
                
        objectWillChange.send(self)
    }
    
    func deleteRecording(urlsToDelete: [URL]) {
            
            for url in urlsToDelete {
                print(url)
                do {
                   try FileManager.default.removeItem(at: url)
                } catch {
                    print("File could not be deleted!")
                }
            }
            
            fetchRecordings()
            
        }
}

struct RecorderView: View {
    
    @ObservedObject var audioRecorder: AudioRecorder
    
    var body: some View {
        NavigationView {
            VStack {
                RecordingsList(audioRecorder: audioRecorder)
                
                if audioRecorder.recording == false {
                    Button(action: {self.audioRecorder.startRecording()}) {
                        Image(systemName: "circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .clipped()
                            .foregroundColor(.accentColor)
                            .padding(.bottom, 40)
                    }
                } else {
                    Button(action: {self.audioRecorder.stopRecording()}) {
                        Image(systemName: "stop.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .clipped()
                            .foregroundColor(.accentColor)
                            .padding(.bottom, 40)
                    }
                }
            }
        }.navigationBarTitle("Voice recorder")
        .navigationBarItems(trailing: EditButton())
        
    }
}

struct RecorderView_Previews: PreviewProvider {
    static var previews: some View {
        RecorderView(audioRecorder: AudioRecorder()).preferredColorScheme(.dark)
    }
}

struct RecordingsList: View {
    
    @ObservedObject var audioRecorder: AudioRecorder
    
    var body: some View {
        List {
            ForEach(audioRecorder.recordings, id: \.createdAt) { recording in
                RecordingRow(audioURL: recording.fileURL)
            }
            .onDelete(perform: delete)
        }
    }
    
    func delete(at offsets: IndexSet) {
        var urlsToDelete = [URL]()
        for index in offsets {
            urlsToDelete.append(audioRecorder.recordings[index].fileURL)
        }
        audioRecorder.deleteRecording(urlsToDelete: urlsToDelete)
    }
    
}

struct RecordingRow: View {
    var audioURL: URL
    
    @ObservedObject var audioPlayer = AudioPlayer()
    
    var body: some View {
        HStack {
            Text("\(audioURL.lastPathComponent)")
            Spacer()
            if audioPlayer.isPlaying == false {
                            Button(action: {
                                self.audioPlayer.startPlayback(audio: self.audioURL)
                            }) {
                                Image(systemName: "play.circle")
                                    .imageScale(.large)
                            }
            } else {
                Button(action: {
                    self.audioPlayer.stopPlayback()
                }) {
                    Image(systemName: "stop.fill")
                        .imageScale(.large)
                }
            }
        }
    }
}

struct RecordingsList_Previews: PreviewProvider {
    static var previews: some View {
        RecordingsList(audioRecorder: AudioRecorder())
    }
}

struct Recording {
    let fileURL: URL
    let createdAt: Date
}

class AudioPlayer: NSObject, ObservableObject, AVAudioPlayerDelegate {
    let objectWillChange = PassthroughSubject<AudioPlayer, Never>()
    
    var isPlaying = false {
        didSet {
            objectWillChange.send(self)
        }
    }
    
    var audioPlayer: AVAudioPlayer!
    
    func startPlayback (audio: URL) {
        let playbackSession = AVAudioSession.sharedInstance()
        
        do {
            try playbackSession.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
        } catch {
            print("Playing over the device's speakers failed")
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audio)
            audioPlayer.delegate = self
            audioPlayer.play()
            isPlaying = true
        } catch {
            print("Playback failed.")
        }
    }
    
    func stopPlayback() {
        audioPlayer.stop()
        isPlaying = false
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            isPlaying = false
        }
    }
}

public struct AudioState {
    //maybe we can do a foreach here? i dont like repeated code
    public var player1: AVAudioPlayer = AVAudioPlayer()
    public var player2: AVAudioPlayer = AVAudioPlayer()
    public var player3: AVAudioPlayer = AVAudioPlayer()
    public var player4: AVAudioPlayer = AVAudioPlayer()
    
    //then again.. if we need separate audioplayers to layer.. maybe
    //we need to build an audio engine? if i intend on using some TCA for this
    //I need to
    public init(
        player1: AVAudioPlayer = AVAudioPlayer(),
        player2: AVAudioPlayer = AVAudioPlayer(),
        player3: AVAudioPlayer = AVAudioPlayer(),
        player4: AVAudioPlayer = AVAudioPlayer()
    ) {
        self.player1 = player1
        self.player2 = player2
        self.player3 = player3
        self.player4 = player4
    }
}

extension AudioState: Equatable { }

public extension AudioState {
    enum Action {
        case none
        case record
        case play
        case pause
        case volume
        case rewind
        case unwind
    }
}

public let audioReducer = Reducer<AudioState, AudioState.Action, AudioEnvironment> { state, action, env in
    switch action {
case .none:
    return .none
case .record:
    return .none
case .play:
    return .none
case .pause:
    return .none
case .volume:
    return .none
case .rewind:
    return .none
case .unwind:
    return .none
}
}

public struct AudioEnvironment {
    public init() { }
}

public struct AudioTestEnvironment {
    public init() { }
}

struct TrackShelf: View {
    var body: some View {
        Shelf()
    }
}

struct TrackCardBoxStyle: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .center) {
            configuration.label
            configuration.content
        }.padding()
            .background(randomEarthTone())
            .clipShape(RoundedRectangle(cornerRadius: 20.0, style: .continuous))
            .font(.footnote)
            .offset(x: 0, y: 265.0)
    }
    
    func randomEarthTone() -> Color { return Color("Earth1")}
}

struct Shelf: View {
    var body: some View {
        trackCards()
    }
}

struct trackCards: View {
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [.init(), .init()]) {
                ForEach(0..<14) { _ in
                    GroupBox(
                        label: Label("Title", systemImage: "music.note").foregroundColor(.white)
                    ) {
                        Text("03:24")
                    }.groupBoxStyle(TrackCardBoxStyle())
                }
            }.padding()
                .frame(width: 210.0, height: 180, alignment: .center)
        }            .edgesIgnoringSafeArea(.all)
    }
}

struct TrackShelf_Previews: PreviewProvider {
    static var previews: some View {
        TrackShelf()
    }
}

//Track Sliders
struct TrackSliders: View {
    var body: some View {
        TrackSlider(times: [0.25, 0.5, 0.75, 1.0])
    }
}

//I want to squash this down, for Each? What's the best way to?
struct TrackSlider: View {
    @State var times: [Float]
    
    var body: some View {
        VStack {
            Slider(value: Binding(get: {times[0]}, set: {
                (newValue) in
                times[0] = newValue
            }))
            Slider(value: Binding(get: {times[1]}, set: {
                (newValue) in
                times[1] = newValue
            }))
            Slider(value: Binding(get: {times[2]}, set: {
                (newValue) in
                times[2] = newValue
            }))
            Slider(value: Binding(get: {times[3]}, set: {
                (newValue) in
                times[3] = newValue
            }))
        }
    }
}

//Basic Sound Controls
struct BasicSoundControls: View {
    var audioPlayer = AVAudioPlayer()
    let metronomeImage = UIImage(systemName: "metronome")?.cgImage
    @State var volume: Float
    
    var body: some View {
        
        VStack {
            Spacer()
            
        //metronome
            Image(systemName: "metronome")
                .resizable()
                .frame(width: 30.0, height: 30.0, alignment: .center)
            
        //bpm //bars
        HStack {
            BPMText()
            BarsText()
        }
        .padding(.bottom, 10)
        
        //-4 bars, pause/record/play, +4 bars
        PlaybackControls(audioPlayer: audioPlayer)
            
            //master volume
            Slider(value: Binding(get: {volume}, set: {
                (newValue) in
                volume = newValue
            })).padding()
            
            Spacer()
        }
        .padding(.all, 0.0)
    }
}

//could probably make one view that both of these can use to format text & eventually use it as a button that can read values from the tracks

struct BPMText: View {
    var body: some View {
        VStack {
            Text("88")
            Text("BPM")
        }
    }
}

struct BarsText: View {
    var body: some View {
        VStack {
            Text("16")
            Text("Bars")
        }
    }
}

struct PlaybackControls: View {
    var audioPlayer: AVAudioPlayer
    var isPlaying: Bool = false
    
    var body: some View {
        HStack {
            Button(action: {
                audioPlayer.currentTime -= TimeInterval(10)
            }) {
                Image(systemName: "gobackward.10").foregroundColor(Color("AccentColor")).font(.system(size: 60))
            }.padding(.trailing, 15)
            
            Button(action: {
                
                //isPlaying stays on even when paused
                audioPlayer.play()
                
            }) {
                Image(systemName:  audioPlayback(isPlaying: isPlaying))
                    .foregroundColor(Color("Earth1")).font(.system(size: 60))
            }.padding(.trailing, 15)
            
            Button(action: {
                //fast forward song 10 seconds
                audioPlayer.currentTime += TimeInterval(10)
            }) {
                Image(systemName: "goforward.10").foregroundColor(Color("AccentColor")).font(.system(size: 60))
            }
        }
    }
    
    func audioPlayback(isPlaying: Bool) -> String { return isPlaying ? "pause.circle.fill" : "play.circle.fill" }
    
}


