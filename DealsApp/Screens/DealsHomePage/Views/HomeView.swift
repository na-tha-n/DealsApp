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

    var body: some View {
//        viewModel.deals.first
        NavigationView {
            ScrollView {
//
//                if let firstDeal = viewModel.deals.first {
//                                DealDetailView(deal: firstDeal)
//                                    .navigationTitle("Today's Deals")
//                            }
//                if let firstDeal = viewModel.deals.first {
//                                CustomerReviewView(deal: firstDeal)
//                                    .navigationTitle("Customer Review")
//                            }
//
//
                LazyVGrid(columns: Array(repeating: .init(), count: 2)) {
                    ForEach(viewModel.deals) { deal in
                        NavigationLink(destination: DealDetailView(deal: deal)){
                            DealCell(deal: deal)
                        }
                        .navigationTitle("Today's Deals")

                    }
                }
                .padding(.horizontal, 8) // Add horizontal padding to the grid

            }
            .navigationTitle("Hot Deals")
        }
        .onAppear {
            viewModel.fetchDeals()
        }
    }
}

struct DealCell: View {
    let deal: Deal

    var body: some View {
        let originalRate = Double.random(in: 120...160) / 100
        let dealPrice = Double(deal.price)/100
        let originalPrice = dealPrice * originalRate
        let dealRate =  100 - 100*dealPrice/originalPrice
        let likeCount = deal.likes.count
        
        VStack {
            ZStack{
                AsyncImage(url: URL(string: deal.product.image)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 125, height: 125)
                        .cornerRadius(15)
                } placeholder: {
                    ProgressView()
                }
                .padding(.bottom, 5)
                
                Text("\(dealRate, specifier: "%.0f")%")
                                .font(.system(size: 22))
                                .cornerRadius(5)
                                .foregroundColor(.red)
                                .position(x: 25, y: 15) // Positions the view
                                .frame()
                //Like count
                HStack{
                    Spacer()
                    Image(systemName: "hand.thumbsup.fill")
                        .font(.system(size: 14))
                        .foregroundColor(.yellow)
                    Text("\(likeCount)")
                        .font(.system(size: 14))
                    Spacer()
                }
                .position(x: 140, y: 125) // Positions the view
            }
            VStack(){
                Text("\(deal.title)")
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                HStack{
                    //Original price
                    Text("  $\(originalPrice, specifier: "%.0f")  ")
                        .font(.system(size: 12))
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.leading)
                        .strikethrough(true, color: .red)
                    //Discount price
                    Text("  $\(dealPrice, specifier: "%.2f")  ")
                        .font(.system(size: 15))
                        .foregroundColor(.white)
                        .background(.red)
                        .cornerRadius(5)
                        .shadow(radius: 10)
                    Spacer()
                    
                }
                .padding(.top, 2)
            }
            
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 10)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct CustomerReviewView: View {
    let deal: Deal
    
    var body: some View {
        ScrollView {
            HStack{
                VStack{
                    AsyncImage(url: URL(string: deal.product.image)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 150, height: 150)
                    } placeholder: {
                        ProgressView()
                    }
                }
                .cornerRadius(30)
                .padding(15)
                .shadow(radius: 10)
                
                VStack{
                    Spacer()
                    HStack{
                        Image(systemName: "hand.thumbsup")
                            .font(.system(size: 30))
                        Text("\(deal.likes.count) Likes")
                            .font(.system(size: 20))
                            .underline()
                        Spacer()
                    }
                    Spacer()
                    HStack{
                        Image(systemName: "hand.thumbsdown")
                            .font(.system(size: 30))
                        Text("\(deal.dislikes.count) Dislikes")
                            .font(.system(size: 20))
                            .underline()
                        Spacer()
                    }
                    Spacer()

                    HStack{
                        Image(systemName: "message")
                            .font(.system(size: 30))
                        Text("\(deal.comments.count) Comments")
                            .font(.system(size: 20))
                            .underline()
                        Spacer()
                    }
                    Spacer()

                }
                Spacer()
            }
            
            ForEach(deal.comments){ comment in
                HStack{
                    VStack{
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 100)
                            .foregroundColor(.gray)
                        Spacer()
                    }
                    VStack(alignment: .leading){
                        HStack{
                            Text("\(comment.user.name)")
                                .font(.system(size: 20, weight: .bold))
                                .padding(.bottom, 2)
                            
                            Text("\(formatDate(timestamp: Double(comment.createdAt) ?? 0.0))")
                        }
                        Text("\(comment.text)")
                    }
                    Spacer()
                }
                .padding()
                
            }
        }
    }
}

