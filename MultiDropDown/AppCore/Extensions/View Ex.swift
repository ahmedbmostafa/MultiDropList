//
//  View Ex.swift
//  SeamsLabTask
//
//  Created by ahmed mostafa on 31/01/2022.
//

import UIKit

class RoundViewShadow: UIView {
    override func awakeFromNib() {
        setupView()
    }
    func setupView() {
        self.layer.cornerRadius =  8
        self.layer.shadowColor = #colorLiteral(red: 0.8666666667, green: 0.8666666667, blue: 0.8666666667, alpha: 1)
        self.layer.shadowRadius = 8
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
    }
}
class RoundView: UIView {
    override func awakeFromNib() {
        setupView()
    }
    func setupView() {
        self.layer.cornerRadius =  self.layer.frame.height / 2
    }
}
