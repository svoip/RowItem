//
//  DemoItemsProvider.swift
//  ExampleApp
//

import Foundation
import UIKit
import RowItem

public class DemoItemsProvider: RowItemsProvider{
   
   public var rowItems: [RowItem] {
      var items = [RowItem]()
      items.append(personsCarousel())
      items.append(citiesGrid())
      items.append(halfView())
      items.append(textView())
      return items
   }
   
   lazy var cityDataSource: CitiesDataSource = {
      return CitiesDataSource()
   }()
   
   private func personsCarousel()->RowItem {
      
      let cellSize = CGSize(width: 140, height: 180)
      let layout = HorizontalFlowLayout(cellSize: cellSize)
      
      let itemHeightBlock:HeightBlock = { size in
         return cellSize.height + 10 // so that cells have a minimum of padding
      }
      
      let delegate = DelegateFlowLayout(cellSize: cellSize) { (_, indexPath) in
         guard let topViewController = topViewController() else { return }
         let viewController = LabelViewController.newInstance()
         viewController.info = "Selected person index: \(indexPath.row)"
         topViewController.present(embeddedInNavigationController(viewController), animated: true, completion: nil)
      }
      
      let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
      view.backgroundColor = Random.color()
      
      let collectionViewCellDefinition = CollectionViewCellDefinition(
         cellIdentifier: PersonCell.reuseIdentifier,
         nibFilename: nil,
         cellClass: PersonCell.self
      )
      
      let collectionViewDefinition = CollectionViewDefinition(
         layout: layout,
         dataSource: PersonsDataSource(),
         delegate: delegate,
         cellDefinition: collectionViewCellDefinition
      )
      
      return RowItem(
         view: view,
         heightBlock: itemHeightBlock,
         collectionViewDefinition: collectionViewDefinition,
         identifier: .carousel
      )
      
   }
   
   private func citiesGrid()->RowItem {
      
      let cellSize = CGSize(width: 250, height: 150)
      let viewUuid = UUID().uuidString
      let layout = VerticalFlowLayout(identifier: viewUuid, cellSize: cellSize)
      
      let viewHeightBlock:HeightBlock = { size in
         return layout.componentHeight
      }
      
      let delegate = DelegateFlowLayout (cellSize: cellSize){ [weak self] (_, indexPath) in
         guard let topViewController = topViewController() else { return }
         let viewController = LabelViewController.newInstance()
         if let self = self, let city = self.cityDataSource.objectAt(index: indexPath.row) {
            viewController.info = "Selected city: \n\(city)"
         }
         else {
            viewController.title = "Selected city index: \(indexPath.row)"
         }
         topViewController.present(embeddedInNavigationController(viewController), animated: true, completion: nil)
         
      }
      
      let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
      view.backgroundColor = Random.color()
      
      let collectionViewCellDefinition = CollectionViewCellDefinition(
         cellIdentifier: CityCell.reuseIdentifier,
         nibFilename: nil,
         cellClass: CityCell.self
      )
      
      let collectionViewDefinition = CollectionViewDefinition(
         layout: layout,
         dataSource: self.cityDataSource,
         delegate: delegate,
         cellDefinition: collectionViewCellDefinition
      )
      
      return RowItem(
         view: view,
         heightBlock: viewHeightBlock,
         collectionViewDefinition: collectionViewDefinition,
         identifier: .grid(uuid: viewUuid)
      )
      
   }
   
   
   // view that takes up half the height of its superview
   private func halfView()->RowItem{
      
      let itemHeightBlock:HeightBlock = { containerSize in
         return containerSize.height / 2
      }
      
      let view = UIView()
      view.backgroundColor = Random.color()
      
      let label = UILabel()
      label.text = "Half-size view"
      label.backgroundColor = .lightGray
      label.textAlignment = .center
      view.addSubview(label)
      
      label.snp.makeConstraints { make in
         make.center.equalToSuperview()
         make.width.equalTo(200)
         make.height.equalTo(50)
      }
      
      return RowItem(
         view: view,
         heightBlock: itemHeightBlock,
         collectionViewDefinition: nil
      )
   }
   
   
   private func textView()->RowItem{
      
      let contentText = "Nulla in condimentum orci, malesuada eleifend augue. Lorem ipsum dolor sit amet, consectetur adipiscing elit. In urna elit, imperdiet convallis massa nec, sodales accumsan orci. Proin sed placerat est. Maecenas sed diam vitae diam pulvinar mattis ac quis ante. Donec at tincidunt libero, a auctor purus. Donec dictum turpis eu magna faucibus luctus. Nam eget ligula nec massa sollicitudin volutpat."
      
      let textView = UITextView()
      textView.text = contentText
      textView.backgroundColor = .lightGray
      textView.textAlignment = .left
      textView.isEditable = false
      
      let itemHeightBlock:HeightBlock = { size in
         let adaptedSize = textView.sizeThatFits(size)
         return adaptedSize.height
      }
      
      return RowItem(
         view: textView,
         heightBlock: itemHeightBlock,
         collectionViewDefinition: nil
      )
   }
   
}
