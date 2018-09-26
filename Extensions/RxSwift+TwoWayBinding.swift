//
//  RxSwift+TwoWayBinding.swift
//  Apparcar
//
//  Created by Steve on 8/31/17.
//  Copyright © 2017 Infinixsoft. All rights reserved.
//

#if !RX_NO_MODULE
  import RxSwift
  import RxCocoa
#endif

import UIKit

infix operator <-> : DefaultPrecedence

func nonMarkedText(_ textInput: UITextInput) -> String? {
  let start = textInput.beginningOfDocument
  let end = textInput.endOfDocument
  
  guard let rangeAll = textInput.textRange(from: start, to: end),
    let text = textInput.text(in: rangeAll) else {
      return nil
  }
  
  guard let markedTextRange = textInput.markedTextRange else {
    return text
  }
  
  guard let startRange = textInput.textRange(from: start, to: markedTextRange.start),
    let endRange = textInput.textRange(from: markedTextRange.end, to: end) else {
      return text
  }
  
  return (textInput.text(in: startRange) ?? "") + (textInput.text(in: endRange) ?? "")
}

func <-> <Base: UITextInput>(textInput: TextInput<Base>, variable: Variable<String>) -> Disposable {
  let bindToUIDisposable = variable.asObservable()
    .bind(to: textInput.text)
  
  let bindToVariable = textInput.text
    .subscribe(onNext: { [weak base = textInput.base] n in
      guard let base = base else {
        return
      }
      
      let nonMarkedTextValue = nonMarkedText(base)

      if let nonMarkedTextValue = nonMarkedTextValue, nonMarkedTextValue != variable.value {
        variable.value = nonMarkedTextValue
      }
      }, onCompleted:  {
        bindToUIDisposable.dispose()
    })
  
  return Disposables.create(bindToUIDisposable, bindToVariable)
}

func <-> <Base: UITextInput>(textInput: TextInput<Base>, behaviorRelay: BehaviorRelay<String>) -> Disposable {
  let bindToUIDisposable = behaviorRelay.asObservable()
    .bind(to: textInput.text)
  
  let bindToVariable = textInput.text
    .subscribe(onNext: { [weak base = textInput.base] n in
      guard let base = base else {
        return
      }
      
      let nonMarkedTextValue = nonMarkedText(base)

      if let nonMarkedTextValue = nonMarkedTextValue, nonMarkedTextValue != behaviorRelay.value {
        behaviorRelay.accept(nonMarkedTextValue)
      }
      }, onCompleted:  {
        bindToUIDisposable.dispose()
    })
  
  return Disposables.create(bindToUIDisposable, bindToVariable)
}

func <-> <T>(property: ControlProperty<T>, variable: Variable<T>) -> Disposable {
  let bindToUIDisposable = variable.asObservable()
    .bind(to: property)
  
  let bindToVariable = property
    .subscribe(onNext: { n in
      variable.value = n
    }, onCompleted:  {
      bindToUIDisposable.dispose()
    })
  
  return Disposables.create(bindToUIDisposable, bindToVariable)
}

func <-> <T>(property: ControlProperty<T>, behaviorRelay: BehaviorRelay<T>) -> Disposable {
  let bindToUIDisposable = behaviorRelay.asObservable()
    .bind(to: property)
  
  let bindToVariable = property
    .subscribe(onNext: { n in
      behaviorRelay.accept(n)
    }, onCompleted:  {
      bindToUIDisposable.dispose()
    })
  
  return Disposables.create(bindToUIDisposable, bindToVariable)
}
