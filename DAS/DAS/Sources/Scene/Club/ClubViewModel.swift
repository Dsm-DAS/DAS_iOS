import Foundation
import RxSwift
import RxCocoa

class ClubViewModel: BaseVM {
    
    struct Input {
        let clubId: Int
        let clubDetailList: Signal<Void>
    }
    struct Output {
        let clubDetailList: PublishRelay<ClubDetailModel>
        let userList: BehaviorRelay<[ClubUserList]>
    }
    private let disposeBag = DisposeBag()

    func transform(_ input: Input) -> Output {
        let api = Service()
        let clubDetailList = PublishRelay<ClubDetailModel>()
        let userList = BehaviorRelay<[ClubUserList]>(value: [])
        input.clubDetailList.asObservable()
            .flatMap { api.clubDetailList(input.clubId) }
            .subscribe(onNext: { data, res in
                switch res {
                case .ok:
                    clubDetailList.accept(data!)
                    userList.accept(data!.users_list)
                default:
                    return
                }
            }).disposed(by: disposeBag)
        return Output(clubDetailList: clubDetailList, userList: userList)
    }
}
