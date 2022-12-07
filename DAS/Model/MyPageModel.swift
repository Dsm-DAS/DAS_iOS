import Foundation

struct MyPageModel: Codable {
    let email, name: String
    let number, grade, class_num: Int
    let introduce: String?
    let profile_image_url: String?
    let view_counts: Int
//    let major: String
//    let link: Link
//    let sex, region: String
}

struct Link: Codable {
    let github, facebook, instagram: String
}
