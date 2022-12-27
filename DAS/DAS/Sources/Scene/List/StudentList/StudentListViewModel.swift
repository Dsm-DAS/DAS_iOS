import Foundation
import RxSwift
import RxCocoa

class StudentListViewModel: BaseVM {
    
    struct Input {
        let userList: Signal<Void>
    }
    struct Output {
        let userList: BehaviorRelay<[UserList]>
    }
    private let disposeBag = DisposeBag()

    func transform(_ input: Input) -> Output {
        let api = Service()
        let userList = BehaviorRelay<[UserList]>(value: [])
        input.userList.asObservable()
            .flatMap { api.userListLookUp() }
            .subscribe(onNext: { data, res in
                switch res {
                case .ok:
                    userList.accept(data!.user_list)
                default:
                    return
                }
            }).disposed(by: disposeBag)
        return Output(userList: userList)
    }
}