struct DealDetailView: View {
    let deal: Deal
    
    var body: some View {
        let boughtNumber = Int.random(in: 500...2000)
        let originalRate = Double.random(in: 120...160) / 100
        let dealPrice = Double(deal.price)/100
        let originalPrice = dealPrice * originalRate
        let dealRate =  100 - 100*dealPrice/originalPrice
        
        ScrollView {
            VStack(alignment: .leading) {
                //Link
                Link(destination: URL(string: "\(deal.url)")!) {
                    Label("See the deal on Store's Website", systemImage: "arrow.up.forward.app")
                        .font(.system(size: 12))
                        .foregroundColor(.blue)
                        .underline(true, color: .blue)
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                        .padding(.bottom, 1)
                }
                Spacer()
                //Title
                Text("\(deal.title)")
                    .font(.system(size: 12))
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                
                //Image
                ZStack{
                    AsyncImage(url: URL(string: deal.product.image)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: UIScreen.main.bounds.width - 20)
                    } placeholder: {
                        ProgressView()
                    }
                    .padding(.bottom, 5)
                    
                    //Customer Review/Comments
                    NavigationLink(destination: CustomerReviewView(deal: deal)){
                        HStack  {
                            Spacer()
                            ForEach(0..<5) { index in
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                                    .frame(width: 1, height: 1)
                                    .padding(5)
                                
                            }
                            Text("\(deal.likes.count)")
                                .font(.system(size: 20))
                                .underline()
                        }
                        .position(x: 170, y: 15)
                    }

                }
                .cornerRadius(15)
                .shadow(radius: 5)
            
                //Pagination
                HStack{
                    HStack{
                        ForEach(0..<6) { index in
                            if index == 2 {
                                Image(systemName: "circle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 8, height: 8)
                                    .foregroundColor(.blue)
                            } else {
                                Image(systemName: "circle")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 8, height: 8)
                                    .foregroundColor(.gray)
                            }
                        }
                        
                    }
                    Spacer()
                    //Favorite, Save button
                    HStack{
                        Image(systemName: "heart")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                            .foregroundColor(.gray)

                        Image(systemName: "bookmark")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                            .foregroundColor(.gray)
                    }
                }
                Spacer()
                
                //Price and Stock
                VStack(alignment: .leading){
                    HStack{
                        Spacer()
                        Text("\(boughtNumber)+ in past month")
                            .font(.system(size: 15))
                        Spacer()
                    }
                    HStack{
                        Text(" DEAL ")
                            .font(.system(size: 14, weight: .bold))
                            .padding(10)
                            .foregroundColor(.white)
                            .background(.red)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                        Spacer()
                    }
                    HStack{
                        Text(" -\(dealRate, specifier: "%.0f")% ")
                            .font(.system(size: 30))
                            .cornerRadius(5)
                            .foregroundColor(.red)
                        ZStack{
                                Text("$")
                                    .font(.system(size: 15))
                                    .position(x:10, y:5)
                            }
                        .frame(width: 10)
                        Text("\(dealPrice, specifier: "%.2f")  ")
                            .font(.system(size: 30))
                        Spacer()
                    }
                    HStack{
                        Text("List price:")
                            .font(.system(size: 15))
                            .foregroundColor(.secondary)
                        Text("$\(originalPrice, specifier: "%.2f")  ")
                            .font(.system(size: 15))
                            .foregroundColor(.secondary)
                            .strikethrough(true, color: .red)
                    }
                    
                    Text("In Stock")
                        .font(.system(size: 30))
                        .foregroundColor(.green)
                        .padding(.vertical , 20)
                    Spacer()
                    
                }
                
                //Product Detail
                VStack(alignment: .leading){
                   Text("Product Detail")
                        .font(.system(size: 25))
                        .padding(.vertical, 5)
                
                    Text("\(deal.product.description)")
                }

            }
            .padding()
//            .overlay(
//                RoundedRectangle(cornerRadius: 15)
//                    .stroke(Color.black, lineWidth: 2)
//            )
        }

    }

}

func formatDate(timestamp: Double) -> String {
    let date = Date(timeIntervalSince1970: timestamp/1000)
    let formatter = DateFormatter()
    formatter.dateFormat = "MM/dd/yyyy"
    return formatter.string(from: date)
}
