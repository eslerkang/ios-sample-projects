import UIKit
import Foundation
import RxSwift
import os


print("---------- Just ----------")
Observable<Int>.just(1)
    .subscribe(onNext: {
        print($0)
    })

print("---------- Of 1 ----------")
Observable<Int>.of(1, 2, 3, 4, 5)
    .subscribe(onNext: {
        print($0)
    })

print("---------- Of 2 ----------")
Observable.of([1, 2, 3, 4, 5])
    .subscribe(onNext: {
        print($0)
    })

print("---------- From ----------")
Observable<Int>.from([1, 2, 3, 4, 5])
    .subscribe(onNext: {
        print($0)
    })


print("---------- Subscribe 1 ----------")
Observable<Int>.of(1, 2, 3, 4, 5)
    .subscribe {
        print($0)
    }


print("---------- Subscribe 2 ----------")
Observable<Int>.of(1, 2, 3, 4, 5)
    .subscribe {
        if let element = $0.element {
            print(element)
        }
    }


print("---------- Subscribe 3 ----------")
Observable<Int>.of(1, 2, 3)
    .subscribe(onNext: {
        print($0)
    })

print("---------- Empty ----------")
Observable<Void>.empty()
    .subscribe {
        print($0)
    }


print("---------- Never ----------")
Observable<Void>.never()
    .subscribe(onNext: {
        print($0)
    }, onCompleted: {
        print("hi")
    })


print("---------- Range ----------")
Observable<Int>.range(start: 1, count: 9)
    .subscribe(onNext: {
        print("2 * \($0) = \(2*$0)")
    })


print("---------- Dispose ----------")
Observable<Int>.of(1, 2, 3, 4, 5)
    .subscribe {
        print($0)
    }
    .dispose()



print("---------- DisposeBag ----------")
var disposeBag = DisposeBag()

Observable<Int>.of(1, 2, 3, 4, 5)
    .subscribe {
        print($0)
    }
    .disposed(by: disposeBag)


print("---------- Create 1 ----------")
Observable.create { observer -> Disposable in
    observer.onNext(1)
    observer.on(.next(3))
    observer.onCompleted()
    observer.onNext(2)
    
    return Disposables.create()
}
.subscribe(onNext: {
    print($0)
}, onCompleted: {
    print("completed")
}, onDisposed: {
    print("disposed")
})
.disposed(by: disposeBag)


print("---------- Create 2 ----------")
enum error: Error {
    case anError
}

Observable<Any>.create { observer -> Disposable in
    observer.onNext(1)
    observer.onError(error.anError)
    observer.onCompleted()
    observer.onNext(2)
    
    return Disposables.create()
}
.subscribe(
    onNext: {
        print($0)
    },
    onError: {
        print($0.localizedDescription)
    },
    onCompleted: {
        print("completed")
    },
    onDisposed: {
        print("disposed")
    }
)
.disposed(by: disposeBag)


print("---------- Deferred 1 ----------")
Observable.deferred {
    Observable.of(1, 2, 3, 4, 5)
}
.subscribe {
    print($0)
}


print("---------- Deferred 2 ----------")
var flip = false

let factory: Observable<String> = Observable.deferred {
    flip = !flip
    
    if flip {
        return Observable.just("👍")
    } else {
        return Observable.just("👎")
    }
}

for _ in 0..<3 {
    factory.subscribe {
        print($0)
    }
    .disposed(by: disposeBag)
}
