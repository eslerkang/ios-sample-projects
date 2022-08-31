import Foundation
import RxSwift


let disposeBag = DisposeBag()

enum TestError: Error {
    case test
}


print("---------- IgnoreElements ----------")
let sleepMode = PublishSubject<String>()

sleepMode
    .ignoreElements()
    .subscribe {
        print($0.element ?? $0)
    }
    .disposed(by: disposeBag)

sleepMode.onNext("⚡️")
sleepMode.onNext("⚡️")

sleepMode.onCompleted()

print("---------- ElementAt ----------")
let twoToWake = PublishSubject<String>()

twoToWake
    .element(at: 2)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

twoToWake.onNext("🌚")
twoToWake.onNext("🌚")
twoToWake.onNext("🌝")
twoToWake.onNext("🌚")

print("---------- Filter ----------")
Observable.of(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
    .filter {
        $0 % 2 == 0
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("---------- Skip ----------")
Observable.of(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
    .skip(3)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("---------- SkipWhile ----------")
Observable.of(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
    .skip(while: {
        $0 != 5
    })
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("---------- SkipUntil ----------")
let customer = PublishSubject<String>()
let openAlarm = PublishSubject<String>()

customer
    .skip(until: openAlarm)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

customer.onNext("1hi")
customer.onNext("2hi")

openAlarm.onNext("click!")

customer.onNext("3hi")

print("---------- Take ----------")
Observable.of(1, 2, 3, 4, 5, 6, 7)
    .take(3)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("---------- TakeWhile ----------")
Observable.of(1, 2, 3, 4, 5, 6, 7, 8, 9)
    .take(while: {
        $0 < 6
    })
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("---------- TakeUntil ----------")
let customer2 = PublishSubject<String>()
let closeAlarm = PublishSubject<String>()

customer2
    .take(until: closeAlarm)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

customer2.onNext("1")
customer2.onNext("2")

closeAlarm.onNext("click!")

customer2.onNext("3")

print("---------- Enumerated ----------")
Observable<Int>.of(1, 2, 3, 4, 5, 6, 7)
    .enumerated()
    .take(while: {
        $0.index < 3
    })
    .subscribe(onNext: {
        print($0.element)
    })
    .disposed(by: disposeBag)

print("---------- DistinctUntilChange ----------")
Observable<Int>.of(1, 1, 2, 2, 2, 3, 3, 4, 4, 4, 4, 5, 5, 1, 1, 1)
    .distinctUntilChanged()
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
