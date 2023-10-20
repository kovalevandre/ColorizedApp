//
//  FirstViewController.swift
//  ColorizedApp
//
//  Created by Andrey Kovalev on 20.10.2023.
//

import UIKit

final class FirstViewController: UIViewController {
    @IBOutlet weak var colorView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func settingsButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "SettingsSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SettingsSegue" {
            if let destinationVC = segue.destination as? SecondViewController {
                destinationVC.selectedColor = colorView.backgroundColor
                destinationVC.delegate = self
            }
        }
    }
}

extension FirstViewController: ColorSelectionDelegate {
    func didSelectColor(_ color: UIColor) {
        colorView.backgroundColor = color
    }
}

// I cannot commit, so I make changes.
