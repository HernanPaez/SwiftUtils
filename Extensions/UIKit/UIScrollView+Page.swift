//
//  UIScrollView+Page.swift
//  Mosaic Golf
//
//  Created by Hernan Paez on 05/06/2018.
//  Copyright © 2018 InfinixSoft. All rights reserved.
//

import UIKit

extension UIScrollView {
    var numberOfPages:Int {
        return Int(round(contentSize.width / frame.size.width))
    }
    
    var currentPage:Int {
        let indexOfPage = Int(round(contentOffset.x / frame.size.width))
        return indexOfPage
    }
    
    func setCurrentPage(_ page:Int, animated:Bool = false) {
        var offset = CGPoint(x: 0, y: 0)
        offset.x = CGFloat(page) * frame.size.width
        self.setContentOffset(offset, animated: animated)
    }
}
