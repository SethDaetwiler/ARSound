//
//  MicrophoneConfiguration.swift
//  ARSoundFinder
//
//  Created by Seth Daetwiler on 7/9/22.
//

import Foundation
import AVFAudio

public func setupMicrophone() -> AVAudioSession?{
    let session = AVAudioSession.sharedInstance()
    guard let availableInput  = session.availableInputs, let builtInMicInput = availableInput.first(where: { $0.portType == .builtInMic}) else {
        print("No built in mic")
        return nil
    }
    
    do {
        try session.setPreferredInput(builtInMicInput)
    } catch{
        print("Unable to set built-in mic as prefered")
    }
    return session
}
