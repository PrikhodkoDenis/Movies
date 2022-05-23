//
//  NavigationViewController.swift
//  Movies
//
//  Created by Denis on 19.05.2022.
//

import UIKit

class NavigationViewController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.barTintColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        navigationBar.isTranslucent = false
        navigationBar.tintColor = .white
        navigationBar.titleTextAttributes = Text.attributes
    }
}
