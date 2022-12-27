import UIKit
import RxSwift
import RxCocoa

class ChangePasswordViewModel: BaseVM {
    struct Input {
        let previousPasswordText: Driver<String>
        let newPasswordText: Driver<String>
        let changeButtonDidTap: Signal<Void>
    }
    
    struct Output {
        let result: PublishRelay<Bool>
    }
    private let disposeBag = DisposeBag()
    
    func transform(_ input: Input) -> Output {
        let api = Service()
        let info = Driver.combineLatest(input.previousPasswordText, input.newPasswordText)
        let result = PublishRelay<Bool>()
        input.changeButtonDidTap
            .asObservable()
            .withLatestFrom(info)
            .flatMap { previous, new in
                api.changePassword(previous, new)
            }.subscribe(onNext: { res in
                switch res {
                case .deleteOk:
                    result.accept(true)
                default:
                    result.accept(false)
                }
            }).disposed(by: disposeBag)
        return Output(result: result)
    }

}
