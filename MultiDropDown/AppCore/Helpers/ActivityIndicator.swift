//
//  ActivityIndicator.swift
//  SeamsLabTask
//
//  Created by ahmed mostafa on 31/01/2022.
//

import UIKit
import NVActivityIndicatorView

protocol ActivityIndicatorStates {
    func startAnimating(viewController: UIViewController)
    func stopAnimating()
}
class ActivityIndicator: ActivityIndicatorStates {
    var activityIndicator : NVActivityIndicatorView!

    func startAnimating(viewController: UIViewController) {
        let xAxis = viewController.view.center.x
        let yAxis = viewController.view.center.y
        let frame = CGRect(x: (xAxis - 50), y: (yAxis - 50), width: 90, height: 90)
        activityIndicator = NVActivityIndicatorView(frame: frame)
        activityIndicator.color = #colorLiteral(red: 0.3019607843, green: 0.5843137255, blue: 0.6078431373, alpha: 1)
        activityIndicator.type = .ballRotateChase
        viewController.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }

    func stopAnimating() {
        activityIndicator.stopAnimating()
    }

}
