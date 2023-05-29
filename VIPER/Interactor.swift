//
//  Interactor.swift
//  VIPER
//
//  Created by RAMESH on 14/04/23.
//

import Foundation

protocol AnyInteractor {
    var presenter: AnyPresenter? { get set }
    func getUsers()
}

class Interactor: AnyInteractor {
    var presenter: AnyPresenter?
    let urlString = "https://jsonplaceholder.typicode.com/users"
    
    func getUsers() {
        guard let url = URL(string: urlString) else { return }
        let task =  URLSession.shared.dataTask(with: url) { [weak self]
            data,response,error in
            guard let data = data , let _ = response else {
                self?.presenter?.interactorDidFetchUsers(with: .failure(FetchError.failed))
                return
            }
            do {
                let entities = try JSONDecoder().decode([User].self, from: data)
                self?.presenter?.interactorDidFetchUsers(with: .success(entities))
            }catch {
                self?.presenter?.interactorDidFetchUsers(with: .failure(error))
            }
        }
        task.resume()
    }
}
