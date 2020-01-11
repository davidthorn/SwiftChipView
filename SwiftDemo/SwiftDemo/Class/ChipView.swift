//
//  ChipView.swift
//  SwiftDemo
//
//  Created by David Thorn on 12.01.20.
//  Copyright © 2020 David Thorn. All rights reserved.
//

import UIKit

final class ChipView<T: ChipViewModelProtocol>: UIView {
    
    typealias ViewModel = T
    
    private let labelTitle = UILabel()
    
    var viewModel: ViewModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func setup(viewModel: ViewModel) {
        labelTitle.text = viewModel.title
    }
    
    func commonInit() {
        addSubview(labelTitle)
        labelTitle.textAlignment = .center
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .red
        labelTitle.textColor = .white
        
        NSLayoutConstraint.activate([
            labelTitle.leftAnchor.constraint(equalTo: leftAnchor),
            labelTitle.rightAnchor.constraint(equalTo: rightAnchor),
            labelTitle.topAnchor.constraint(equalTo: topAnchor),
            labelTitle.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.size.height / 2
    }
}
