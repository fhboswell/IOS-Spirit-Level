//
//  ViewController.swift
//  SpiritLevel
//
//  Created by Henry Boswell on 3/15/18.
//  Copyright © 2018 Boswell. All rights reserved.
//


import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    
    //MARK: - Instance Variables
    let motionManager = CMMotionManager()
    let queue = OperationQueue()
    
    //MARK: - IBOutlet
    @IBOutlet var rollLabel: UILabel!
    @IBOutlet var pitchLabel: UILabel!
    @IBOutlet var yawLabel: UILabel!
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initalizeMotionManager()
        
    }
    
    
    //MARK: - CoreMotion
    /*
     func initalizeMotionManager()
     ---------------------------------------------------------------------------------------------
     1.
     The following line can be manipulated for different readout intervals,
     the current speed is selected for readability
     motionManager.deviceMotionUpdateInterval = 0.01
     
     2.
     There are several different refrence frames that may give different accuracies
     .xMagneticNorthZVertical
     .xArbitraryZVertical
     .xTrueNorthZVertical
     .xArbitraryCorrectedZVertical
     Experiment by changing the end of this line
     motionManager.startDeviceMotionUpdates(using: CMAttitudeReferenceFrame.xMagneticNorthZVertical
     
     3.
     The output from core motion is in radians, for convience i've converted it to degrees
     
     4.
     Yaw is related to north magnetic or true given the selected frame of refrence
     
    
     */
    
    func initalizeMotionManager(){
        
        if motionManager.isGyroAvailable {
            motionManager.deviceMotionUpdateInterval = 1
            motionManager.startDeviceMotionUpdates(using: CMAttitudeReferenceFrame.xMagneticNorthZVertical,to: queue, withHandler:{
                deviceManager, error in
                if (deviceManager?.attitude) != nil {
                    
                    let pitch = deviceManager!.attitude.pitch
                    let roll = deviceManager!.attitude.roll
                    let yaw = deviceManager!.attitude.yaw
                    
                    print("Pitch: " + String(describing: pitch*(180/Double.pi)))
                    print("Roll: " + String(describing: roll*(180/Double.pi)))
                    print("Yaw: " + String(describing: yaw*(180/Double.pi)))
                    
                    OperationQueue.main.addOperation {
                        self.rollLabel.text = "Pitch: " + String(format: "%.7f", pitch*(180/Double.pi))
                        self.pitchLabel.text = "Roll: " + String(format: "%.7f", roll*(180/Double.pi))
                        self.yawLabel.text = "Yaw: " + String(format: "%.7f", yaw*(180/Double.pi))
                    }
                    
                }
            })
        }
    }
}

