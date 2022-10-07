import RxSwift


let disposeBag = DisposeBag()

print("---------- replay ----------")
let hi = PublishSubject<String>()
let parrot = hi.replay(2)

parrot.connect()

hi.onNext("hi")
hi.onNext("hello")
hi.onNext("annyeong")

parrot
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

hi.onNext("gonnichiwa")
