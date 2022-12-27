import UIKit
import RxSwift
import RxCocoa

class TabBarVC: UITabBarController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpTabBarLayout()
        setUpTabBarItem()
    }
//    override func viewDidAppear(_ animated: Bool) {
//        if Token.accessToken == nil {
//            let vc = LoginVC()
//            vc.modalPresentationStyle = .fullScreen
//            self.present(vc, animated: true)
//        }
//    }
    func setUpTabBarLayout() {
        let tabBar: UITabBar = self.tabBar
        tabBar.unselectedItemTintColor = UIColor(named: "UnSelectedItem")
        tabBar.backgroundColor = UIColor(named: "TabBarBackGround")
        tabBar.tintColor = UIColor(named: "MainColor")
        tabBar.layer.borderColor = UIColor.clear.cgColor
    }

    func setUpTabBarItem() {
        let mainVC = BaseNC(rootViewController: MainVC())
        mainVC.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(named: "Main"),
            selectedImage: UIImage(named: "Main")
        )
        let listVC = BaseNC(rootViewController: ListVC())
        listVC.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(named: "List"),
            selectedImage: UIImage(named: "List")
        )
        let searchVC = BaseNC(rootViewController: SearchVC())
        searchVC.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(named: "Search"),
            selectedImage: UIImage(named: "Search")
        )
        let noticeVC = BaseNC(rootViewController: NoticeVC())
        noticeVC.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(named: "Notice"),
            selectedImage: UIImage(named: "Notice")
        )
        let menuVC = BaseNC(rootViewController: MenuVC())
        menuVC.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(named: "Menu"),
            selectedImage: UIImage(named: "Menu")
        )
        self.setViewControllers([
            mainVC,
            listVC,
            searchVC,
            noticeVC,
            menuVC
        ], animated: true)
    }
}
