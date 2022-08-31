import Foundation
import RxSwift


let disposeBag = DisposeBag()

print("---------- PublishSubject ----------")
enum publishError: Error {
    case error1
}

let publishSubject = PublishSubject<String>()

publishSubject.onNext("hello everyone")

let subscriber1 = publishSubject
    .subscribe(onNext: {
        print("sub1:\($0)")
    })

publishSubject.onNext("who are you?")
publishSubject.onNext("I'm taejun")

subscriber1.dispose()

let subscriber2 = publishSubject
    .subscribe(onNext: {
        print("sub2: \($0)")
    })

publishSubject.onNext("last...?")
publishSubject.onCompleted()

publishSubject.onNext("did it die..?")

subscriber2.dispose()

publishSubject
    .subscribe {
        print("sub3:", $0.element ?? $0)
    }
    .disposed(by: disposeBag)

publishSubject.onNext("will it print?")


print("---------- BehaviorSubject ----------")
enum SubjectError: Error {
    case error1
}

let behaviorSubject = BehaviorSubject(value: "initial value")

behaviorSubject.onNext("first element")

behaviorSubject
    .subscribe {
        print("sub1:", $0.element ?? $0)
    }
    .disposed(by: disposeBag)

behaviorSubject.onError(SubjectError.error1)

behaviorSubject
    .subscribe {
        print("sub2:", $0.element ?? $0)
    }
    .disposed(by: disposeBag)

let value = try? behaviorSubject.value()
print("value:", value ?? "No value")

print("---------- ReplaySubject ----------")
let replaySubject = ReplaySubject<String>.create(bufferSize: 2)

replaySubject.onNext("1")
replaySubject.onNext("2")
replaySubject.onNext("3")

replaySubject
    .subscribe {
        print("sub1:", $0.element ?? $0)
    }
    .disposed(by: disposeBag)

replaySubject.onNext("4")

replaySubject
    .subscribe {
        print("sub2:", $0.element ?? $0)
    }
    .disposed(by: disposeBag)

replaySubject.onNext("5")
replaySubject.onError(SubjectError.error1)
//replaySubject.onCompleted()
replaySubject.dispose()

replaySubject
    .subscribe {
        print("sub3:", $0.element ?? $0)
    }
    .disposed(by: disposeBag)
