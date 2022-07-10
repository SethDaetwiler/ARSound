//
//  ViewController.swift
//  ARSoundFinder
//
//  Created by Seth Daetwiler on 7/9/22.
//

import UIKit
import RealityKit
import AVFoundation

class ViewController: UIViewController {
    
    
    @IBOutlet weak var arView: ARView!
    @IBOutlet weak var levelLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load the "Box" scene from the "Experience" Reality File
        let boxAnchor = try! Experience.loadBox()
        levelLabel.textColor = .red
        
        // Add the box anchor to the scene
        arView.scene.anchors.append(boxAnchor)
        
        guard let session = setupMicrophone() else {
            print("Error setting up session in main")
            return
        }
        
        startAudioCapture()
        
    }
    
    // TODO: Find a home for capture related code
    func startAudioCapture(){
        let docPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let sampleFileName = docPath.appendingPathComponent("rec.m4a")
        let settings = [AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                      AVSampleRateKey: 12000,
                      AVNumberOfChannelsKey: 1,
                      AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue]
        
        do {
            let sessionRecorder = try AVAudioRecorder(url: sampleFileName, settings: settings)
            sessionRecorder.record()
            sessionRecorder.isMeteringEnabled = true
            
            // Contains all audio capture refresh actions
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                sessionRecorder.updateMeters()
                let db = sessionRecorder.averagePower(forChannel: 0)
                
                self.levelLabel.text = "\(Int(db))"
                print(db)
            }
            
        } catch {
            print("failed to record")
        }
    }
}
