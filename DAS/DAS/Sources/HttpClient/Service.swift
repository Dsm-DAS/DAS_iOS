import Foundation
import RxSwift
import RxCocoa
import Moya
import RxMoya

final class Service {
    
    let provider = MoyaProvider<API>()
    
    func signIn(_ email: String, _ password: String) -> Single<networkingResult> {
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
    
    func setNetworkError(_ error: Error) -> networkingResult {
            print(error)
            print(error.localizedDescription)
            guard let status = (error as? MoyaError)?.response?.statusCode else { return (.fault) }
            return (networkingResult(rawValue: status) ?? .fault)
    }
}
