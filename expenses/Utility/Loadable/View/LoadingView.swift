//
//  LoadingView.swift
//  expenses
//
//  Created by vcampus on 3/10/24.
//

import UIKit
import Lottie

protocol LoadingViewDelegate: AnyObject {
    func onLoadingViewBackButton()
}

class LoadingView: UIView {
    
    static let NIB_NAME = "LoadingView"
    
    @IBOutlet weak var animView: LottieAnimationView!
    
    weak var delegate: LoadingViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupAppearance()
    }
    
    func startAnimating() {
        animView?.contentMode = .scaleAspectFit
        animView?.loopMode = .loop
        animView?.animationSpeed = 1.0
        animView?.play()
    }
    
    func stopAnimating() {
        animView?.stop()
    }
    
    func onBackButtonAction() {
        delegate?.onLoadingViewBackButton()
    }
    
    private func setupAppearance() {
        if isDarkMode {
            animView?.animation = LottieAnimation.named(Animation.animLoading)
        } else {
            animView?.animation = LottieAnimation.named(Animation.animLoading)
        }
    }
    
    private var isDarkMode: Bool {
        if #available(iOS 13.0, *) {
            return traitCollection.userInterfaceStyle == .dark
        } else {
            return false
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            setupAppearance()
        }
    }
}
