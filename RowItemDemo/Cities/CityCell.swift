//
//  CityCell.swift
//  ExampleApp
//

import UIKit

class CityCell: UICollectionViewCell {
   
   private let label = UILabel()
   
   var city:City? {
      didSet {
         if let city = city {
            label.text = "Name: \(city.name)\nContinent: \(city.continent)\nPopulation: \(city.population)"
         }
      }
   }
   
   override func layoutSubviews() {
      super.layoutSubviews()
      backgroundColor = .lightGray

      if label.superview == nil {
         contentView.addSubview(label)
         label.numberOfLines = 0
         label.font = UIFont(name: "SanFrancisco", size: 20)
         label.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(10)
            make.right.bottom.equalToSuperview().offset(-15)
         }
      }
   }
}
