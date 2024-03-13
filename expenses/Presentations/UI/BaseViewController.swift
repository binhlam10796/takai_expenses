//
//  BaseViewController.swift
//  expenses
//
//  Created by vcampus on 3/10/24.
//

import UIKit

class BaseViewController: UIViewController, Loadable {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Palette.colorWHITE
        setupView()
        localizeUI()
        actionHandler()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func localizeUI() {}
    
    func setupView() {}
    
    func actionHandler() {}
    
    func bind() {}
    
    func displayMessage(message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertController, animated: true)
    }
}
