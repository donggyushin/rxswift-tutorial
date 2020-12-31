//
//  NewsApiService.swift
//  RxSwiftTutorial
//
//  Created by 신동규 on 2020/12/31.
//

import Foundation
import Alamofire
import RxSwift

class NewsApiService {
    static let shared = NewsApiService()
    
    
    func fetchNewsRx() -> Observable<String> {
        
        return Observable.create { (observer) -> Disposable in
            guard let url = URL(string: "https://newsapi.org/v2/everything?q=bitcoin&from=2020-11-30&sortBy=publishedAt&apiKey=bb8e4fcfd4bc4ea4a1ba2b1b105a592f") else { return Disposables.create() }
            AF.request(url, method: HTTPMethod.get, parameters: nil, encoding: JSONEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).responseJSON { (response) in
                
                switch response.result {
                case .failure(let error):
                    observer.onError(error)
                    break
                case .success(let value):
                    guard let value = value as? [String:Any] else { return }
                    let valueString = value.description
                    observer.onNext(valueString)
                }
                
                observer.onCompleted()
                
            }
            return Disposables.create()
        }
    }
    
    func fetchNews(completion:@escaping (String?, Error?) -> Void) {
        guard let url = URL(string: "https://newsapi.org/v2/everything?q=bitcoin&from=2020-11-30&sortBy=publishedAt&apiKey=bb8e4fcfd4bc4ea4a1ba2b1b105a592f") else { return }
        AF.request(url, method: HTTPMethod.get, parameters: nil, encoding: JSONEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).responseJSON { (response) in
            
            switch response.result {
            case .failure(let error):
                return completion(nil, error)
                break
            case .success(let value):
                guard let value = value as? [String:Any] else { return }
                let valueString = value.description
                return completion(valueString, nil)
            }
        }
        
    }
}
