import Foundation
import RxSwift
import RxCocoa

class SignUpViewModel: ViewModel {
    
    
    struct Input {
        let emailText: Driver<String>
        let codeText: Driver<String>
        let nameText: Driver<String>
        let passwordText: Driver<String>
        let gradeText: Driver<String>
        let classText: Driver<String>
        let numberText: Driver<String>
        let emailCheckCodeButtonDidTap: Signal<Void>
        let emailCheckButtonDidTap: Signal<Void>
        let signupBttonDidTap: Signal<Void>
    }
    struct Output {
        let sentEmailCodeResult : PublishRelay<Bool>
        let codeCheckResult : PublishRelay<Bool>
        let signUpResult : PublishRelay<Bool>
        let isEnable : Driver<Bool>
    }
    private let disposeBag = DisposeBag()
    
    func transform(_ input: Input) -> Output {
        let api = Service()
        let sentEmailCode = input.emailText
        let checkCode = Driver.combineLatest(input.emailText, input.codeText)
        let signup = Driver.combineLatest(input.emailText, input.nameText, input.passwordText, input.gradeText, input.classText, input.numberText)
        let sentEmailCodeResult = PublishRelay<Bool>()
        let codeCheckResult = PublishRelay<Bool>()
        let signUpResult = PublishRelay<Bool>()
        let isEnable = signup.map { !$0.0.isEmpty && !$0.1.isEmpty && !$0.2.isEmpty && !$0.3.isEmpty && !$0.4.isEmpty && !$0.5.isEmpty}
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
        input.signupBttonDidTap
            .asObservable()
            .withLatestFrom(signup)
            .flatMap{ email, name, password, grade, classNum, number in
                api.signup(email, name, password, Int(grade)!, Int(classNum)!, Int(number)!)
            }.subscribe(onNext: { res in
                switch res {
                case .createOk:
                    signUpResult.accept(true)
                default:
                    signUpResult.accept(false)
                }
            }).disposed(by: disposeBag)
        return Output(sentEmailCodeResult: sentEmailCodeResult, codeCheckResult: codeCheckResult, signUpResult: signUpResult, isEnable: isEnable.asDriver())
    }
}
