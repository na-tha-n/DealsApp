//
//  HomeViewModel.swift
//  DealsApp
//
//  Created by renupunjabi on 7/3/23.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    // Call the fetch call using DealsService
    @Published var deals = [Deal]()
    private var cancellables = Set<AnyCancellable>()
    
    func fetchDeals() {
        do {
            let fetchedDeals = try DealsService().fetchDeals()
            
            DispatchQueue.main.async { [weak self] in
                self?.deals = fetchedDeals
            }
        } catch {
            print("Failed to fetch deals with error: \(error)")
        }
    }
}

