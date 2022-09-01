import Foundation
import RxSwift


let disposeBag = DisposeBag()


print("---------- StartWith ----------")
let yellow = Observable.of("a", "b", "c")

yellow
    .enumerated()
    .map { index, element in
        element + " 어린이" + " \(index)"
    }
    .startWith("teacher")
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("---------- Concat 1 ----------")

let yellowChildren = Observable.of("a", "b", "c")
let teacher = Observable.of("teacher")

let walk = Observable
    .concat([teacher, yellowChildren])

walk
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("---------- Concat 2 ----------")
teacher
    .concat(yellowChildren)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("---------- ConcatMap 1 ----------")
let childHouse: [String: Observable<String>] = [
    "yellow": Observable.of("a", "b", "c"),
    "blue": Observable.of("1", "2", "3")
]

Observable.of("yellow", "blue")
    .concatMap {
        childHouse[$0] ?? Observable.empty()
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("---------- ConcatMap 2 ----------")

Observable.of(teacher, yellow)
    .concatMap {
        $0.map {
            $0 + " ~~!"
        }
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("---------- Merge 1 ----------")
let north = Observable.from(["강북구", "성북구", "동대문구", "종로구"])
let south = Observable.from(["강남구", "강동구", "영등포구", "양천구"])

Observable.of(north, south)
    .merge()
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("---------- Merge 2 ----------")
Observable.of(north, south)
    .merge(maxConcurrent: 1)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("---------- CombineLatest 1 ----------")
let lastName = PublishSubject<String>()
let firstName = PublishSubject<String>()

let name = Observable
    .combineLatest(firstName, lastName) { firstName, lastName in
        firstName + lastName
    }

name
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

firstName.onNext("kim")
lastName.onNext(" jeonun")
lastName.onNext(" ilsung")
lastName.onNext(" taejun")
firstName.onNext("kang")
firstName.onNext("lee")
firstName.onNext("park")

print("---------- CombineLatest 2 ----------")
let dateFormat = Observable<DateFormatter.Style>.of(.short, .long, .full, .medium)
let currentDate = Observable.of(Date())

let date = Observable
    .combineLatest(dateFormat, currentDate) { format, date -> String in
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = format
        return dateFormatter.string(from: date)
    }

date
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("---------- CombineLatest 3 ----------")
let last = PublishSubject<String>()
let first = PublishSubject<String>()

let fullName = Observable
    .combineLatest([first, last]) { name -> String in
        print(name)
        return name.joined(separator: " ")
    }

fullName
    .subscribe(onNext: {
    print($0)
    })
    .disposed(by: disposeBag)


first.onNext("kim")
last.onNext("taejun")
last.onNext("inseong")
last.onNext("taetaee")

print("---------- Zip ----------")
enum Game {
    case win
    case lose
}

let shobu = Observable<Game>.of(.lose, .win, .lose, .win, .win, .win, .lose)
let player = Observable<String>.of("korea", "japan", "usa", "swiss", "china", "germany")

let result = Observable
    .zip(shobu, player) { result, player in
        return player + " 선수" + " \(result)"
    }

result
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("---------- WithLatestFrom ----------")
let gun = PublishSubject<Void>()
let runner = PublishSubject<String>()

gun
    .withLatestFrom(runner)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

runner.onNext("1")
runner.onNext("a")
runner.onNext("asdf")

gun.onNext(())
gun.onNext(())

print("---------- Sample ----------")
let flag = PublishSubject<Void>()
let f1 = PublishSubject<String>()

f1
    .sample(flag)
    .subscribe(onNext: {
        print($0)
    })

f1.onNext("adsf")
f1.onNext("22")
f1.onNext("dd")

flag.onNext(())
flag.onNext(())

print("---------- AMB ----------")
let bus1 = PublishSubject<String>()
let bus2 = PublishSubject<String>()

let station = bus1.amb(bus2)

station
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

bus1.onNext("1")
bus1.onNext("2")
bus2.onNext("a")
bus1.onNext("3")
bus2.onNext("b")
bus2.onNext("c")

print("---------- SwitchLatest ----------")
let stu1 = PublishSubject<String>()
let stu2 = PublishSubject<String>()
let stu3 = PublishSubject<String>()

let raise = PublishSubject<Observable<String>>()

let classroom = raise
    .switchLatest()

classroom.subscribe(onNext: {
    print($0)
})
.disposed(by: disposeBag)

raise.onNext(stu1)
stu1.onNext("hihi im 1")
stu2.onNext("hihi im 2")
raise.onNext(stu2)
stu2.onNext("2 too")
stu1.onNext("1 too")
raise.onNext(stu3)
stu2.onNext("2 2 too")
stu1.onNext("1 2 too")
stu3.onNext("hihi im 3")
raise.onNext(stu1)
stu1.onNext("last 1")
stu2.onNext("last 2")
stu3.onNext("last 3")

print("---------- Reduce ----------")
Observable<Int>.from((1...10))
    .reduce(0, accumulator: +)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)


print("---------- Scan ----------")
Observable<Int>.from((1...10))
    .scan(0, accumulator: +)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
