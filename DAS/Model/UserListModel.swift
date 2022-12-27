import Foundation

// MARK: - UserListModel
struct UserListModel: Codable {
    let user_list: [UserList]
}

// MARK: - UserList
struct UserList: Codable {
    let user_id: Int
    let name: String
    let profile_image_url: String
    let view_counts: Int
    let grade: Int
    let class_num: Int
    let introduce: String?
}
