import Foundation

struct MyPageModel: Codable {
    let email, name: String
    let number, grade, class_num: Int
    let introduce: String?
    let profile_image_url: String?
    let view_counts: Int?
    let major: String?
    let stack: String?
    let link_info: Link?
    let sex: String
    let region: String?
    let club: [club]?
}
struct Link: Codable {
    let github_link, facebook_link, instagram_link: String
}
struct club: Codable {
    let club_id: Int
    let club_name: String
    let club_image_url: String
}
