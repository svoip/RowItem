//
//  RowItem
//  A declarative framework for building vertically-stacked views
//

//  Copyright © 2019 Sardorbek Ruzmatov
//

import UIKit

// Define reasons that invoke how row item views are rendered
enum RenderOption {
   case viewDidLoad
   case viewSizeDidChange
   case rerender
}

extension CGFloat {
   static var unresolvedHeight: CGFloat { return  0 }
}
private let kVerticalPadding: CGFloat = 2

extension Notification.Name {
   static let RenderRowItemNotification = Notification.Name("RenderRowItemNotification")
}


public protocol RowItemsProvider {
   var rowItems:[RowItem] { get }
}

public class RowItemContainerController: UIViewController {
   
   private var rowItemDataSource:RowItemDataSource!
   private var containerTableView:UITableView!
   private var items:[RowItem]
   private var pendingIdentifiers = Set<String>()
   
   public init(items:[RowItem]) {
      // add spacing between each row items
      self.items = RowItemContainerController.parseRowItems(items)
      super.init(nibName: nil, bundle: nil)
      
   }
   
   public required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   // MARK:- Maintenance
   
   // add a padding between every element
   private class func parseRowItems(_ input:[RowItem])->[RowItem]{
      var array = [RowItem]()
      
      for elem in input {
         // add the main row item
         array.append(elem)
         
         // add the 'padding' row item
         array.append(paddingItem())
         
      }
      return array
   }
   
   
   static func paddingItem(_ padding:CGFloat = kVerticalPadding)->RowItem {
      
      let heightBlock:HeightBlock = { size in
         return padding
      }
      
      let paddingView = UIView()
      return RowItem(
         view: paddingView,
         heightBlock: heightBlock,
         collectionViewDefinition: nil,
         identifier: .padding
      )
   }
   
   
   
   public override func viewDidLoad() {
      super.viewDidLoad()
      
      // create underlying view
      containerTableView = UITableView(frame: .zero, style: .plain)
      containerTableView.frame = view.bounds
      view.addSubview(containerTableView)
      
      // configure
      containerTableView.estimatedRowHeight = 0
      containerTableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
      containerTableView.tableFooterView = UIView()
      
      render(items: items, toSize: view.frame.size, with: .viewDidLoad)
   }
   
   override public func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
      super.viewWillTransition(to: size, with: coordinator)
      
      render(items: items, toSize: size, with: .viewSizeDidChange)
   }
   
   
   // MARK:- Rendering
   
   internal func render(items:[RowItem], toSize size: CGSize, with option:RenderOption){
      
      let updatedItems:[RowItem]
      
      if option == .rerender {
         updatedItems = items.map( { item -> RowItem in
            var newItem = item
            if item.height == CGFloat.unresolvedHeight {
               newItem.height = newItem.heightBlock( size )
            }
            return newItem
         })
      }
      else {
         updatedItems = items.map( { item -> RowItem in
            var newItem = item
            newItem.height = newItem.heightBlock( size )
            return newItem
         })
      }
      
      switch option {
      case .viewDidLoad, .viewSizeDidChange:
         
         let identifiers = updatedItems.map { (rowItem) -> String? in
            switch rowItem.identifier {
            case .grid(uuid: let uuid):
               return uuid
            default:
               return nil
            }
         }.compactMap { $0 }
         
         
         pendingIdentifiers = Set( identifiers.map{ $0 })
         NotificationCenter.default.addObserver(self, selector: #selector(sizesReceivedUID(_:)), name: .RenderRowItemNotification, object: nil)
         
      default: break
      }
      
      let itemsDataSource = RowItemDataSource(containerTableView: containerTableView, items: updatedItems)
      containerTableView.dataSource = itemsDataSource
      containerTableView.delegate = itemsDataSource
      rowItemDataSource = itemsDataSource
      
   }
   
   @objc func sizesReceivedUID(_ not:Notification){
      
      guard let payload = not.object as? [String:Any] else { return }
      guard let identifier = payload["id"] as? String else { return }
      
      if let size = payload["size"] as? CGFloat {
         
         // update items (only for 'grid' types)
         let updatedItems = items.map( { item -> RowItem in
            var newItem = item
            switch item.identifier {
            case .grid(uuid: let confUuid):
               if confUuid == identifier {
                  newItem.height = size
               }
            default: break
            }
            
            return newItem
         })
         
         items = updatedItems
         
      }
      
      pendingIdentifiers.remove(identifier)
      
      if pendingIdentifiers.isEmpty {
         NotificationCenter.default.removeObserver(self, name: .RenderRowItemNotification, object: nil)
      }
      
      render(items: items, toSize: view.frame.size, with: .rerender)
   }
   
}
