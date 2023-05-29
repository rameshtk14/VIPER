//
//  Router.swift
//  VIPER
//
//  Created by RAMESH on 14/04/23.
//

import UIKit

typealias EntryPoint = AnyView & UserViewController

protocol AnyRouter {
    var entry:EntryPoint? { get }
    static func start() -> AnyRouter
}

class UserRouter : AnyRouter {
    var entry:EntryPoint?
    
    static func start() -> AnyRouter {
        let router = UserRouter()
        // Assign VIP
        
        var interactor: AnyInteractor = Interactor()
        var presenter: AnyPresenter = UserPresenter()
        var view: AnyView = UserViewController()
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = view
        
        router.entry = view as? EntryPoint
        return router
    }
}
