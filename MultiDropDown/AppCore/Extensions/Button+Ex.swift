//
//  Button+Ex.swift
//  SeamsLabTask
//
//  Created by ahmed mostafa on 02/02/2022.
//

import UIKit

class RoundButton: UIButton {
    override func awakeFromNib() {
        setupView()
    }
    func setupView() {
        self.layer.cornerRadius =  8
    }
}
