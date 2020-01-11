//
//  ChipCollectionView.swift
//  SwiftDemo
//
//  Created by David Thorn on 12.01.20.
//  Copyright © 2020 David Thorn. All rights reserved.
//

import UIKit

final class ChipCollectionView: UICollectionView {
    
    var layout: ChipViewFlowLayout? {
        return collectionViewLayout as? ChipViewFlowLayout
    }
    
    init(frame: CGRect, collectionViewLayout layout: ChipViewFlowLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() { }
    
}
