//
//  ColorSelectionDelegate.swift
//  ColorizedApp
//
//  Created by Andrey Kovalev on 20.10.2023.
//

import UIKit

protocol ColorSelectionDelegate: AnyObject {
    func didSelectColor(_ color: UIColor)
}
