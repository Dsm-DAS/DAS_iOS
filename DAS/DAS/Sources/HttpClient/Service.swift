import Foundation
import RxSwift
import RxCocoa
import Moya
import RxMoya

final class Service {
    
    let provider = MoyaProvider<API>()
    
    func login(_ email: String, _ password: String) -> Single<networkingResult> {
        return provider.rx.request(.login(email: email, password: password))
            .filterSuccessfulStatusCodes()
            .map(TokenModel.self)
            .map{ response -> networkingResult in
                Token.accessToken = response.access_token
                Token.refreshToken = response.refresh_token
                return .ok
            }
            .catch {[unowned self] in return .just(setNetworkError($0))}
    }
    func sendEmailCode(_ email: String) -> Single<networkingResult> {
        return provider.rx.request(.sentEmailCode(email: email))
            .filterSuccessfulStatusCodes()
            .map{ response -> networkingResult in
                return .createOk
            }
            .catch {[unowned self] in return .just(setNetworkError($0))}
    }
    
    func codeCheck(_ email: String, _ checkCode: String) -> Single<networkingResult> {
        return provider.rx.request(.codecheck(email: email, emailCode: checkCode))
            .filterSuccessfulStatusCodes()
            .map{ response -> networkingResult in
                return .createOk
            }
            .catch {[unowned self] in return .just(setNetworkError($0))}
    }
    func signup(_ email: String, _ name: String, _ password: String, _ grade: Int, _ classNum: Int, _ number: Int) -> Single<networkingResult> {
        return provider.rx.request(.signUp(email: email, password: password, name: name, grade: grade, classNum: classNum, number: number))
            .filterSuccessfulStatusCodes()
            .map{ response -> networkingResult in
                return .createOk
            }
            .catch {[unowned self] in return .just(setNetworkError($0))}
    }
    

    
    func setNetworkError(_ error: Error) -> networkingResult {
            print(error)
            print(error.localizedDescription)
            guard let status = (error as? MoyaError)?.response?.statusCode else { return (.fault) }
            return (networkingResult(rawValue: status) ?? .fault)
    }
}
