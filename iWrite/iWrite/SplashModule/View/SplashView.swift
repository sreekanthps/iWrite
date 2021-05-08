//
//  SplashView.swift
//  iWrite
//
//  Created by Swetha Sreekanth on 24/4/21.
//

import UIKit
import Lottie
import FlexLayout
import PinLayout


class SplashView :UIView {
    // MARK: - ActionDelegate
    
    enum Action: DelegateAction {
       case AnimationComplete
    }
    // MARK: -  Properties
    
    weak var delegate: ActionDelegate?
    var lottieView: AnimationView!
    let root: UIView = UIView()
    
    // MARK: - Computed Properties
    
    let image : UIImageView = {
        let image = UIImageView(frame: .zero)
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: Constants.splashImage)
        return image
    }()
    // MARK: -  Init
    init() {
        // Set Lottie Animation
       lottieView = AnimationView(name: Constants.Animation.animationFile, bundle: Bundle.main)
       super.init(frame: .zero)
       configure()
       loadView()
    }
    // MARK: -  Methods
    func configure() {
        lottieView.loopMode = .repeat(Constants.Animation.animationrepeat)
       lottieView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
       lottieView.contentMode = .scaleToFill
       lottieView.clipsToBounds = true
    }
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    func startLoadAnimation() {
        lottieView.play { (completed) in
            // Deleagate to Main Screen
            self.delegate?.actionSender(didReceiveAction: Action.AnimationComplete)
        }
    }
    func loadView() {
        removeAllSubviewsAndRemoveFromSuperview()
        root.flex.define { (flex) in
            flex.addItem(image).width(100%).height(100%).justifyContent(.center).alignItems(.center).define { (flex) in
                flex.addItem(lottieView).size(300).alignSelf(.center)
           }
            
        }
        addSubview(root)
    }
    override func layoutSubviews() {
        super.layoutSubviews()

        // Layout the flexbox container using PinLayout
        // NOTE: Could be also layouted by setting directly rootFlexContainer.frame
        root.pin.all()
        
        // Then let the flexbox container layout itself
        root.flex.layout()
    }
}
