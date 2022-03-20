//
//  ColorViewController.swift
//  Colorized App
//
//  Created by Тимур on 18.03.2022.
//

import UIKit

protocol SettingsColorDelegate {
    func setNewColor(of color: UIColor)
}

class ColorViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        settingsVC.color = view.backgroundColor
        settingsVC.delegate = self
    }
}

extension ColorViewController: SettingsColorDelegate {
    func setNewColor(of color: UIColor) {
        view.backgroundColor = color
    }
}
