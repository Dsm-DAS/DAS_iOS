import UIKit
extension UITextField {
    func addCenterPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 53, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
    func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
}
