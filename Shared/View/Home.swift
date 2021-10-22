//
//  Home.swift
//  Add to Bag Animations
//
//  Created by Yuan on 22/10/2021.
//

import SwiftUI

struct Home: View {
    
    @StateObject var homeData = HomeViewModel()
    
    @Namespace var animation
    
    var body: some View {
        
        
        ZStack(alignment: .bottom) {
            
            // Home View
            VStack(spacing: 15) {
                
                HStack {
                    
                    Button {
                        
                    } label: {
                        
                        Image(systemName: "rectangle.grid.3x2.fill")
                            .font(.title2)
                            .foregroundColor(.black)
                        
                    }
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        
                        Image(systemName: "bag.fill")
                            .font(.title3)
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Color.purple)
                            .clipShape(Circle())
                            .overlay(
                            
                                Text("\(homeData.cartItems)")
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding(10)
                                    .background(Color("orange"))
                                    .clipShape(Circle())
                                    .offset(x: 15, y: -10)
                                    .opacity(homeData.cartItems != 0 ? 1 : 0)
                            )
                        
                    }
                    
                }
                .padding()
                .overlay(
                    
                    Text("Nike")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                
                )
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    // SHoe Cards...
                    VStack(alignment: .leading, spacing: 10) {
                        
                        Text("Air Max Exosense 'Atomic powder'")
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                        
                        Text("Nike")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        
                        Image(uiImage: #imageLiteral(resourceName: "shoe"))
                            .resizable()
                            .scaledToFit()
                        
                        Text("Price")
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)
                        
                        Text("$280.00")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(Color("orange"))
                        
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 20)
                    .background(Color.black.opacity(0.08))
                    .cornerRadius(20)
                    .overlay(
                        Capsule()
                            .fill(Color.purple)
                            .frame(width: 4, height: 45)
                            .padding(.top, 25)
                        
                        ,alignment: .topLeading
                    )
                    .padding()
                    .onTapGesture {
                        withAnimation { 
                            homeData.showCart.toggle()
                        }
                    }
                    
                }
            }
            .blur(radius: homeData.showCart ? 50 : 0)
            
            AddToCart(animation: animation)
                .offset(y: homeData.showCart ? homeData.startAnimation ? 500 : 0 : 500)
                .environmentObject(homeData)
            
            if homeData.startAnimation {
                
                VStack {
                    
                    Spacer()
                    
                    ZStack {
                        
                        // Circle ANimatio Effect...
                        
                        Color.white
                            .frame(width: homeData.shoeAnimation ? 100 : getRect().width * 1.3, height: homeData.shoeAnimation ? 100 : getRect().width * 1.3)
                            .clipShape(Circle())
                        // Opacit...
                            .opacity(homeData.shoeAnimation ? 1 : 0)
                        
                        Image(uiImage: #imageLiteral(resourceName: "shoe"))
                            .resizable()
                            .scaledToFit()
                            .matchedGeometryEffect(id: "SHOE", in: animation)
                            .frame(width: 80, height: 80)
                        
                    }
                    .offset(y: homeData.saveCart ? 70 : -120)
                    .scaleEffect(homeData.saveCart ? 0.5 : 1)
                    .onAppear(perform: homeData.performAnimations)
                    
                    if !homeData.saveCart {
                        Spacer()
                    }
                    
                    Image(systemName: "bag\(homeData.additemtocart ? ".fill" : "")")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .background(homeData.additemtocart ? Color.purple : Color("orange"))
                        .clipShape(Circle())
                        .offset(y: homeData.showBag ? -50 : 300)
                    
                }
                .frame(width: getRect().width)
                
            }
            
            
        }
        .ignoresSafeArea(.all, edges: .bottom)
        .background(Color.black.opacity(0.04).ignoresSafeArea())
        .onChange(of: homeData.endAnimation, perform: { value in
            if homeData.endAnimation {
                
                homeData.resetAll()
                
            }
        })
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

// extending view to get Screen size...

extension View{
    
    func getRect()->CGRect{
        return UIScreen.main.bounds
    }
}

