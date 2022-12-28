import Foundation
import RxSwift
import RxCocoa

class UserProFilViewModel: BaseVM {
    
    struct Input {
        let viewAppear: Signal<Void>
        let userId: Int
    }
    struct Output {
        let user: PublishRelay<UserDetailModel>
    }
    private let disposeBag = DisposeBag()

    func transform(_ input: Input) -> Output {
        let api = Service()
        let user = PublishRelay<UserDetailModel>()
        input.viewAppear.asObservable()
            .flatMap { api.userDetailList(input.userId) }
            .subscribe(onNext: { data, res in
                switch res {
                case .ok:
                    user.accept(data!)
                default:
                    return
                }
            }).disposed(by: disposeBag)
        return Output(user: user)
    }
}
