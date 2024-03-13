//
//  Loadable.swift
//  expenses
//
//  Created by vcampus on 3/10/24.
//

import Foundation
import UIKit

protocol Loadable: LoadingViewDelegate {
    func showLoading(isFullScreen: Bool, isBackgroundVisible: Bool)
    func hideLoading(animate: Bool)
}

extension Loadable where Self: UIViewController {
    
    /// Show loadings view on full screen mode
    func showLoading(isFullScreen: Bool = true, isBackgroundVisible: Bool = true) {
        DispatchQueue.main.async { [self] in
            let nibViews = Bundle.main.loadNibNamed(LoadingView.NIB_NAME, owner: self, options: nil)
            if let loadingView = nibViews?.first as? LoadingView {
                if isFullScreen {
                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                       let currentWindow = windowScene.windows.first {
                        currentWindow.addSubview(loadingView)
                        loadingView.frame = currentWindow.bounds
                    }
                } else {
                    view.addSubview(loadingView)
                    loadingView.frame = view.frame
                    loadingView.delegate = self
                }
                loadingView.startAnimating()
            }
        }
    }
    
    /// Hide all loader views previously added
    func hideLoading(animate: Bool = false) {
        DispatchQueue.main.async {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let currentWindow = windowScene.windows.first {
                for subview in currentWindow.subviews {
                    if let loadingView = subview as? LoadingView {
                        UIView.animate(
                            withDuration: 0.4,
                            delay: 0.0,
                            options: .curveEaseIn,
                            animations: {
                                loadingView.alpha = 0.0
                            },
                            completion: { (finished: Bool) in
                                loadingView.stopAnimating()
                                loadingView.removeFromSuperview()
                            }
                        )
                    }
                }
            }
        }
    }
    
    func onLoadingViewBackButton() {
        
    }
}

