//
//  SecondViewController.swift
//  ColorizedApp
//
//  Created by Andrey Kovalev on 20.10.2023.
//

import UIKit

class SecondViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    @IBOutlet weak var redTextField: UITextField!
    @IBOutlet weak var greenTextField: UITextField!
    @IBOutlet weak var blueTextField: UITextField!
    
    var selectedColor: UIColor?
    var delegate: ColorSelectionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissKeyboard))
        keyboardToolbar.items = [doneButton]
        
        redTextField.inputAccessoryView = keyboardToolbar
        greenTextField.inputAccessoryView = keyboardToolbar
        blueTextField.inputAccessoryView = keyboardToolbar
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
            updateTextFields()
        }
    }
    
    @IBAction func redSliderChanged(_ sender: UISlider) {
        updateColor()
        updateTextFields()
    }
    
    @IBAction func greenSliderChanged(_ sender: UISlider) {
        updateColor()
        updateTextFields()
    }
    
    @IBAction func blueSliderChanged(_ sender: UISlider) {
        updateColor()
        updateTextFields()
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
    
    func updateTextFields() {
        redTextField.text = String(format: "%.2f", redSlider.value)
        greenTextField.text = String(format: "%.2f", greenSlider.value)
        blueTextField.text = String(format: "%.2f", blueSlider.value)
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        delegate?.didSelectColor(colorView.backgroundColor ?? UIColor.white)
        dismiss(animated: true, completion: nil)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text, let value = Float(text) else {
   
            showInvalidInputAlert()
            updateTextFields()
            return
        }
        
        if value >= 0.0 && value <= 1.0 {
   
            switch textField {
            case redTextField:
                redSlider.value = value
            case greenTextField:
                greenSlider.value = value
            case blueTextField:
                blueSlider.value = value
            default:
                break
            }
            updateColor()
            updateLabels()
        } else {
            showInvalidInputAlert()
            updateTextFields()
        }
    }
    
       func showInvalidInputAlert() {
           let alert = UIAlertController(title: "Ошибка", message: "Пожалуйста, введите корректное значение в диапазоне от 0.0 до 1.0", preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
           present(alert, animated: true, completion: nil)
       }
   }
