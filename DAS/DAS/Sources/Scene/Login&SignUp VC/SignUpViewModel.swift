import Foundation
import RxSwift
import RxCocoa

class SignUpViewModel: ViewModel {
    
    
    struct Input {
        let emailText: Driver<String>
        let codeText: Driver<String>
//        let nameText: Driver<String>
        let passwordText: Driver<String>
        let emailCheckCodeButtonDidTap: Signal<Void>
        let emailCheckButtonDidTap: Signal<Void>
    }
    struct Output {
        let sentEmailCodeResult : PublishRelay<Bool>
        let codeCheckResult : PublishRelay<Bool>
        let signUpResult : PublishRelay<Bool>
    }
    private let disposeBag = DisposeBag()
    
    func transform(_ input: Input) -> Output {
        let api = Service()
        let sentEmailCode = input.emailText
        let checkCode = Driver.combineLatest(input.emailText, input.codeText)
        let sentEmailCodeResult = PublishRelay<Bool>()
        let codeCheckResult = PublishRelay<Bool>()
        let signUpResult = PublishRelay<Bool>()
        input.emailCheckCodeButtonDidTap
            .asObservable()
            .withLatestFrom(sentEmailCode)
            .flatMap{ email in
                api.sentEmailCode(email)
            }.subscribe(onNext: { res in
                switch res {
                case .createOk:
                    sentEmailCodeResult.accept(true)
                    
                default:
                    sentEmailCodeResult.accept(false)
                }
            }).disposed(by: disposeBag)
        input.emailCheckButtonDidTap
            .asObservable()
            .withLatestFrom(checkCode)
            .flatMap{ email, checkCode in
                api.codeCheck(email, checkCode)
            }.subscribe(onNext: { res in
                switch res {
                case .createOk:
                    codeCheckResult.accept(true)
                default:
                    codeCheckResult.accept(false)
                }
            }).disposed(by: disposeBag)
        return Output(sentEmailCodeResult: sentEmailCodeResult, codeCheckResult: codeCheckResult, signUpResult: signUpResult)
    }
}
