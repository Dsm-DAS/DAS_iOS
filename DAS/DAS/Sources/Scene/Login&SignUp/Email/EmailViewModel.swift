import Foundation
import RxSwift
import RxCocoa

class EmailViewModel: BaseVM {
    struct Input {
        let emailText: Driver<String>
        let nextButtonDidTap: Signal<Void>
    }
    struct Output {
        let result : PublishRelay<Bool>
    }
    private let disposeBag = DisposeBag()
    
    func transform(_ input: Input) -> Output {
        let api = Service()
        let result = PublishRelay<Bool>()
        input.nextButtonDidTap
            .asObservable()
            .withLatestFrom(input.emailText)
            .flatMap{ email in
                api.sendEmailCode(email)
            }.subscribe(onNext: { res in
                switch res {
                case .createOk:
                    result.accept(true)
                default:
                    result.accept(false)
                }
            }).disposed(by: disposeBag)
        return Output(result: result)
    }
}
