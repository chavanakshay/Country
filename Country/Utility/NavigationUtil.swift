//
//  NavigationUtil.swift
//  Country
//
//  Created by a.diliprao.chavan on 10/05/22.
//

import SwiftUI

struct NavigationUtil {
    
    static func pop() {
        findNavigationController(viewController: UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.rootViewController)?
            .popViewController(animated: true)
    }
    
    static func push<Content:View>(view: Content, animated:Bool = true) {
            findNavigationController(viewController: UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.rootViewController)?.pushViewController(UIHostingController(rootView: view), animated: true)
    }
        
    static func findNavigationController(viewController: UIViewController?) -> UINavigationController? {
        guard let viewController = viewController else {
            return nil
        }
        
        if let navigationController = viewController as? UINavigationController {
            return navigationController
        }
        
        for childViewController in viewController.children {
            return findNavigationController(viewController: childViewController)
        }
        
        return nil
    }
}
