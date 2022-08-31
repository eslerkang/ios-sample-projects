import Foundation
import RxSwift


let disposeBag = DisposeBag()

enum TraitsError: Error {
    case single
    case maybe
    case completable
}


print("---------- Single 1 ----------")
Single.just("✅")
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


print("---------- Single 2 ----------")
Observable.create { observer -> Disposable in
    observer.onError(TraitsError.single)
    
    return Disposables.create()
}
    .asSingle()
    .subscribe(
        onSuccess: {
            print($0)
        },
        onFailure: {
            print($0.localizedDescription)
        },
        onDisposed: {
            print("disposed")
        }
    )
    .disposed(by: disposeBag)


print("---------- Single 3 ----------")
struct SomeJson: Decodable {
    let name: String
}

enum JSONError: Error {
    case decodingError
}

let json1 = """
{"name": "park"}
"""
let json2 = """
{"nickname": "book"}
"""

func decode(json: String) -> Single<SomeJson> {
    Single<SomeJson>.create { observer -> Disposable in
        guard let data = json.data(using: .utf8),
              let json = try? JSONDecoder().decode(SomeJson.self, from: data)
        else {
            observer(.failure(JSONError.decodingError))
            return Disposables.create()
        }
        
        observer(.success(json))
        return Disposables.create()
    }
}

decode(json: json1)
    .subscribe {
        switch $0 {
        case .success(let json):
            print(json.name)
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    .disposed(by: disposeBag)

decode(json: json2)
    .subscribe {
        switch $0 {
        case .success(let json):
            print(json.name)
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    .disposed(by: disposeBag)


print("---------- Maybe 1 ----------")
Maybe<String>.just("✅")
    .subscribe(
        onSuccess: {
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


print("---------- Maybe 2 ----------")
Observable<String>.create { observer -> Disposable in
    observer.onError(TraitsError.maybe)
    
    return Disposables.create()
}
.asMaybe()
.subscribe(
    onSuccess: {
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


print("---------- Completable 1 ----------")
Completable.create { observer -> Disposable in
    observer(.error(TraitsError.completable))
    
    return Disposables.create()
}
.subscribe(
    onCompleted: {
        print("completed")
    },
    onError: {
        print($0.localizedDescription)
    },
    onDisposed: {
        print("disposed")
    }
)
.disposed(by: disposeBag)


print("---------- Completable 2 ----------")
Completable.create { observer -> Disposable in
    observer(.completed)
    
    return Disposables.create()
}
.subscribe(
    onCompleted: {
        print("completed")
    },
    onError: {
        print($0.localizedDescription)
    },
    onDisposed: {
        print("disposed")
    }
)
.disposed(by: disposeBag)
