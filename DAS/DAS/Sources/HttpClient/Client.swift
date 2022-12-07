import Foundation
import Moya

let MY = MoyaProvider<API>()

enum API {
    case login(email: String, password: String)
    case signUp(email: String, password: String, name: String, grade: Int, classNum: Int, number: Int, sex: String)
    case sentEmailCode(email : String)
    case codecheck(email : String, emailCode : String)
    case loadMyPage
    case refreshToken
}

extension API: TargetType {
    var baseURL: URL {
        return URL(string: "http://52.79.150.23:8080")!
    }
    
    var path: String {
        switch self {
        case .login:
            return "/user/token"
        case .signUp:
            return "/user/signup"
        case .sentEmailCode:
            return "/user/email"
        case .codecheck:
            return "/user/email"
        case .loadMyPage:
            return "/user/my-page"
        case .refreshToken:
            return "/user/token"
        }
        
    }
    
    var method: Moya.Method {
        switch self {
        case .login, .signUp, .sentEmailCode :
            return .post
        case .codecheck :
            return .put
        case .loadMyPage:
            return .get
        case .refreshToken:
            return .patch
        }
    }
    
    var task: Task {
        switch self {
        case .login(let email, let password):
            return .requestParameters(parameters:
                                        [
                                            "email": email,
                                            "password": password
                                        ],
                                      encoding: JSONEncoding.default)
            
        case .signUp(let email, let password, let name, let grade, let classNum, let number, let sex):
            return .requestParameters(parameters:
                                        [
                                            "email": email,
                                            "password": password,
                                            "name": name,
                                            "grade": grade,
                                            "class_num": classNum,
                                            "number": number,
                                            "sex": sex
                                        ],
                                      encoding: JSONEncoding.prettyPrinted)
        case .sentEmailCode(let email):
            return .requestParameters(parameters:
                                        [
                                            "email": email
                                        ],
                                      encoding: JSONEncoding.prettyPrinted)
        case .codecheck(let email, let emailCode):
            return .requestParameters(parameters:
                                        [
                                            "email": email,
                                            "code": emailCode
                                        ],
                                      encoding: JSONEncoding.prettyPrinted)
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .login, .signUp, .sentEmailCode, .codecheck:
            return Header.tokenIsEmpty.header()
        case .refreshToken:
            return Header.refreshToken.header()
        case .loadMyPage:
            return Header.accessToken.header()
        }
    }
}
