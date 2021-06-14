//
//  OtherBuilderCoordinator.swift
//  DinkleBot
//
//  Created by Iain Smith on 13/06/2021.
//

import UIKit

public class OtherCoordinator: Coordinator {

  public var children: [Coordinator] = []
  public let router: Router

  public init(router: Router) {
    self.router = router
  }

  public func present(animated: Bool,
                      onDismissed: (() -> Void)?) {
    let viewController =
      OtherViewController.instantiate(delegate: self)
    router.present(viewController,
                   animated: animated,
                   onDismissed: onDismissed)
  }
}

extension OtherCoordinator:
  OtherViewControllerDelegate {
    
  public func otherViewControllerDidPressDismiss(
    _ controller: OtherViewController) {
    router.dismiss(animated: true)
  }
}
