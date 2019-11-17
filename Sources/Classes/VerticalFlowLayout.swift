//
//  RowItem
//  A declarative framework for building vertically-stacked views
//

//  Copyright © 2019 Sardorbek Ruzmatov
//

import Foundation
import UIKit

// Unlike "horizontal" counterpart,
// this class handles resizing behavior upon device orientation

public class VerticalFlowLayout: UICollectionViewFlowLayout {
   
   internal let identifier:String
   private let itemHeight: CGFloat
   private let itemWidth: CGFloat
   private var spacing: CGFloat = 10
   private var width: CGFloat = 0
   private var numberOfItems = 0
   private var contentSizeCalculator:ContentSizeCalculator?
   
   public init(identifier:String, cellSize:CGSize = CGSize(width: 100, height: 100)) {
      self.identifier = identifier
      self.itemWidth = cellSize.width
      self.itemHeight = cellSize.height
      super.init()
      self.scrollDirection = .vertical
   }
   required public init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   
   // MARK:- Internal properties
   
   public var componentHeight:CGFloat {
      return contentSizeCalculator?.contentHeight ?? 0
   }
   
   private func frameForItem(for indexPath: IndexPath) -> CGRect {
      return contentSizeCalculator?.rectFor(indexPath.row) ?? .zero
   }
   
   
   // MARK:- UICollectionViewFlowLayout
   
   override public func prepare() {
      super.prepare()
      guard let collectionView = collectionView else { return }
      
      width = collectionView.bounds.width
      numberOfItems = collectionView.numberOfItems(inSection: 0)
      contentSizeCalculator = ContentSizeCalculator(itemWidth: itemWidth, itemHeight: itemHeight, spacing: spacing, containerWidth: width, itemCount: numberOfItems, identifier: identifier)
   }
   
   override public var collectionViewContentSize: CGSize {
      guard let contentSizeCalculator = contentSizeCalculator else { return .zero }
      return CGSize(width: width, height: contentSizeCalculator.contentHeight)
   }
   
   // This function is called periodically, using rects that the collection view is asking for.
   override public func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
      
      // You could optimise here by not checking every single index path in the collection view
      let attributes: [UICollectionViewLayoutAttributes] = (0..<self.numberOfItems).compactMap {
         let indexPath = IndexPath(item: $0, section: 0)
         let frame = self.frameForItem(for: indexPath)
         if !frame.intersects(rect) {
            return nil
         }
         return self.layoutAttributesForItem(at: indexPath)
      }
      return attributes
   }
   
   
   override public func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
      let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
      attributes.frame = frameForItem(for: indexPath)
      return attributes
   }
   
}



