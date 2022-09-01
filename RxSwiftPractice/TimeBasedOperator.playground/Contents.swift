import Foundation
import RxSwift
import UIKit
import RxCocoa
import PlaygroundSupport

let disposeBag = DisposeBag()

print("---------- Replay ----------")
let hi = PublishSubject<String>()
let parrot = hi.replay(2)
parrot.connect()

hi.onNext("hello")
hi.onNext("hi")
hi.onNext("nice to see you")
parrot
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

hi.onNext("last?")

print("---------- ReplayAll ----------")
let doctor = PublishSubject<String>()
let timestone = doctor.replayAll()
timestone.connect()

doctor.onNext("dormamu")
doctor.onNext("~_~")
timestone
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

//print("---------- Buffer ----------")
//let source = PublishSubject<String>()
//
//var count = 0
//let timer = DispatchSource.makeTimerSource()
//
//timer.schedule(deadline: .now() + 2, repeating: .seconds(1))
//timer.setEventHandler {
//    count += 1
//    source.onNext("\(count)")
//}
//timer.resume()
//
//source
//    .buffer(timeSpan: .seconds(2), count: 2, scheduler: MainScheduler())
//    .subscribe(onNext: {
//        print($0)
//    })
//    .disposed(by: disposeBag)

//print("---------- Window ----------")
//let maxObservable = 2
//let makeTime = RxTimeInterval.seconds(2)
//
//let window = PublishSubject<String>()
//
//var windowCount = 0
//let windowTimeSource = DispatchSource.makeTimerSource()
//windowTimeSource.schedule(deadline: .now() + 2, repeating: .seconds(1))
//windowTimeSource.setEventHandler {
//    windowCount += 1
//    window.onNext("\(windowCount)")
//}
//windowTimeSource.resume()
//
//window
//    .window(timeSpan: makeTime, count: maxObservable, scheduler: MainScheduler())
//    .flatMapLatest { windowObservable -> Observable<(index: Int, element: String)> in
//        windowObservable.enumerated()
//    }
//    .subscribe(onNext: {
//        print("\($0.index)번째 Observable의 \($0.element)")
//    })
//    .disposed(by: disposeBag)

//print("---------- DelaySubscription ----------")
//let delaySource = PublishSubject<String>()
//
//var delayCount = 0
//let delayTimeSource = DispatchSource.makeTimerSource()
//delayTimeSource.schedule(deadline: .now()+2, repeating: .seconds(1))
//delayTimeSource.setEventHandler {
//    delayCount += 1
//    delaySource.onNext("\(delayCount)")
//}
//delayTimeSource.resume()
//
//delaySource
//    .delaySubscription(.seconds(5), scheduler: MainScheduler.instance)
//    .subscribe(onNext: {
//        print($0)
//    })
//    .disposed(by: disposeBag)

//print("---------- Delay ----------")
//let delaySubject = PublishSubject<Int>()
//
//var delayCount = 0
//let delayTimeSource = DispatchSource.makeTimerSource()
//delayTimeSource.schedule(deadline: .now(), repeating: .seconds(1))
//delayTimeSource.setEventHandler {
//    delayCount += 1
//    delaySubject.onNext(delayCount)
//}
//delayTimeSource.resume()
//
//delaySubject
//    .delay(.seconds(3), scheduler: MainScheduler.instance)
//    .subscribe(onNext: {
//        print($0)
//    })
//    .disposed(by: disposeBag)

//print("---------- Interval ----------")
//Observable<Int>
//    .interval(.seconds(3), scheduler: MainScheduler.instance)
//    .subscribe(onNext: {
//        print($0)
//    })
//    .disposed(by: disposeBag)


//print("---------- Timer ----------")
//Observable<Int>
//    .timer(
//        .seconds(3),
//        period: .seconds(2),
//        scheduler: MainScheduler.instance
//    )
//    .subscribe(onNext: {
//        print($0)
//    })
//    .disposed(by: disposeBag)

print("---------- TimeOut ----------")
let notClickError = UIButton(type: .system)
notClickError.setTitle("plz click", for: .normal)
notClickError.sizeToFit()

PlaygroundPage.current.liveView = notClickError

notClickError.rx.tap
    .do(onNext: {
        print("tap")
    })
    .timeout(.seconds(5), scheduler: MainScheduler.instance)
    .subscribe {
        print($0)
    }
    .disposed(by: disposeBag)
