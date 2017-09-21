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
    
    final let interator: Interactor
    
    required init(interator: Interactor) {
        self.interator = interator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func display(viewModel: ViewModel) {
        fatalError("display(viewModel:) is an abstract function")
    }
}

class Interactor: ViewToInteratorPipline {
    final let presenter: Presenter
    
    required init(presenter: Presenter) {
        self.presenter = presenter
    }
    
    func refresh(request: Request) {
        fatalError("refresh(request:) is an abstract function")
    }
}

class Presenter: InteratorToPresenterPipline {
    private final weak var _view: View? {
        didSet {
//            <#variable name#> = newValue
        }
    }
    
    final var view: View? {
        get {
            return self._view
        }
        set {
            assert(self._view == nil)
            self._view = newValue
        }
    }
    
    required init() { }
    
    func present(response: Response) {
        fatalError("response(Response:) is an abstract function")
    }
}

struct Unity {
    let viewType : View.Type
    let interatorType : Interactor.Type
    let presenterType : Presenter.Type
}

extension Unity : ExpressibleByArrayLiteral {
    typealias Element = AnyClass
    init(arrayLiteral elements: Unity.Element...) {
        assert(elements.count == 3)
        guard let viewType = elements[0] as? View.Type else {assert(false)}
        guard let interatorType = elements[1] as? Interactor.Type else {assert(false)}
        guard let presenterType = elements[2] as? Presenter.Type  else {assert(false)}
        self.viewType = viewType
        self.interatorType = interatorType
        self.presenterType = presenterType
    }
}

class Binder {
    static var unitySet: [String: Unity] = [:]
    static func addUnity(_ unity: Unity, identifier: String) {
        self.unitySet[identifier] = unity
    }
    
    static func obtainView(identifier: String) -> View? {
        guard let unity = self.unitySet[identifier] else { return nil }
        
        let presenter = unity.presenterType.init()
        let interator = unity.interatorType.init(presenter: presenter)
        let view = unity.viewType.init(interator: interator)
        presenter.view = view
        return view
        
        
    }
}


enum RouteType {
    case root(identifier: String)
    case push(identifier: String)
    case modal(identifier: String)
    case back
}

extension RouteType {
    
    var identifier: String? {
        switch self {
        case let .root(identifier):
            return identifier
        case let .push(identifier):
            return identifier
        case let .modal(identifier):
            return identifier
        default:
            return nil
        }
    }
    
    var view: View? {
        guard let identifier = self.identifier else { return nil }
        return Binder.obtainView(identifier: identifier)
        
    }
}




