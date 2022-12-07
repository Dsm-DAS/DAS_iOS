import Foundation
import RxSwift
import RxCocoa
import Moya
import RxMoya

final class Service {
    
    let provider = MoyaProvider<API>(plugins: [MoyaLoggingPlugin()])
    
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
    func refreshToken() -> Single<networkingResult> {
        return provider.rx.request(.refreshToken)
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
                return .ok
            }
            .catch {[unowned self] in return .just(setNetworkError($0))}
    }
    func signup(_ email: String, _ name: String, _ password: String, _ grade: Int, _ classNum: Int, _ number: Int, _ sex: String) -> Single<networkingResult> {
        return provider.rx.request(.signUp(email: email, password: password, name: name, grade: grade, classNum: classNum, number: number, sex:  sex))
            .filterSuccessfulStatusCodes()
            .map{ response -> networkingResult in
                return .createOk
            }
            .catch {[unowned self] in return .just(setNetworkError($0))}
    }
    func loadMyPage() -> Single<(MyPageModel?, networkingResult)> {
        return provider.rx.request(.loadMyPage)
            .filterSuccessfulStatusCodes()
            .map(MyPageModel.self)
            .map{return ($0, .ok)}
            .catch { error in
                print(error)
                return .just((nil, .fault))
            }
    }
    
    func setNetworkError(_ error: Error) -> networkingResult {
            print(error)
            print(error.localizedDescription)
            guard let status = (error as? MoyaError)?.response?.statusCode else { return (.fault) }
            return (networkingResult(rawValue: status) ?? .fault)
    }
}
