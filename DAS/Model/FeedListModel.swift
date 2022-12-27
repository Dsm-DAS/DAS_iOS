import Foundation

// MARK: - FeedListModel
struct FeedListModel: Codable {
    let feed_list: [FeedList]
}

// MARK: - FeedList
struct FeedList: Codable {
    let writer: Writer
    let feed_id: Int
    let title: String
    let created_at: Int?
    let views: Int
    let major: String
    let end_at: String
}

// MARK: - Writer
struct Writer: Codable {
    let user_id: Int
    let name, profile_image_url: String
}
