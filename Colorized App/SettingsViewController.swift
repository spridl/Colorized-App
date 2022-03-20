//
//  SettingsViewController.swift
//  Colorized App
//
//  Created by Тимур on 03.03.2022.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var redValueLabel: UILabel!
    @IBOutlet weak var greenValueLabel: UILabel!
    @IBOutlet weak var blueValueLabel: UILabel!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var redTextField: UITextField!
    @IBOutlet weak var greenTextField: UITextField!
    @IBOutlet weak var blueTextField: UITextField!
    
    @IBOutlet weak var doneButton: UIButton!
    
    var color: UIColor!
    var delegate: SettingsColorDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
        
        doneButton.layer.cornerRadius = doneButton.frame.width / 20
        
        colorView.layer.cornerRadius = colorView.frame.height / 10
        colorView.backgroundColor = color
        
        setKeyboardToolBar()
        setSlidersValue(for: redSlider, greenSlider, blueSlider, of: color)
        setLabelsValue(for: redValueLabel, greenValueLabel, blueValueLabel)
        setTextFieldsValue(for: redTextField, greenTextField, blueTextField)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        applyingValuesOfTF()
    }
    
    @IBAction func doneButtonPressed() {
        delegate.setNewColor(of: colorView.backgroundColor ?? UIColor.white)
        dismiss(animated: true)
    }
    
    @IBAction func rgbSlider(_ sender: UISlider) {
        setColor()
        switch sender {
        case redSlider:
            redValueLabel.text = string(from: redSlider)
            redTextField.text = string(from: redSlider)
        case greenSlider:
            greenValueLabel.text = string(from: greenSlider)
            greenTextField.text = string(from: greenSlider)
        default:
            blueValueLabel.text = string(from: blueSlider)
            blueTextField.text = string(from: blueSlider)
        }
    }
    
    @objc private func applyingValuesOfTF() {
        view.endEditing(true)
        setColor()
    }
    
    private func setKeyboardToolBar() {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 0, height: 20))
        
        let flexibleSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: self,
            action: nil
        )
        let doneBarButton = UIBarButtonItem(
            title: "Done",
            style: .done,
            target: self,
            action: #selector(applyingValuesOfTF)
        )
        
        toolBar.items = [flexibleSpace, doneBarButton]
        toolBar.sizeToFit()
        
        redTextField.inputAccessoryView = toolBar
        greenTextField.inputAccessoryView = toolBar
        blueTextField.inputAccessoryView = toolBar
    }
    
    private func setColor() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    
    private func setSlidersValue(for sliders: UISlider..., of color: UIColor) {
        sliders.forEach { slider in
            switch slider {
            case redSlider:
                redSlider.value = Float(color.rgba.red)
            case greenSlider:
                greenSlider.value = Float(color.rgba.green)
            default:
                blueSlider.value = Float(color.rgba.blue)
            }
        }
    }
    
    private func setLabelsValue(for labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case redValueLabel:
                redValueLabel.text = string(from: redSlider)
            case greenValueLabel:
                greenValueLabel.text = string(from: greenSlider)
            default:
                blueValueLabel.text = string(from: blueSlider)
            }
        }
    }
    
    private func setTextFieldsValue(for textFields: UITextField...) {
        textFields.forEach { textField in
            switch textField {
            case redTextField:
                redTextField.text = string(from: redSlider)
            case greenTextField:
                greenTextField.text = string(from: greenSlider)
            default:
                blueTextField.text = string(from: blueSlider)
            }
        }
    }
    
    private func checkOnValid(for textField: UITextField, in slider: UISlider) -> Float {
        guard let value = Float(textField.text!) else {
            alert()
            textField.text = string(from: slider)
            return slider.value
        }
        if value > 1 || value < 0 {
            textField.text = string(from: slider)
            alert()
            return slider.value
        }
        return value
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
}

extension SettingsViewController {
    
    private func alert() {
        let alert = UIAlertController(
            title: "Error",
            message: "invalid number",
            preferredStyle: .alert
        )
        let action = UIAlertAction(title: "Ok", style: .default)
        
        alert.addAction(action)
        present(alert, animated: true)
    }
}

extension SettingsViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case redTextField:
            redSlider.value = checkOnValid(for: redTextField, in: redSlider)
            redValueLabel.text = string(from: redSlider)
        case greenTextField:
            greenSlider.value = checkOnValid(for: greenTextField, in: greenSlider)
            greenValueLabel.text = string(from: greenSlider)
        default:
            blueSlider.value = checkOnValid(for: blueTextField, in: blueSlider)
            blueValueLabel.text = string(from: blueSlider)
        }
    }
}
