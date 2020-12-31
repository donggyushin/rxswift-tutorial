import UIKit
import RxSwift
import RxCocoa

let disposeBag = DisposeBag()

let relay = BehaviorRelay(value: ["Item 1"])

relay.asObservable().subscribe {
    print($0)
}

var value = relay.value
value.append("Item 2")

relay.accept(value)

