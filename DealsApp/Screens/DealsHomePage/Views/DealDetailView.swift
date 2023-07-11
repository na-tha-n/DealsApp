//
//  DealDetailView.swift
//  DealsApp
//
//  Created by Ngoc Nguyen on 7/6/23.
//

import SwiftUI

struct DealDetailView: View {
    let deal: Deal
    @Binding var path: NavigationPath

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
                    NavigationLink(destination: CustomerReviewView(deal: deal, path: $path)){
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
