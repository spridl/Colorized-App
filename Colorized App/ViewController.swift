//
//  ViewController.swift
//  Colorized App
//
//  Created by Тимур on 03.03.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var redValueLabel: UILabel!
    @IBOutlet weak var greenValueLabel: UILabel!
    @IBOutlet weak var blueValueLabel: UILabel!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorView.layer.cornerRadius = 20
        
        insertValue(slider: redSlider, to: redValueLabel)
        insertValue(slider: greenSlider, to: greenValueLabel)
        insertValue(slider: blueSlider, to: blueValueLabel)
        
        switchColorView()
        
    }
    @IBAction func redSliderAction() {
        insertValue(slider: redSlider, to: redValueLabel)
        switchColorView()
    }
    @IBAction func greenSliderAction() {
        insertValue(slider: greenSlider, to: greenValueLabel)
        switchColorView()
    }
    @IBAction func blueSliderAction() {
        insertValue(slider: blueSlider, to: blueValueLabel)
        switchColorView()
    }
    
    private func insertValue(slider: UISlider, to label: UILabel) {
        label.text = String(format: "%.2f", slider.value)
    }
    private func switchColorView() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1)
    }
    
    
}

