//
//  DashboardRouter.swift
//  iWrite
//
//  Created by Swetha Sreekanth on 26/4/21.
//

import Foundation
import UIKit

class DashboardRouter: DashboardPresenterToRouterProtocol {
    static func createModule() -> UIViewController {
        let view = DashboardViewController()
        let presenter: DashboardViewToPresenterProtocol & DashboardInteractorToPresenterProtocol = DashboardPresenter()
        let interactor:DashboardPresentorToInteractorProtocol = DashboardInteractor()
        let router: DashboardPresenterToRouterProtocol = DashboardRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
    
    
}
