//
//  Constants.swift
//  iWrite
//
//  Created by Swetha Sreekanth on 24/4/21.
//

import Foundation
import UIKit

// MARK: - Constants
enum Constants {
    enum General{
        static let delayTimer = 0.1
    }
 static let timeInterval: TimeInterval = 30
 static let splashImage = "splashmaps"

    enum Animation {
        static let animationrepeat: Float = 0
        static let animationFile = "warning-icon"
        static let animationFile1 = "glass"
    }
    struct Decimals {
        static let half: Double = 0.5
    }
        
    struct size {
        static let screenRect = UIScreen.main.bounds
        static let screenWidth = screenRect.size.width
        static let screenHeight = screenRect.size.height
    }
}
