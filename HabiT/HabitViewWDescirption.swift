//
//  HabitViewWDescirption.swift
//  HabiT
//
//  Created by Hari's Mac on 08.04.2025.
//

import SwiftUI
import AVFoundation


struct FlipDigitView: View {
    let value: String
    let animationTrigger: Bool

    @State private var flipped = false

    var body: some View {
        Text(value)
            .font(.system(size: 40, weight: .bold, design: .monospaced))
            .frame(width: 80, height: 80)
            .background(Color.black.opacity(0.8))
            .foregroundColor(.white)
            .cornerRadius(12)
            .rotation3DEffect(
                .degrees(flipped ? 360 : 0),
                axis: (x: 0, y: 1, z: 0)
            )
            .animation(.easeInOut(duration: 0.3), value: flipped)
            .onChange(of: animationTrigger) { _ in
                flipped.toggle()
        }
    }
}
struct HabitViewWDescirption: View {
    @Environment(\.dismiss) var dismiss
     var activity: Activity
    
    @State private var timeRemaining = 25*60 // seconds (can be any duration)
        @State private var timerRunning = false
        @State private var timer: Timer? = nil
    @State private var timervalue: Int = 25

    @ObservedObject var activityManager: ActivityManager = .init()
        // For sound or music
    
    @State private var selectedSound = "Rain"
    @State private var isPlayingAmbient = false
    @State private var audioPlayer: AVAudioPlayer?
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color.green.opacity(0.5).edgesIgnoringSafeArea(.all)
                VStack{
                    Divider().padding(.vertical)
                    
                    Text("🎧 Focus Mode")
                        .font(.headline)
                    
                    Picker("Ambient Sound", selection: $selectedSound) {
                        Text("Rain").tag("Rain")
                        Text("Forest").tag("Forest")
                        Text("Waves").tag("Waves")
                    }.pickerStyle(.segmented)
                        .padding(.horizontal)
                    
                    Toggle("Play ambient sound", isOn: $isPlayingAmbient)
                        .onChange(of: isPlayingAmbient) { playing in
                            if playing {
                                playAmbientSound(named: selectedSound)
                            } else {
                                stopAmbientSound()
                            }
                        }
                        .padding(.bottom,90)

                    VStack{
                        HStack{
                            FlipDigitView(value: String(format: "%02d", timeRemaining / 60), animationTrigger: timerRunning)
                            Text(":")
                                .font(.system(size: 48, weight: .bold, design: .monospaced))
                            FlipDigitView(value: String(format: "%02d", timeRemaining % 60), animationTrigger: timerRunning)
                        }
                        HStack(spacing: 20) {
                            Button(action: startTimer) {
                                Label("Start", systemImage: "play.circle.fill")
                                    .font(.title2)
                                    .foregroundStyle(.black)
                            }
                            .disabled(timerRunning)
                            
                            Button(action: pauseTimer) {
                                Label("Pause", systemImage: "pause.circle.fill")
                                    .font(.title2)
                                    .foregroundStyle(.black)
                            }
                            .disabled(!timerRunning)
                            
                            Button(action: resetTimer) {
                                Label("Reset", systemImage: "arrow.counterclockwise.circle.fill")
                                    .font(.title2)
                                    .foregroundStyle(.black)
                            }
                        }
                        .padding(.horizontal,2)
                        if timerRunning {
                            ProgressView(value: Double(timervalue), total: 500)
                                .progressViewStyle(LinearProgressViewStyle(tint: .black))
                                .padding(3)
                        }
                    }
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray,lineWidth: 2)
                    )

                }
                .padding()
                .onDisappear {
                    timer?.invalidate()
                    stopAmbientSound()
                }
                
            }
            .navigationTitle(activity.name)
        }
        
}
    func startTimer() {
        guard timervalue > 0 else { return } // prevent 0 second timer

        timeRemaining = timervalue*60
        timerRunning = true
        playAmbientSound(named: "Rain")

        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                if timeRemaining > 0 {
                    timeRemaining -= 1
                } else {
                    timer?.invalidate()
                    timerRunning = false
                    stopAmbientSound()
                    // optional: alert/haptic
                }
            }
        if let index = activityManager.activities.firstIndex(where: { $0.id == activity.id }) {
                activityManager.activities[index].isCompletedToday = true
            }
    }
     func pauseTimer() {
         timer?.invalidate()
         timerRunning = false
         stopAmbientSound()
     }

     func resetTimer() {
         timer?.invalidate()
         timeRemaining = 25 * 60
         timerRunning = false
         stopAmbientSound()
     }

     func timeString(from seconds: Int) -> String {
         let minutes = seconds / 60
         let secs = seconds % 60
         return String(format: "%02d:%02d", minutes, secs)
     }
    
    // For music player
    func playAmbientSound(named name: String) {
        guard let url = Bundle.main.url(forResource: name, withExtension: "mp3") else {
            print("Sound file not found")
            return
        }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.numberOfLoops = -1 // loop forever
            audioPlayer?.play()
        } catch {
            print("Error playing sound: \(error)")
        }
    }

    func stopAmbientSound() {
        audioPlayer?.stop()
    }
}

#Preview {
    HabitViewWDescirption(activity:Activity(name: "Test Activity", date: Date(), duration: 0))
}
