//
//  AppDelegate.swift
//  DinkleBot
//
//  Created by Iain Smith on 13/06/2021.
//

import UIKit

@UIApplicationMain
public class AppDelegate: UIResponder, UIApplicationDelegate {

  public lazy var coordinator = HomeCoordinator(router: router)
  public lazy var router = AppDelegateRouter(window: window!)
  public lazy var window: UIWindow? =
    UIWindow(frame: UIScreen.main.bounds)

  public func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions
    launchOptions: [UIApplication.LaunchOptionsKey: Any]?)
    -> Bool {
    coordinator.present(animated: true, onDismissed: nil)
    return true
  }
}
