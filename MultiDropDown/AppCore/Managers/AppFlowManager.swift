//
//  AppFlowManager.swift
//  SeamsLabTask
//
//  Created by ahmed mostafa on 31/01/2022.
//

import UIKit


class AppFlowManager {

    func start(navigationController: UINavigationController) {
        let vc = creatCategoryVC()
        navigationController.pushViewController(vc, animated: false)
    }
}

extension AppFlowManager {

    func creatCategoryVC() -> UIViewController {
        let vc = CategoryVC.instantiate(fromAppStoryboard: .Main)
        
        let dataProvider = CategoryDataProviderImpl()
        dataProvider.categoryService = CategoryServiceImp()
        let viewModel = CategoryViewModel(withDataProvider: dataProvider)
        dataProvider.delegate = viewModel
        viewModel.dataProvider = dataProvider
        
        let propDataProvider = PropertyDataProviderImpl()
        propDataProvider.categoryService = CategoryServiceImp()
        let propViewModel = PropertyViewModel(withDataProvider: propDataProvider)
        propDataProvider.delegate = propViewModel
        propViewModel.dataProvider = propDataProvider
        
        vc.viewModel = viewModel
        vc.propViewModel = propViewModel
        
        return vc
    }
    
}
