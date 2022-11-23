import Foundation
import RxSwift
import RxCocoa

class EmailCodeViewModel: ViewModel {
    var email: String = "sdfa"
    struct Input {
        let codeText: Driver<String>
        let emailText: String
        let checkButtonDidTap: Signal<Void>
    }
    struct Output {
        let result : PublishRelay<Bool>
    }
    private let disposeBag = DisposeBag()
    
    func transform(_ input: Input) -> Output {
        let api = Service()
        let result = PublishRelay<Bool>()
        input.checkButtonDidTap
            .asObservable()
            .withLatestFrom(input.codeText)
            .flatMap{ code in
                api.codeCheck(input.emailText, code)
            }.subscribe(onNext: { res in
                switch res {
                case .ok:
                    result.accept(true)
                default:
                    result.accept(false)
                }
            }).disposed(by: disposeBag)
        return Output(result: result)
    }
}
