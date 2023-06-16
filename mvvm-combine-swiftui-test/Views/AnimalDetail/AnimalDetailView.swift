//
//  AnimalDetailView.swift
//  mvvm-combine-swiftui-test
//
//  Created by Михаил Полев on 15.06.2023.
//

import SwiftUI
import Kingfisher
import ScrollKit

struct AnimalDetailView: View {
  @ObservedObject var viewModel = AnimalDetailViewModel()
  @Environment(\.presentationMode) var presentationMode
  
  @State private var offset = CGPoint.zero
  @State private var visibleRatio = CGFloat.zero

  init(animal: Animal) {
    viewModel.update(animal: animal)
  }
  
  func handleOffset(_ scrollOffset: CGPoint, visibleHeaderRatio: CGFloat) {
    self.offset = scrollOffset
    self.visibleRatio = visibleHeaderRatio
  }

  var body: some View {
    GeometryReader { geometry in
      VStack(alignment: .leading, spacing: 0.0) {
        ZStack(alignment: .top) {
          // View background
          Color.custom(.detailBackground)
            .ignoresSafeArea()
          
          // Navigation bar
          navigationBar(viewModel: viewModel, topInset: geometry.safeAreaInsets.top)
            .zIndex(1)
          
          if let animal = viewModel.animal {
            ScrollViewWithStickyHeader(
              header: header,
              headerHeight: 346,
              onScroll: handleOffset
            ) {
              VStack(alignment: .leading, spacing: 0.0) {
                // Name
                HStack(alignment: .top) {
                  Text(animal.name)
                    .font(.custom("Sailec-Bold", size: 24))
                    .foregroundColor(Color.custom(.text))
                    .frame(alignment: .leading)
                  
                  Spacer()
                  
                  // Gender
                  if animal.gender == .male {
                    VStack() {
                      Text("Male")
                        .font(.custom("Sailec", size: 12))
                        .foregroundColor(Color.custom(.maleColor))
                    }
                    .padding(EdgeInsets(top: 5.0, leading: 12.0, bottom: 5.0, trailing: 12.0))
                    .background(
                      RoundedRectangle(cornerRadius: 13.0)
                        .fill(Color.custom(.maleColor))
                        .opacity(0.1)
                    )
                    .offset(y: 8.0)
                  } else {
                    VStack() {
                      Text("Female")
                        .font(.custom("Sailec", size: 12))
                        .foregroundColor(Color.custom(.femaleColor))
                    }
                    .padding(EdgeInsets(top: 5.0, leading: 12.0, bottom: 5.0, trailing: 12.0))
                    .background(
                      RoundedRectangle(cornerRadius: 13.0)
                        .fill(Color.custom(.femaleColor))
                        .opacity(0.1)
                    )
                    .offset(y: 8.0)
                  }
                }
                .padding(.bottom, 16.0)
                
                // Distance
                if let distance = animal.distance {
                  HStack(alignment: .center, spacing: 10.0) {
                    Image("Pin", label: Text("Pin"))
                    
                    Text("\(distance)m away")
                      .font(.custom("Sailec", size: 12))
                      .foregroundColor(Color.custom(.text))
                  }
                }
                
                // Age/Breeds and published time
                HStack(alignment: .center) {
                  Text(animal.published_at.timeAgo())
                    .font(.custom("Sailec", size: 12))
                    .foregroundColor(Color.custom(.text))
                  
                  Spacer()
                  
                  Text("\(animal.age.rawValue) | \(animal.breeds.primary ?? "")")
                    .font(.custom("Sailec", size: 12))
                    .foregroundColor(Color.custom(.text))
                    .padding(EdgeInsets(top: 10.0, leading: 0.0, bottom: 17.0, trailing: 0.0))
                    .frame(alignment: .leading)
                }
                .padding(.bottom, 36.0)
                
                // description
                if let description = animal.description {
                  VStack(alignment: .leading, spacing: 17.0) {
                    Text("About me")
                      .font(.custom("Sailec-Medium", size: 16))
                      .foregroundColor(Color.custom(.text))
                      .frame(alignment: .leading)
                    
                    Text(description)
                      .font(.custom("Sailec", size: 14))
                      .foregroundColor(Color.custom(.text))
                      .frame(alignment: .leading)
                  }
                  .padding(.bottom, 36.0)
                }
                
                // Quick Info
                VStack(alignment: .leading, spacing: 17.0) {
                  Text("Quick Info")
                    .font(.custom("Sailec-Medium", size: 16))
                    .foregroundColor(Color.custom(.text))
                    .frame(alignment: .leading)
                  
                  HStack(alignment: .center, spacing: 0.0) {
                    infoItem(label: "Age", value: animal.age.rawValue)
                    Spacer()
                    infoItem(label: "Color", value: animal.colors.primary ?? "")
                    Spacer()
                    infoItem(label: "Size", value: animal.size.rawValue)
                  }
                }
                .padding(.bottom, 36.0)
                
                // Owner Info
                VStack(alignment: .leading, spacing: 24.0) {
                  Text("Owner Info")
                    .font(.custom("Sailec-Medium", size: 16))
                    .foregroundColor(Color.custom(.text))
                    .frame(alignment: .leading)
                  
                  infoOwner(contact: animal.contact)
                }
                .padding(.bottom, 56.0)
                
                // Adopt button
                button
              }
              .padding(EdgeInsets(top: 36.0, leading: 26.0, bottom: 36.0 + geometry.safeAreaInsets.bottom, trailing: 26.0))
              .frame(maxWidth: .infinity)
            }
          } else {
            loader
          }
        }
      }
      .navigationBarHidden(true)
      .ignoresSafeArea()
    }
  }
  
