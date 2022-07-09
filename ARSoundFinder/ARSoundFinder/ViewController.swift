//
//  ViewController.swift
//  ARSoundFinder
//
//  Created by Seth Daetwiler on 7/9/22.
//

import UIKit
import RealityKit

class ViewController: UIViewController {
    
    @IBOutlet var arView: ARView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load the "Box" scene from the "Experience" Reality File
        let boxAnchor = try! Experience.loadBox()
        
        // Add the box anchor to the scene
        arView.scene.anchors.append(boxAnchor)
        
        guard let session = setupMicrophone() else {
            print("error setting up session in main")
            return
        }
        
        session.requestRecordPermission { response in
            print(response)
        }
    }
}
