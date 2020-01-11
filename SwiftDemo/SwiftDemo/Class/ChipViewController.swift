//
//  ChipViewController.swift
//  SwiftDemo
//
//  Created by David Thorn on 12.01.20.
//  Copyright © 2020 David Thorn. All rights reserved.
//

import UIKit

extension NSString: ChipViewModelProtocol {
    var title: String {
        return String(self)
    }
    
    func calculateSize() -> CGSize {
        return size(withAttributes: [NSAttributedStringKey.font: UIFont(name: "HelveticaNeue-Bold", size: 15)!])
    }
}

class ChipViewController<T: ChipViewModelProtocol>: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    typealias ViewModel = T
    private var layout = ChipViewFlowLayout()
    private lazy var collectionView = ChipCollectionView(frame: .zero, collectionViewLayout: layout)
    
    let itemPadding = 12
    var chipViewModels: [ViewModel] = []
    
    convenience init(layout: ChipViewFlowLayout) {
        self.init(nibName: nil, bundle: nil)
        self.layout = layout
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        
        collectionView.register(ChipViewCell.self, forCellWithReuseIdentifier: String(describing: ChipViewCell.self))
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6, constant: 0),
            collectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6, constant: 0),
            ])
        
        collectionView.layout?.itemSizeAtIndexPath = { [weak self] indexPath in
            guard let strongSelf = self else { return .zero }
            
            return strongSelf.collectionView(strongSelf.collectionView, itemSizeAt: indexPath)
        }
    }
    
    // MARK: -
    // MARK: - UICollectionView Delegate & Datasource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chipViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let indentifier = String(describing: ChipViewCell.self)
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: indentifier, for: indexPath) as? ChipViewCell else {
            return UICollectionViewCell()
        }
        
        let view = ChipView<T>()
        cell.contentView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.leftAnchor.constraint(equalTo: cell.contentView.leftAnchor),
            view.rightAnchor.constraint(equalTo: cell.contentView.rightAnchor),
            view.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
            view.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor),
            ])
        view.setup(viewModel: chipViewModels[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView:UICollectionView, itemSizeAt indexPath:NSIndexPath) -> CGSize {
        let title = chipViewModels[indexPath.row]
        var size = title.calculateSize()
        size.width = CGFloat(ceilf(Float(size.width + CGFloat(itemPadding * 2))))
        size.height = 24
        
        //...Checking if item width is greater than collection view width then set item width == collection view width.
        if size.width > collectionView.frame.size.width {
            size.width = collectionView.frame.size.width
        }
        
        return size;
    }
    
}
