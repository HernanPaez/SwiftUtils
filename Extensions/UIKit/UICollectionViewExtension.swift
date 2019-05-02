//
//  UICollectionViewExtension.swift
//  Den
//
//  Created by admin on 15/1/19.
//  Copyright © 2019 InfinixSoft. All rights reserved.
//


import UIKit

extension UICollectionView {
    
    func horizontalPaginationWhenScrollViewWillEndDragging(pageWidth:Float,minSpace:Float = 0,scrollView:UIScrollView,numberOfItems:Int,targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        targetContentOffset.pointee = scrollView.contentOffset
        
        var cellToSwipe:Double = Double(Float((scrollView.contentOffset.x))/Float((pageWidth+minSpace))) + Double(0.5)
        if cellToSwipe < 0 {
            cellToSwipe = 0
        } else if cellToSwipe >= Double(numberOfItems) {
            cellToSwipe = Double(numberOfItems) - Double(1)
        }
        
        let indexPath:IndexPath = IndexPath(row: Int(cellToSwipe), section:0)
        self.scrollToItem(at:indexPath, at: UICollectionView.ScrollPosition.left, animated: true)
    }
    
    func indexPathOfMiddleCellOnTheVisibleCollectionFrame() -> IndexPath? {
        
        var visibleRect = CGRect()
        
        visibleRect.origin = self.contentOffset
        visibleRect.size = self.bounds.size
        
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        
        let visibleIndexPath: IndexPath? = self.indexPathForItem(at: visiblePoint)
        
        return visibleIndexPath
    }
}


