//
//  MyViewController.swift
//  AppGroup1
//
//  Created by Giammarco on 16/02/23.
//

import SwiftUI

class MyViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Crea una vista personalizzata per il titolo della NavigationBar
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 44))
        let titleLabel = UILabel(frame: titleView.bounds)
        titleLabel.text = "Titolo della pagina"
        titleLabel.textAlignment = .center
        titleView.addSubview(titleLabel)
        
        // Imposta la vista personalizzata come titolo della NavigationBar
        navigationItem.titleView = titleView
    }
}

