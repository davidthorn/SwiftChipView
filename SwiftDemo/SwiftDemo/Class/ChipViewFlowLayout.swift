//
//  ChipViewFlowLayout.swift
//  SwiftDemo
//
//  Created by David Thorn on 12.01.20.
//  Copyright © 2020 David Thorn. All rights reserved.
//

import UIKit

final class ChipViewFlowLayout: UICollectionViewFlowLayout {
    
    private let interItemSpacing:CGFloat = 5.0
    private let lineSpacing:CGFloat = 5.0
    
    private var attributesCache: [UICollectionViewLayoutAttributes] = []
    private var contentSize = CGSize.zero
    
    var itemSizeAtIndexPath: (_ indexPath: NSIndexPath) -> CGSize = { _ in return .zero }
    
    override var collectionViewContentSize: CGSize {
        return contentSize
    }
    
    // MARK:-
    // MARK:- Initialize
    
    override init() {
        super.init()
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        scrollDirection = UICollectionViewScrollDirection.vertical;
        minimumLineSpacing = lineSpacing
        minimumInteritemSpacing = interItemSpacing
    }
    
    // MARK:-
    // MARK:- Override
    
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView, collectionView.numberOfSections > 0 else { return }
        
        let numberOfItems = collectionView.numberOfItems(inSection: 0)
        
        guard numberOfItems > 0 else { return }
        
        var contentSizeWidth: CGFloat = 0.0
        var contentSizeHeight: CGFloat = 0.0
        var iSize: CGSize = CGSize.zero
        
        var indexPath: NSIndexPath
        
        attributesCache = []
        
        for index in 0..<numberOfItems {
            indexPath = NSIndexPath(item: index, section: 0)
            iSize = itemSizeAtIndexPath(indexPath)
            
            var itemRect = CGRect(x: contentSizeWidth, y: contentSizeHeight, width: iSize.width, height: iSize.height)
            if contentSizeWidth > 0 && (contentSizeWidth + iSize.width + minimumInteritemSpacing > collectionView.frame.size.width) {
                itemRect.origin.x = 0
                itemRect.origin.y = contentSizeHeight + iSize.height + minimumLineSpacing
            }
            
            let itemAttributes = UICollectionViewLayoutAttributes(forCellWith: indexPath as IndexPath)
            itemAttributes.frame = itemRect
            attributesCache.append(itemAttributes)
            
            contentSizeWidth = itemRect.origin.x + iSize.width + minimumInteritemSpacing
            contentSizeHeight = itemRect.origin.y
        }
        
        contentSizeHeight += iSize.height + minimumLineSpacing
        contentSizeWidth = 0
        
        contentSize = CGSize(width: collectionView.frame.size.width, height: contentSizeHeight)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let collectionView = collectionView else { return nil }
        
        let numberOfItems = collectionView.numberOfItems(inSection: 0)
        return attributesCache.filter {
            $0.frame.intersects(rect) && $0.indexPath.row < numberOfItems
        }
        
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return attributesCache.first { $0.indexPath == indexPath }
    }
}
