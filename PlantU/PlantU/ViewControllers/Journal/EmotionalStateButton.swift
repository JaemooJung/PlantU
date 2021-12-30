//
//  EmotionalStateButton.swift
//  PlantU
//
//  Created by JaemooJung on 2021/01/26.
//

import UIKit
import CoreMotion

class EmotionalStateButton: UIButton {

    var status: Bool = false {
            didSet {
                self.update()
                print("CurrentStatus: \(status)")
            }
        }
        var onImage = UIImage(named: "leaf")
        var offImage = UIImage(named: "leaf")
        
        required init(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)!
            self.setStatus(false)
        }
        
        func update() {
            UIView.transition(with: self, duration: 0.10, options: .transitionCrossDissolve, animations: {
                self.status ? self.setImage(self.onImage, for: .normal) : self.setImage(self.offImage, for: .normal)
            }, completion: nil)
        }
    
        func toggle() {
            self.status ? self.setStatus(false) : self.setStatus(true)
            print(self.status)
        }
        
        func setStatus(_ status: Bool) {
            self.status = status
        }
        
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            super.touchesBegan(touches, with: event)
            self.sendHapticFeedback()
            self.toggle()
        }
        
        func sendHapticFeedback() {
            let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .heavy)
            impactFeedbackgenerator.prepare()
            impactFeedbackgenerator.impactOccurred()
        }
    

}


