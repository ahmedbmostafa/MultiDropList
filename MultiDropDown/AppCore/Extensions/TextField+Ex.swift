//
//  TextField+Ex.swift
//  SeamsLabTask
//
//  Created by ahmed mostafa on 02/02/2022.
//

import UIKit

class RoundTxtF: UITextField {

    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    override func awakeFromNib() {
        setupView()
    }

    func setupView() {
        self.layer.cornerRadius = 4
        self.layer.borderColor = #colorLiteral(red: 0.5618024468, green: 0.6101570725, blue: 0.6216071248, alpha: 1)
        self.layer.borderWidth = 1
    }

        override open func textRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.inset(by: padding)
        }
        override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.inset(by: padding)
        }
        override open func editingRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.inset(by: padding)
        }
}
