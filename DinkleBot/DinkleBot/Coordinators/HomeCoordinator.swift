//
//  HomeCoordinator.swift
//  DinkleBot
//
//  Created by Iain Smith on 13/06/2021.
//

import UIKit

public class HomeCoordinator: Coordinator {

  public var children: [Coordinator] = []
  public let router: Router

  public init(router: Router) {
    self.router = router
  }

  public func present(animated: Bool,
                      onDismissed: (() -> Void)?) {
    let viewController =
      HomeViewController.instantiate(delegate: self)
    router.present(viewController,
                   animated: animated,
                   onDismissed: onDismissed)
  }
}

extension HomeCoordinator: HomeViewControllerDelegate {

  public func homeViewControllerDidPressOther(
    _ viewController: HomeViewController) {
    let router =
      ModalNavigationRouter(parentViewController: viewController)
    let coordinator =
      OtherCoordinator(router: router)
    presentChild(coordinator, animated: true)
  }
}
