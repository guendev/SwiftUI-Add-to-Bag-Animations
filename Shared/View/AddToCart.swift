//
//  AddToCart.swift
//  Add to Bag Animations
//
//  Created by Yuan on 22/10/2021.
//

import SwiftUI

struct AddToCart: View {
    
    @EnvironmentObject var homeData: HomeViewModel
    
    var animation: Namespace.ID
    
    var body: some View {
        
        VStack {
            
            HStack(spacing: 15) {
                
                if !homeData.startAnimation {
                    
                    Image(uiImage: #imageLiteral(resourceName: "shoe"))
                        .resizable()
                        .scaledToFit()
                        .padding(.horizontal)
                        .matchedGeometryEffect(id: "SHOE", in: animation)
                    
                }
                
                VStack(alignment: .trailing, spacing: 10) {
                    
                    Text("Air Max Exosense 'Atomic powder'")
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                    
                    Text("$280.00")
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    
                }
                
            }
            .padding()
            
            Divider()
            
            Text("Select size".uppercased())
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(.gray)
                .padding(.vertical)
            
            // Sizes
            let columns = Array(repeating: GridItem(.flexible(), spacing: 8), count: 4)
            LazyVGrid(columns: columns, alignment: .leading, spacing: 15) {
                
                ForEach(sizes, id: \.self) { size in
                    
                    Button {
                        
                        withAnimation { 
                            homeData.selectedSize = size
                        }
                        
                    } label: {
                        
                        Text(size)
                            .fontWeight(.semibold)
                            .foregroundColor(homeData.selectedSize == size ? .white : .black)
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background( homeData.selectedSize == size ? Color("orange") : Color.black.opacity(0.04))
                            .cornerRadius(10)
                        
                    }
                    
                }
                
            }
            .padding(.top)
            
            // Add To Cart Button
            Button {
                
                withAnimation(.easeInOut(duration: 0.7)) { 
                    homeData.startAnimation.toggle()
                }
                
            } label: {
                
                Text("Add To Cart")
                    .fontWeight(.bold)
                    .foregroundColor(homeData.selectedSize == "" ? .black : .white)
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .background( homeData.selectedSize == "" ? Color.black.opacity(0.06) : Color("orange"))
                    .cornerRadius(10)
                
            }
            .disabled(homeData.selectedSize == "")
            
            
            
        }
        .padding()
        .background(Color.white.clipShape(CustomCorners(corners: [.topLeft, .topRight], radius: 35)))
        
    }
    
}

let sizes = ["EU 40","EU41","EU42","EU43","EU44"]
