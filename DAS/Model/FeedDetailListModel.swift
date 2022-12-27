
import Foundation

// MARK: - FeedDetailListModel
struct FeedDetailListModel: Codable {
    let feed_id: Int
    let title: String
    let content: String
    let das_url: String
    let major: String
    let end_at: String
    let views: Int
    let writer: Writer
    let comment_list: [CommentList]
    let mine: Bool
}

// MARK: - CommentList
struct CommentList: Codable {
    let comment_id: Int
    let content: String
    let created_at: String
    let updated_at: String
    let writer: Writer
}
