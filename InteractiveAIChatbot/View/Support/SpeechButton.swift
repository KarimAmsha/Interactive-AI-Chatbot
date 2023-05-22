//
//  SpeechButton.swift
//  InteractiveAIChatbot
//
//  Created by Karim Amsha on 19.05.2023.
//

import Speech
import SwiftUI
import Foundation

struct SpeechButton: View {
    
    @State var isPressed:Bool = false
    @State var actionPop:Bool = false
    @EnvironmentObject var swiftUISpeech:SwiftUISpeech
    @EnvironmentObject var audioRecorder: AudioRecorder

    var body: some View {
        
        Button(action:{
            if (self.swiftUISpeech.getSpeechStatus() == "Denied - Close the App"){
                self.actionPop.toggle()
            } else {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.3, blendDuration: 0.3)){self.swiftUISpeech.isRecording.toggle()}
                self.swiftUISpeech.isRecording ? self.swiftUISpeech.startRecording() : self.swiftUISpeech.stopRecording()
            }
            
            if audioRecorder.recording == false {
                self.audioRecorder.startRecording()
            } else {
                self.audioRecorder.stopRecording()
                self.audioRecorder.readyToUpload.toggle()
            }
        }){
            Image(systemName: "waveform")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(.white)
                .background(swiftUISpeech.isRecording ? Circle().foregroundColor(.red).frame(width: d70, height: d70) : Circle().foregroundColor(.blue009ED2()).frame(width: d70, height: d70))
        }.actionSheet(isPresented: $actionPop){
            ActionSheet(title: Text("ERROR: - 1"), message: Text("Access Denied by User"), buttons: [ActionSheet.Button.destructive(Text("Reinstall the Appp"))])// Error catch if the auth failed or denied
        }
    }
}

struct Button_Previews: PreviewProvider {
    static var previews: some View {
        SpeechButton().environmentObject(SwiftUISpeech())
    }
}
