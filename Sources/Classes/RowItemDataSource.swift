//
//  RowItem
//  A declarative framework for building vertically-stacked views
//

//  Copyright © 2019 Sardorbek Ruzmatov
//

import Foundation
import UIKit

private let kRowItemCellIdentifier = "RowItemCellIdentifier"

internal class RowItemDataSource:NSObject, UITableViewDataSource, UITableViewDelegate{
   
   private var items:[RowItem]
   private weak var containerTableView:UITableView!
   
   public init(containerTableView:UITableView, items:[RowItem]) {
      self.items = items
      self.containerTableView = containerTableView
      containerTableView.register(RowItemCell.self, forCellReuseIdentifier: kRowItemCellIdentifier)
      super.init()
   }
   
   private func hookRowItem(onto tableView:UITableView, cell:RowItemCell, indexPath:IndexPath){
      let rowItem = items[indexPath.row]
      let viewWidth = tableView.frame.size.width
      cell.adapt(to: rowItem, width: viewWidth)
      
      if let collectionView = rowItem.view as? UICollectionView {
         guard let collectionViewDefinition = rowItem.collectionViewDefinition else {
            fatalError("Collection view configuration has failed. Specify a collection-view configuration object for \(rowItem.identifier)")
         }
         
         collectionView.dataSource = collectionViewDefinition.dataSource
         collectionView.delegate = collectionViewDefinition.delegate
         
         let collectionViewCellDefinition = collectionViewDefinition.cellDefinition
         
         if let nibFilename = collectionViewCellDefinition.nibFilename {
            let bundle = Bundle(for: collectionViewCellDefinition.cellClass)
            let nibFile = UINib(nibName: nibFilename, bundle: bundle)
            collectionView.register(nibFile, forCellWithReuseIdentifier: collectionViewCellDefinition.cellIdentifier)
         } else {
            collectionView.register(collectionViewCellDefinition.cellClass, forCellWithReuseIdentifier: collectionViewCellDefinition.cellIdentifier)
         }
      }
   }
   
   // MARK:- UITableViewDelegate
   
   public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: kRowItemCellIdentifier) as! RowItemCell
      hookRowItem(onto: tableView, cell:cell, indexPath: indexPath)
      return cell
   }
   
   public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return items.count
   }
   
   public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      let item = items[indexPath.row]
      return item.height
   }

   public func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
      // allow click events to be managed individually
      // works better rather than tv.allowsSelection = false
      return false
      
   }
}
