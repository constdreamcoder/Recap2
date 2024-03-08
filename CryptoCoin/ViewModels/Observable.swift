//
//  Observable.swift
//  CryptoCoin
//
//  Created by SUCHAN CHANG on 3/1/24.
//

import Foundation

final class Observable<T> {
    
    private var closure: ((T) -> Void)?
    
    var value: T {
        didSet {
            closure?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping (T) -> Void) {
        closure(value) // bind 사용 이유: 클로저를 한번 더 실행해줄 수 있기 때문에
        self.closure = closure
    }
}
