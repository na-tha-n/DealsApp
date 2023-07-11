//
//  DealCell.swift
//  DealsApp
//
//  Created by Ngoc Nguyen on 7/11/23.
//

import SwiftUI

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

//struct DealCell_Previews: PreviewProvider {
//    static var previews: some View {
//        DealCell()
//    }
//}
