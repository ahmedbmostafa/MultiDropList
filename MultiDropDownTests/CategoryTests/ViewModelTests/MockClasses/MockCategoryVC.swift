//
//  MockCategoryVC.swift
//  MultiDropDownTests
//
//  Created by AhmedHD_SL on 19/12/2022.
//

import XCTest
@testable import MultiDropDown

class MockCategoryVC: CategoryVC {

    var isShowLoaderCalls = false
    var isReloadCategoryCalls = false
    var isShowErrorCalls = false

    override func bindViewModelOutput() {
        viewModel.output = { [weak self] output in
            guard let self = self else { return }
            switch output {
            case .reloadCategory:
                self.isReloadCategoryCalls = true
            case .showActivityIndicator( _):
                self.isShowLoaderCalls = true
            case .showError( _):
                self.isShowErrorCalls = true
            }
        }
    }

}
