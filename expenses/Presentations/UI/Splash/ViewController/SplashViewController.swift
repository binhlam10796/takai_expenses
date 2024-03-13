//
//  SplashViewController.swift
//  expenses
//
//  Created by vcampus on 3/10/24.
//

import Foundation
import UIKit
import Lottie

class SplashViewController: BaseViewController {
    
    
    // MARK: OUTLET
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var animView: LottieAnimationView!
    
    // MARK: DI
    var router: SplashRouterInput?
    
    // MARK: LOCALIZE
    override func localizeUI() {
        welcomeLabel.text = NSLocalizedString(Localized.splash_view_controller_title.rawValue, comment: "")
    }
    
    // MARK: SETUP VIEW
    override func setupView() {
        welcomeLabel.font = Font(.installed(.RowdiesBold), size: .standard(.s40)).instance
        welcomeLabel.textColor = Palette.color0D47A1
        
        animView?.contentMode = .scaleAspectFit
        animView?.play(completion: { [weak self] _ in
            self?.router?.navigateToLoginView()}
        )
    }
    
}
