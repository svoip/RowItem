//
//  PersonsDataSource.swift
//  ExampleApp
//

import Foundation
import UIKit

class PersonsDataSource:NSObject, UICollectionViewDataSource {
   
   private let persons:[Person] = (22..<32).map({ age in
      Person(name: randomName(), age: age)
   })
   
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return persons.count
   }
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PersonCell.reuseIdentifier, for: indexPath) as! PersonCell
      cell.person = persons[indexPath.row]
      return cell
   }
}

extension PersonsDataSource {
   
   private static let names = ["Sally", "Bob", "Michael", "Don", "Jessie", "Dustin", "Nicholas"]
   static func randomName()->String {
      return names.randomElement() ?? ""
   }
   
}
