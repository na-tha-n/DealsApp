//
//  ContentView.swift
//  DealsApp
//
//  Created by renupunjabi on 7/3/23.
//

import SwiftUI
import UIKit
struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
                LazyVGrid(columns: Array(repeating: .init(), count: 2)) {
                    ForEach(viewModel.deals) { deal in
                        NavigationLink(value: deal){
                            DealCell(deal: deal)
                        }
                    }
                    .padding(.horizontal, 8) // Add horizontal padding to the grid
                }
                .navigationTitle("Hot Deals")
                .navigationDestination(for: Deal.self) { deal in
                    DealDetailView(deal: deal, path: $path)
                        .navigationTitle("Today's Deals")
                }
            }
            .onAppear {
                viewModel.fetchDeals()
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}



func formatDate(timestamp: Double) -> String {
    let date = Date(timeIntervalSince1970: timestamp/1000)
    let formatter = DateFormatter()
    formatter.dateFormat = "MM/dd/yyyy"
    return formatter.string(from: date)
}


//                if let firstDeal = viewModel.deals.first {
//                                DealDetailView(deal: firstDeal)
//                                    .navigationTitle("Today's Deals")
//                            }
//                if let firstDeal = viewModel.deals.first {
//                                CustomerReviewView(deal: firstDeal)
//                                    .navigationTitle("Customer Review")
//                            }
