import Foundation
import RxSwift
import RxCocoa

class SignUpViewModel: ViewModel {
    var emailText: String = ""
    
    struct Input {
        let emailCheckCodeButtonDidTap: Signal<Void>
        let emailCheckButtonDidTap: Signal<Void>
        let signupBttonDidTap: Signal<Void>
    }
    struct Output {
        let sentEmailCodeResult : PublishRelay<Bool>
        let codeCheckResult : PublishRelay<Bool>
        let signUpResult : PublishRelay<Bool>
    }
    private let disposeBag = DisposeBag()
    
    func transform(_ input: Input) -> Output {
        let api = Service()

        let sentEmailCodeResult = PublishRelay<Bool>()
        let codeCheckResult = PublishRelay<Bool>()
        let signUpResult = PublishRelay<Bool>()
//        input.emailCheckCodeButtonDidTap
//            .asObservable()
//            .withLatestFrom(sentEmailCode)
//            .flatMap{ email in
//                api.sentEmailCode(email)
//            }.subscribe(onNext: { res in
//                switch res {
//                case .createOk:
//                    sentEmailCodeResult.accept(true)
//                    
//                default:
//                    sentEmailCodeResult.accept(false)
//                }
//            }).disposed(by: disposeBag)
//        input.emailCheckButtonDidTap
//            .asObservable()
//            .withLatestFrom(checkCode)
//            .flatMap{ email, checkCode in
//                api.codeCheck(email, checkCode)
//            }.subscribe(onNext: { res in
//                switch res {
//                case .createOk:
//                    codeCheckResult.accept(true)
//                default:
//                    codeCheckResult.accept(false)
//                }
//            }).disposed(by: disposeBag)
//        input.signupBttonDidTap
//            .asObservable()
//            .withLatestFrom(signup)
//            .flatMap{ email, name, password, grade, classNum, number in
//                api.signup(email, name, password, Int(grade)!, Int(classNum)!, Int(number)!)
//            }.subscribe(onNext: { res in
//                switch res {
//                case .createOk:
//                    signUpResult.accept(true)
//                default:
//                    signUpResult.accept(false)
//                }
//            }).disposed(by: disposeBag)
        return Output(sentEmailCodeResult: sentEmailCodeResult, codeCheckResult: codeCheckResult, signUpResult: signUpResult)
    }
}
