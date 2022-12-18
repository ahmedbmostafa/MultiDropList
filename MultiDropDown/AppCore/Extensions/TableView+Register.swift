//
//  TableView+Register.swift
//  SeamsLabTask
//
//  Created by ahmed mostafa on 31/01/2022.
//

import UIKit

extension UITableView {
    func registerNib(identifier: String) {
         let tableNib = UINib(nibName: identifier, bundle: nil)
         self.register(tableNib, forCellReuseIdentifier: identifier )
     }
}

extension UICollectionView{
    
    func registerCellNib<Cell: UICollectionViewCell>(cellClass: Cell.Type){
           self.register(UINib(nibName: String(describing: Cell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: Cell.self))
       }
       
       
       func dequeue<Cell: UICollectionViewCell>(for indexPath: IndexPath) -> Cell{
           let identifier = String(describing: Cell.self)
           
           guard let cell = self.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? Cell else {
               fatalError("Error in cell")
           }
           
           return cell
       }
}
