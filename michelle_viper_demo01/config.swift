//
//  config.swift
//  michelle_viper_demo01
//
//  Created by Michelle on 20/09/2017.
//  Copyright © 2017 Michelle. All rights reserved.
//

import Foundation

protocol Request {}

protocol Response {}

protocol ViewModel {}

protocol ViewToInteratorPipline {
    func refresh(request: Request)
}

protocol InteratorToPresenterPipline {
    func present(response: Response)
}

protocol PresenterToViewPipline {
    func display(viewModel: ViewModel)
}

class View: ViewController, PresenterToViewPipline {
//    final let interator: In
    
    func display(viewModel: ViewModel) {
        fatalError("display(viewModel:) is an abstract function")
    }
}

class Interactor: ViewToInteratorPipline {
    func refresh(request: Request) {
        fatalError("refresh(request:) is an abstract function")
    }

    
}

class Presenter: InteratorToPresenterPipline {
    func present(response: Response) {
        fatalError("response(Response:) is an abstract function")
    }
}

