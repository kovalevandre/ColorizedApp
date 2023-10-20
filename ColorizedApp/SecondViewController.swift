//
//  SecondViewController.swift
//  ColorizedApp
//
//  Created by Andrey Kovalev on 20.10.2023.
//

import UIKit

final class SecondViewController: UIViewController {
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    var selectedColor: UIColor?
    var delegate: ColorSelectionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        if let color = selectedColor {
            colorView.backgroundColor = color
            var red: CGFloat = 0
            var green: CGFloat = 0
            var blue: CGFloat = 0
            color.getRed(&red, green: &green, blue: &blue, alpha: nil)
            redSlider.value = Float(red)
            greenSlider.value = Float(green)
            blueSlider.value = Float(blue)
            updateLabels()
        }
    }
    @IBAction func redSliderChanged(_ sender: UISlider) {
           updateColor()
       }
       
       @IBAction func greenSliderChanged(_ sender: UISlider) {
           updateColor()
       }
       
       @IBAction func blueSliderChanged(_ sender: UISlider) {
           updateColor()
       }
       
       func updateColor() {
           let red = CGFloat(redSlider.value)
           let green = CGFloat(greenSlider.value)
           let blue = CGFloat(blueSlider.value)
           colorView.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
           updateLabels()
       }
       
       func updateLabels() {
           redLabel.text = String(format: "%.2f", redSlider.value)
           greenLabel.text = String(format: "%.2f", greenSlider.value)
           blueLabel.text = String(format: "%.2f", blueSlider.value)
       }
       
       @IBAction func saveButtonTapped(_ sender: UIButton) {
           delegate?.didSelectColor(colorView.backgroundColor ?? UIColor.white)
           dismiss(animated: true, completion: nil)
       }
   }
