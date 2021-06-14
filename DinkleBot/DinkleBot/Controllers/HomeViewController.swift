//
//  HomeViewController.swift
//  DinkleBot
//
//  Created by Iain Smith on 13/06/2021.
//

import UIKit
import Alamofire

public protocol HomeViewControllerDelegate: class {
  func homeViewControllerDidPressOther(_ viewController: HomeViewController)
}

public class HomeViewController: UIViewController {

  public weak var delegate: HomeViewControllerDelegate?

    @IBAction func didPressLogin(_ sender: Any) {
        
        let headers: HTTPHeaders = [
            "X-API-Key": "a43329f8ff0e4a848d00dc7ef80707fc",
            "Accept": "application/json"
        ]
        
        let parameters: Parameters = [
            "components": "400,401,402"
            ]
        
        AF.request("https://www.bungie.net/Platform/Destiny2/Vendors/",
                   parameters: parameters,
                   encoding: URLEncoding(destination: .queryString),
                   headers: headers)
            .responseJSON { response in
            debugPrint(response)
        }
    }
    
    @IBAction internal func didPressOther(_ sender: AnyObject) {
    delegate?.homeViewControllerDidPressOther(self)
  }
}

extension HomeViewController: StoryboardInstantiable {
  public class func instantiate(delegate: HomeViewControllerDelegate) -> HomeViewController {
    let viewController = instanceFromStoryboard()
    viewController.delegate = delegate
    return viewController
  }
}
