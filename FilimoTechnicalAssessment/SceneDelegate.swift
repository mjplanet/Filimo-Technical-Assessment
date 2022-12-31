//
//  SceneDelegate.swift
//  FilimoTechnicalAssessment
//
//  Created by Mobin Jahantark on 12/28/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let networking = Networking()
        let apiClient = DefaultAPIClient(networking: networking)
        let viewController = SearchMoviesModule().build(apiClient: apiClient)
        let navigation = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigation
        self.window = window
        window.makeKeyAndVisible()
    }

}
