//
//  HorizontallyCenteredCollectionViewFlowLayout.swift
//  Den
//
//  Created by admin on 15/1/19.
//  Copyright © 2019 InfinixSoft. All rights reserved.
//

import UIKit

class HorizontallyCenteredCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
        
        scrollDirection = .horizontal
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        guard let cv = self.collectionView,
            let attributesForVisibleCells = self.layoutAttributesForElements(in: cv.bounds) else {
                return super.targetContentOffset(forProposedContentOffset: proposedContentOffset)
        }
        
        let halfWidth = cv.bounds.size.width * 0.5
        let proposedContentOffsetCenterX = proposedContentOffset.x + halfWidth
        
        var candidateAttributes : UICollectionViewLayoutAttributes?
        for attributes in attributesForVisibleCells {
            
            // == Skip comparison with non-cell items (headers and footers) == //
            if attributes.representedElementCategory != UICollectionView.ElementCategory.cell {
                continue
            }
            
            if let candAttrs = candidateAttributes {
                let a = attributes.center.x - proposedContentOffsetCenterX
                let b = candAttrs.center.x - proposedContentOffsetCenterX
                
                if fabsf(Float(a)) < fabsf(Float(b)) {
                    candidateAttributes = attributes
                }
                
            } else { // == First time in the loop == //
                candidateAttributes = attributes
            }
            
        }
        
        return CGPoint(x : candidateAttributes!.center.x - halfWidth, y : proposedContentOffset.y)
    }
    
}
