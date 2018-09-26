//
//  SimplePickerViewDriver.swift
//  GoTree
//
//  Created by Hernan Paez on 07/08/2018.
//  Copyright © 2018 InfinixSoft. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

protocol SimplePickerItem {
    var title:String { get }
}

class SimplePickerViewDriver : NSObject {
    let items = BehaviorRelay(value:[SimplePickerItem]())
    let selectedItem = BehaviorRelay<SimplePickerItem?>(value: nil)
    
    private let picker:UIPickerView
    private let disposeBag = DisposeBag()
    
    var defaultTitle:String = "-------------" {
        didSet {
            picker.reloadAllComponents()
        }
    }

    init(picker:UIPickerView) {
        self.picker = picker
        super.init()
        
        picker.delegate = self
        picker.dataSource = self
        picker.reloadAllComponents()
        
        items
            .asDriver()
            .drive(
                onNext: {[weak self] (items) in
                    self?.selectedItem.accept(nil)
                    self?.picker.reloadAllComponents()
            })
            .disposed(by: disposeBag)
    }
}

extension SimplePickerViewDriver : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return items.value.count + 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard row != 0 else {
            return defaultTitle
        }
        return items.value[row-1].title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard row != 0 else {
            self.selectedItem.accept(nil)
            return
        }
        self.selectedItem.accept(items.value[row-1])
    }
}
