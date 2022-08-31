import Foundation
import RxSwift


let disposeBag = DisposeBag()

print("---------- ToArray ----------")
Observable<Int>.of(1, 2, 3, 4, 5, 6, 7)
    .toArray()
    .subscribe(
        onSuccess: {
            print($0)
        },
        onFailure: {
            print($0)
        },
        onDisposed: {
            print("disposed")
        }
    )
    .disposed(by: disposeBag)

print("---------- Map ----------")
Observable.of(Date(), Date())
    .map { date -> String in
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("---------- FlatMap ----------")
protocol player {
    var score: BehaviorSubject<Int> { get }
}

struct bowPlayer: player {
    var score: BehaviorSubject<Int>
}

let koreaPlayer = bowPlayer(score: BehaviorSubject<Int>(value: 10))
let usaPlayer = bowPlayer(score: BehaviorSubject<Int>(value: 8))


let olymic = PublishSubject<player>()

olymic
    .flatMap {
        $0.score
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

olymic.onNext(koreaPlayer)
koreaPlayer.score.onNext(10)
olymic.onNext(usaPlayer)
koreaPlayer.score.onNext(10)
usaPlayer.score.onNext(9)

print("---------- FlatMapLatest ----------")
struct jumpPlayer: player {
    var score: BehaviorSubject<Int>
}

let seoulPlayer = jumpPlayer(score: BehaviorSubject(value: 7))
let jejuPlayer = jumpPlayer(score: BehaviorSubject(value: 6))

let match = PublishSubject<player>()

match
    .flatMapLatest {
        $0.score
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

match.onNext(seoulPlayer)
match.onNext(jejuPlayer)

seoulPlayer.score.onNext(10)
seoulPlayer.score.onNext(10)
jejuPlayer.score.onNext(8)

print("---------- Materialize and Dematerialize ----------")
enum Wrong: Error {
    case beep
}

struct runner: player {
    var score: BehaviorSubject<Int>
}

let rabbit = runner(score: BehaviorSubject(value: 0))
let turtle = runner(score: BehaviorSubject(value: 1))

let running = BehaviorSubject<player>(value: rabbit)

running
    .flatMapLatest {
        $0.score
            .materialize()
    }
    .filter {
        guard let error = $0.error else {
            return true
        }
        print(error)
        return false
    }
    .dematerialize()
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

rabbit.score.onNext(1)
rabbit.score.onError(Wrong.beep)
rabbit.score.onNext(2)

running.onNext(turtle)

rabbit.score.onNext(5)

turtle.score.onNext(3)

print("---------- Tel 11 num ----------")

let input = PublishSubject<Int?>()

//let list: [Int] = [1]

input
    .flatMap {
        $0 == nil
        ? Observable.empty()
        : Observable.of($0)
    }
    .map {
        $0!
    }
    .skip(while: {
        $0 != 0
    })
    .take(11)
    .toArray()
    .asObservable()
    .map {
        $0.map {
            "\($0)"
        }
    }
    .map {
        var numberList = $0
        numberList.insert("-", at: 3)
        numberList.insert("-", at: 8)
        let number = numberList.reduce("", +)
        return number
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

input.onNext(10)
input.onNext(0)
input.onNext(1)
input.onNext(0)
input.onNext(3)
input.onNext(7)
input.onNext(nil)
input.onNext(1)
input.onNext(5)
input.onNext(7)
input.onNext(nil)
input.onNext(6)
input.onNext(3)
input.onNext(1)

