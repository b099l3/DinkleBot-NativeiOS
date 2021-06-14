//
//  OtherViewController.swift
//  DinkleBot
//
//  Created by Iain Smith on 14/06/2021.
//

import UIKit

public protocol OtherViewControllerDelegate: class {
  func otherViewControllerDidPressDismiss(_ viewController: OtherViewController)
}

public class OtherViewController: UIViewController {

  public weak var delegate: OtherViewControllerDelegate?

  @IBAction internal func didPressDismiss(_ sender: AnyObject) {
    delegate?.otherViewControllerDidPressDismiss(self)
  }
}

extension OtherViewController: StoryboardInstantiable {
    public class func instantiate(delegate: OtherViewControllerDelegate) -> OtherViewController { let viewController = instanceFromStoryboard()
    viewController.delegate = delegate
    return viewController
  }
}
