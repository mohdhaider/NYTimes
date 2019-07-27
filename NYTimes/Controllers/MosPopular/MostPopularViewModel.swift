//
//  MostPopularViewModel.swift
//  NYTimes
//
//  Created by Mohd Haider on 27/07/19.
//  Copyright © 2019 Mohd Haider. All rights reserved.
//

import Foundation

final class MostPopularViewModel {
    
    // MARK:- Variables -

    let interactor: NetworkInteractor<SearchRequest> = NetworkInteractor()
    
    let networkManager = NetworkManager()
    
    var searchResponse = PopularsInfo(num_results: nil)
    
    var isRequestInProgress = DataObserver<Bool>(false)
    
    var arrPopulars = DataObserver<[MostPopularCellContentProtocol]>([])
    
    // MARK:- Search Api -
    
    func fetchNewSearchResults(forDays days:Int, searchText strText:String?) {
        
        isRequestInProgress.value = true
        
        networkManager.fetchSearch(interactor, .search(days: days, searchText: strText)) {[weak self] (data, response, error) in
            
            do {
                if let dataAvail = data {
                    let json = try JSONSerialization.jsonObject(with: dataAvail, options: .allowFragments)
                    
                    if let jsonDict = json as? Parameters{
                        
                        let jsonData = try JSONSerialization.data(withJSONObject: jsonDict, options: .prettyPrinted)
                        
                        let decodedResponse = try JSONDecoder().decode(SearchResponse.self, from: jsonData)
                        
                        self?.searchResponse.num_results = decodedResponse.num_results
                        
                        self?.arrPopulars.value = decodedResponse.populars ?? []
                        
                        self?.isRequestInProgress.value = false
                    }
                }
            } catch {
                print("error = \(error)")
                self?.arrPopulars.value = []
                self?.isRequestInProgress.value = false
            }
        }
    }
}
