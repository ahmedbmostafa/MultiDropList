//
//  ViewController.swift
//  MultiDropDown
//
//  Created by AhmedHD_SL on 17/12/2022.
//

import UIKit
import SwiftyMenu


class CategoryVC: UIViewController {
    
    @IBOutlet weak var categoryView: SwiftyMenu!
    @IBOutlet weak var subCategoryView: SwiftyMenu!
    @IBOutlet weak var processTypeView: SwiftyMenu!
    @IBOutlet weak var brandView: SwiftyMenu!
    @IBOutlet weak var mainBrandView: UIView!
    @IBOutlet weak var modelView: SwiftyMenu!
    @IBOutlet weak var typeView: SwiftyMenu!
    @IBOutlet weak var mainTypeView: UIView!
    
    private var setMenuAttributes: SwiftyMenuAttributes {
        
        var attributes = SwiftyMenuAttributes()
        
        // Custom Behavior
        attributes.multiSelect = .disabled
        attributes.scroll = .enabled
        attributes.hideOptionsWhenSelect = .enabled
        
        attributes.roundCorners = .all(radius: 8)
        
        attributes.border = .value(color: #colorLiteral(red: 0.8666666667, green: 0.8666666667, blue: 0.8666666667, alpha: 1), width: 1)
        attributes.rowStyle = .value(height: 40, backgroundColor: .white, selectedColor: UIColor.gray.withAlphaComponent(0.1))
        
        attributes.headerStyle = .value(backgroundColor: .white, height: 40)
        
        attributes.placeHolderStyle = .value(text: "Please Select Item", textColor: #colorLiteral(red: 0.4941176471, green: 0.4941176471, blue: 0.4941176471, alpha: 1))
        
        attributes.textStyle = .value(color: #colorLiteral(red: 0.06, green: 0.09, blue: 0.16, alpha: 1), separator: " & ", font: UIFont(name: "Montserrat-Arabic-Bold", size: 15))
        
        attributes.separatorStyle = .value(color: #colorLiteral(red: 0.8666666667, green: 0.8666666667, blue: 0.8666666667, alpha: 1), isBlured: false, style: .singleLine)
        attributes.arrowStyle = .value(isEnabled: true)
        attributes.height = .value(height: (viewModel.categoryDataSourceViewModels.count + 1) * 60)
        
        attributes.expandingAnimation = .spring(level: .low)
        attributes.expandingTiming = .value(duration: 0.5, delay: 0)
        
        attributes.collapsingAnimation = .linear
        attributes.collapsingTiming = .value(duration: 0.5, delay: 0)
        
        return attributes
    }
    
    
    var viewModel: CategoryViewModelProtocol!
    var propViewModel: PropertyViewModelProtocol!
    var activityIndicator: ActivityIndicatorStates!
    var childOptions = [OptionModel]()
    
    var catId = 0
    var childId = 0
    var isBrand = false
    var isType = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator = ActivityIndicator()
        setCategoryMenu()
        setSubCategoryMenu(dataModel: nil)
        setProcessTypeMenu()
        setBrandMenu(dataModel: nil)
        setModelMenu()
        setTypeMenu()
        
        bindViewModelOutput()
        viewModel.didLoad()
        bindPropViewModelOutput()
        
    }
    
    func bindViewModelOutput() {
        viewModel.output = { [weak self] output in
            guard let self = self else {return}
            switch output {
            case .reloadCategory:
                self.setCategoryMenu()
            case .showActivityIndicator(let show):
                show ? self.activityIndicator.startAnimating(viewController: self) : self.activityIndicator.stopAnimating()
            case .showError(let error):
                UIAlertController.showAlert(withMessage: error.localizedDescription)
            }
        }
    }
    
    func bindPropViewModelOutput() {
        propViewModel.output = { [weak self] output in
            guard let self = self else {return}
            switch output {
            case .reloadCategory:
                
                if self.isBrand {
                    self.setModelMenu()
                } else {
                    self.setProcessTypeMenu()
                }
                
                if self.isType {
                    self.setTypeMenu()
                }
                
            case .showActivityIndicator(let show):
                show ? self.activityIndicator.startAnimating(viewController: self) : self.activityIndicator.stopAnimating()
            case .showError(let error):
                UIAlertController.showAlert(withMessage: error.localizedDescription)
            }
        }
    }
    
    private func setCategoryMenu() {
        categoryView.delegate = self
        categoryView.items = viewModel.getCategoryList()
        categoryView.configure(with: setMenuAttributes)
    }
    
    func setSubCategoryMenu(dataModel: [CategoryDataModel]?) {
        subCategoryView.delegate = self
        subCategoryView.configure(with: setMenuAttributes)
        subCategoryView.items = viewModel.getSubCategoryList(dataModel: dataModel)
    }
    
    
    private func setProcessTypeMenu() {
        processTypeView.delegate = self
        processTypeView.items = propViewModel.getProcessTypeList()
        processTypeView.configure(with: setMenuAttributes)
    }
    
    // need to change to brand
    private func setBrandMenu(dataModel: [OptionModel]?) {
        brandView.delegate = self
        brandView.configure(with: setMenuAttributes)
        brandView.items = propViewModel.getBrandList(dataModel: dataModel)
    }
    
    // need to change to model
    private func setModelMenu() {
        modelView.delegate = self
        modelView.items = propViewModel.getModelList()
        modelView.configure(with: setMenuAttributes)
    }
    
    private func setTypeMenu() {
        typeView.delegate = self
        typeView.items = propViewModel.getTypeList()
        typeView.configure(with: setMenuAttributes)
        
    }
    
    @IBAction func goNextBtnTapped(_ sender: Any) {
        let vc = StaticVC.instantiate(fromAppStoryboard: .Main)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}



extension CategoryVC: SwiftyMenuDelegate {
    func swiftyMenu(_ swiftyMenu: SwiftyMenu, didSelectItem item: SwiftyMenuDisplayable, atIndex index: Int) {
        print("Selected item: \(item), at index: \(index)")
        
        switch swiftyMenu {
        case self.categoryView:
            let cellViewModel = viewModel.getCategoryCellViewModel(index: index)
            self.subCategoryView.configure(with: setMenuAttributes)
            self.setSubCategoryMenu(dataModel: cellViewModel.category?.children ?? [])
            
        case self.subCategoryView:
            catId = item.retrievableValue as! Int
            propViewModel.didLoad(catId: catId)
            
        case self.processTypeView:
            let cellViewModel = propViewModel.getPropertyCellViewModel(index: index)
            self.brandView.configure(with: setMenuAttributes)
            self.childOptions = cellViewModel.property?.options ?? []
            self.setBrandMenu(dataModel: childOptions)
            
            
        case self.brandView:
            
            let hasChild = childOptions[index].child
            
            if hasChild == true {
                childId = item.retrievableValue as! Int
                self.mainBrandView.isHidden = false
                self.isBrand = true
                self.isType = false
                propViewModel.didLoadChild(childId: childId)
            } else {
                self.mainBrandView.isHidden = true
                self.isBrand = false
            }
            
        case self.modelView:
            
            let hasChild = childOptions[index].child
            
            if hasChild == true {
                childId = item.retrievableValue as! Int
                self.mainTypeView.isHidden = false
                self.isType = true
                self.isBrand = false
                propViewModel.didLoadChild(childId: childId)
            } else {
                self.mainTypeView.isHidden = true
                self.isType = false
            }
            
            
        default:
            break
        }
    }
    
    func swiftyMenu(willExpand swiftyMenu: SwiftyMenu) {
        print("SwiftyMenu willExpand.")
    }
    
    func swiftyMenu(didExpand swiftyMenu: SwiftyMenu) {
        print("SwiftyMenu didExpand.")
    }
    
    func swiftyMenu(willCollapse swiftyMenu: SwiftyMenu) {
        print("SwiftyMenu willCollapse.")
    }
    
    func swiftyMenu(didCollapse swiftyMenu: SwiftyMenu) {
        print("SwiftyMenu didCollapse.")
    }
    
}
