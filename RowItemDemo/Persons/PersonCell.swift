//
//  PersonCell.swift
//  ExampleApp
//

import Foundation
import UIKit
import SnapKit

class PersonCell: UICollectionViewCell {
   
   private let label = UILabel()
   
   var person:Person? {
      didSet {
         if let person = person {
            label.text = "Name:\(person.name)\nAge: \(person.age)"
         }
      }
   }
   
   override func layoutSubviews() {
      super.layoutSubviews()
      backgroundColor = .lightGray
      
      if label.superview == nil {
         contentView.addSubview(label)
         label.numberOfLines = 0
         label.font = UIFont(name: "Avenir", size: 15)
         label.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(5)
            make.right.bottom.equalToSuperview().offset(-5)
         }
      }
   }
   
}