  /// Animal Detail Viev | Stiky header
  /// - Returns: Stiky header view
  func header() -> some View {
    ZStack {
      GeometryReader { geometry in
        if let animal = viewModel.animal {
          KFImage(animal.primary_photo_cropped?.full)
            .resizable()
            .scaledToFit()
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
      }
    }
    .background(
      Rectangle()
        .fill(Color.custom(.listImagePlaceholder))
    )
  }
  
  /// Animal Detail Viev | Adopt button
  var button: some View {
    Button(action: {
      // TODO: action
    }, label: {
      VStack(alignment: .center) {
        Text("Adopt me")
          .font(.custom("Sailec-Medium", size: 16))
          .foregroundColor(.white)
          .frame(maxWidth: .infinity)
      }
      .frame(height: 52.0)
      .background(
        RoundedRectangle(cornerRadius: 8.0)
          .fill(Color.custom(.buttonBackground))
      )
    })
    .buttonStyle(.plain)
  }
  
  /// Animal Detail Viev | Owner info
  /// - Parameter contact: Animal.Contact
  /// - Returns: Owner info view
  @ViewBuilder private func infoOwner(contact: Animal.Contact) -> some View {
    HStack(alignment: .center, spacing: 16.0) {
      Image("Avatar", label: Text("Avatar"))
      
      VStack(alignment: .leading, spacing: 10.0) {
        Text("David Berlin")
          .font(.custom("Sailec-Medium", size: 14))
          .foregroundColor(Color.custom(.text))
          .frame(alignment: .leading)
        
        Text("Socialist & Developer")
          .font(.custom("Sailec", size: 12))
          .foregroundColor(Color.custom(.infoGray))
          .frame(alignment: .leading)
      }

      Spacer()
      
      Button(action: {
        // TODO: action
      }, label: {
        Image("Messenger", label: Text("Messenger"))
      })
      .padding(.trailing, 20.0)
    }
    .frame(maxWidth: .infinity)
  }
  
  /// Animal Detail Viev |  Quick info item
  /// - Parameters:
  ///   - label: String
  ///   - value: String
  /// - Returns:Quick info item view
  @ViewBuilder private func infoItem(label: String, value: String) -> some View {
    VStack(alignment: .center, spacing: 4.0) {
      Text(value)
        .font(.custom("Sailec-Medium", size: 16))
        .foregroundColor(Color.custom(.text))
        .frame(alignment: .leading)
      
      Text(label)
        .font(.custom("Sailec", size: 10))
        .foregroundColor(Color.custom(.infoGray))
        .frame(alignment: .leading)
    }
    .frame(width: 91.0, height: 60.0)
    .background(Color.custom(.detailInfoBackground))
    .cornerRadius(12.0)
  }
  
  /// Animal Detail Viev |  Navigation Bar
  /// - Parameters:
  ///   - viewModel: AnimalDetailViewModel
  ///   - topInset: CGFloat
  /// - Returns: Navigation Bar view
  @ViewBuilder private func navigationBar(viewModel: AnimalDetailViewModel, topInset: CGFloat) -> some View {
    HStack(alignment: .top) {
      Button(action: {
        presentationMode.wrappedValue.dismiss()
      }, label: {
          Image("Back", label: Text("Back"))
      })
      .padding(EdgeInsets(top: 1.0, leading: 6.0, bottom: 6.0, trailing: 6.0))
      
      Spacer()
      
      Button(action: {
        // TODO: action
      }, label: {
        Image("Heart", label: Text("Heart"))
      })
      .padding(EdgeInsets(top: 1.0, leading: 6.0, bottom: 6.0, trailing: 6.0))
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding(EdgeInsets(top: topInset + 8.0, leading: 19.0, bottom: 15.0, trailing: 39.0))
  }
  
  /// Animal Detail Viev | Loader
  var loader: some View {
    VStack() {
      ProgressView()
        .progressViewStyle(CircularProgressViewStyle())
    }
    .frame(maxHeight: .infinity)
  }
}

