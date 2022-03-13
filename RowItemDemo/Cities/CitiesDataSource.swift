//
//  CitiesDataSource.swift
//  ExampleApp
//

import Foundation
import UIKit


class CitiesDataSource:NSObject, UICollectionViewDataSource {
   
   private let cities:[City] = (1..<12).map({ _ in
      City(name: randomName(), continent: randomContinent(), population: randomPopulation())
   })
   
   func objectAt(index:Int)->City?{
      guard cities.count > index else { return nil }
      return cities[index]
   }
   
   
   public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return cities.count
   }
   
   public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CityCell.reuseIdentifier, for: indexPath) as! CityCell
      cell.city = cities[indexPath.row]
      return cell
   }
}

extension CitiesDataSource {
   
   private static let cities:[String] = ["Mount Auburn", "City", "Grad", "Stad", "Ville", "Stadt", "Borg", "Città", "Miestas", "Ciudad"]
   private static let continents:[String] = ["Africa", "Europe", "Americas", "Asia", "Antarctica"]
   private static let populations:[Int] = [1_000_000, 2_500_000, 1_200_000, 1_750_000, 1_250_300, 2_103_000, 3_505_000, 3_060_000, 4_200_000, 300_000]
   
   static func randomPopulation()->Int{
      return populations.randomElement() ?? 0
   }
   static func randomName()->String {
      return cities.randomElement() ?? ""
   }
   static func randomContinent()->String {
       return continents.randomElement() ?? ""
    }
   
}
