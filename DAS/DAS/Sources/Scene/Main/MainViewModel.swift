import Foundation
import RxSwift
import RxCocoa

class MainViewModel: BaseVM {
    
    struct Input {
        let refreshToken: Signal<Void>
        let userList: Signal<Void>
        let clubList: Signal<Void>
    }
    struct Output {
        let result: PublishRelay<Bool>
        let userList: BehaviorRelay<[UserList]>
        let clubList: BehaviorRelay<[ClubList]>
    }
    private let disposeBag = DisposeBag()

    func transform(_ input: Input) -> Output {
        let api = Service()
        let result = PublishRelay<Bool>()
        let userList = BehaviorRelay<[UserList]>(value: [])
        let clubList = BehaviorRelay<[ClubList]>(value: [])
        input.refreshToken.asObservable()
            .flatMap { api.refreshToken() }
            .subscribe(onNext: { res in
                switch res {
                case .ok:
                    result.accept(true)
                default:
                    result.accept(false)
                }
            }).disposed(by: disposeBag)
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
        input.clubList.asObservable()
            .flatMap { api.clubListLookUp() }
            .subscribe(onNext: { data, res in
                switch res {
                case .ok:
                    clubList.accept(data!.club_list)
                default:
                    return
                }
            }).disposed(by: disposeBag)
        return Output(result: result, userList: userList, clubList: clubList)
    }
}
