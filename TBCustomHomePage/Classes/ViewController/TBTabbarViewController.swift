import UIKit
import MyCameraModule
import MyOpenWeatherPlus

public final class TBTabbarViewController: UITabBarController {

    // MARK: - Life Cycle

    /// 让状态栏样式跟随当前选中的页面
    public override var childForStatusBarStyle: UIViewController? {
        selectedViewController
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupChildControllers()
        setupTabBarAppearance()
    }

    // MARK: - Setup

    /// 组装各个业务模块的 ViewController
    private func setupChildControllers() {
        // 相机模块
        let cameraVC = CameraViewController()
        cameraVC.tabBarItem = UITabBarItem(title: "相机",
                                           image: UIImage(systemName: "camera"),
                                           selectedImage: UIImage(systemName: "camera.fill"))
        let cameraNav = TBNavigationController(rootViewController: cameraVC)

        // 天气模块（OpenWeatherPlus）
        // 注意：QWeatherHomeViewController 内部通过 self.navigationController 做 push，
        // 且自身隐藏系统导航栏（fd_prefersNavigationBarHidden），因此需要包一层导航控制器
        let weatherVC = QWeatherHomeViewController()
        weatherVC.tabBarItem = UITabBarItem(title: "天气",
                                            image: UIImage(systemName: "cloud.sun"),
                                            selectedImage: UIImage(systemName: "cloud.sun.fill"))
        let weatherNav = TBNavigationController(rootViewController: weatherVC)

        viewControllers = [cameraNav, weatherNav]
    }

    /// 配置 TabBar 外观
    private func setupTabBarAppearance() {
        tabBar.tintColor = .systemBlue
        tabBar.unselectedItemTintColor = .gray

        let appearance = UITabBarAppearance()
        appearance.configureWithDefaultBackground()
        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }
    }
}

/// 让导航控制器把状态栏样式交给当前顶层页面决定
final class TBNavigationController: UINavigationController {

    override var childForStatusBarStyle: UIViewController? {
        topViewController
    }
}
