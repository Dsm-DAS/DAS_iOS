import Foundation
import Moya

let MY = MoyaProvider<API>()

enum API {
    case login(email: String, password: String)
    case signUp(email: String, password: String, name: String, grade: Int, classNum: Int, number: Int, sex: String)
    case sentEmailCode(email : String)
    case codecheck(email : String, emailCode : String)
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
        case.sentEmailCode:
            return "/user/email"
        case.codecheck:
            return "/user/email"
        }
        
    }
    
    var method: Moya.Method {
        switch self {
        case .login, .signUp, .sentEmailCode :
            return .post
        case .codecheck :
            return .put
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
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .login, .signUp, .sentEmailCode, .codecheck:
            return Header.tokenIsEmpty.header()
        }
    }
}
