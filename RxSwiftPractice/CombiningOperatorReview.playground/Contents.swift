import RxSwift


let disposeBag = DisposeBag()

print("---------- startWith  ----------")
let yellowClass = Observable.of("a", "b", "c") // String

yellowClass
    .enumerated()
    .map { index, element in
        element + " 어린이 " + "\(index)"
    }
    .startWith("teacher")
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("---------- concatMap ----------")
let kindergarden: [String: Observable<String>] = [
    "yellow": Observable.of("a", "b", "c"),
    "blue": Observable.of("1", "2", "3")
]

Observable.of("yellow", "blue")
    .concatMap { color in
        kindergarden[color] ?? .empty()
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("---------- merge1 ----------")
let north = Observable.from(["강북구", "성북구", "동대문구", "종로구"])
let south = Observable.from(["강남구", "강동구", "영등포구", "양천구"])

Observable.of(north, south)
    .merge()
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("---------- combineLatest ----------")
let firstname = PublishSubject<String>()
let lastname = PublishSubject<String>()

let name = Observable
    .combineLatest([lastname, firstname]) { name in
        name.joined(separator: " ")
    }

name
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

lastname.onNext("kim")
firstname.onNext("inseong")

print("---------- zip ----------")
enum winLose {
    case win
    case lose
}

let shobu = Observable<winLose>.of(.lose, .win, .win, .lose, .lose)
let player = Observable<String>.of("korea", "usa", "china", "swiss", "japan")

Observable
    .zip(shobu, player) { result, player in
        return player + " player \(result)"
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
print("---------- withLatestFrom 1 ----------")
let gun = PublishSubject<Void>()
let runner = PublishSubject<String>()

gun
    .withLatestFrom(runner)
//    .distinctUntilChanged() // sample 처럼 사용하기 위해
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

runner.onNext("kim")
runner.onNext("park")
runner.onNext("kang")

gun.onNext(Void())
gun.onNext(Void())

print("---------- sample ----------")
let f1Start = PublishSubject<Void>()
let f1Player = PublishSubject<String>()

f1Player
    .sample(f1Start)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

f1Player.onNext("car1")
f1Player.onNext("car2")
f1Player.onNext("car3")

f1Start.onNext(Void())
f1Start.onNext(Void())

print("---------- amb ----------") // ambigious
let bus1 = PublishSubject<String>()
let bus2 = PublishSubject<String>()

let busStation = bus1.amb(bus2)

busStation
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

bus1.onNext("bus1-1")
bus2.onNext("bus2-1")
bus2.onNext("bus2-2")
bus2.onNext("bus2-3")
bus1.onNext("bus1-2")
bus2.onNext("bus2-4")
bus1.onNext("bus1-3")

print("---------- switchLatest ----------")
let student1 = PublishSubject<String>()
let student2 = PublishSubject<String>()
let student3 = PublishSubject<String>()

let raiseHand = PublishSubject<Observable<String>>()

let raisedStudentTalkClass = raiseHand.switchLatest()

raisedStudentTalkClass
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

raiseHand.onNext(student1)
student1.onNext("Hi im num 1")
student2.onNext("meme i'm 2")

raiseHand.onNext(student2)
student2.onNext("wow i'm num 2")
student1.onNext("1 is not done...")

raiseHand.onNext(student3)
student2.onNext("222222")
student1.onNext("111111111")
student3.onNext("hi i'm 3")

print("---------- reduce ----------")
let num = PublishSubject<Int>()

num
    .scan(0, accumulator: +)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

num.onNext(1)
num.onNext(2)
num.onNext(4)
