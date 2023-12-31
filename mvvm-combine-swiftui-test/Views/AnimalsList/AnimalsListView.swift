//
//  AnimalsListView.swift
//  mvvm-combine-swiftui-test
//
//  Created by Михаил Полев on 14.06.2023.
//

import SwiftUI
import Kingfisher

struct AnimalsListView: View {
  @ObservedObject var viewModel = AnimalsListViewModel(networkClient: NetworkClient())
  @Environment(\.colorScheme) var colorScheme

  var body: some View {
    NavigationView {
      GeometryReader { geometry in
        VStack(alignment: .leading, spacing: 0.0) {
          // Navigation Bar
          navigationBar(viewModel: viewModel, topInset: geometry.safeAreaInsets.top)
            .zIndex(1)
          
          ZStack(alignment: .top) {
            // View Background
            Color.custom(.background)
              .ignoresSafeArea()
            
            if viewModel.animals.isEmpty || viewModel.error != nil {
              if viewModel.error != nil {
                // Error view
                error(error: viewModel.error!)
              } else {
                // Loader view
                loader
              }
            } else {
              ScrollView(.vertical) {
                LazyVStack(alignment: .leading, spacing: 0) {
                  // Animals list
                  Section {
                    ForEach(viewModel.animals, id: \.id) { animal in
                      NavigationLink {
                        AnimalDetailView(animal: animal)
                      } label: {
                        animalRow(item: animal)
                      }
                    }
                  } header: {
                    Text("Nearby results")
                      .font(.custom("Sailec-Bold", size: 14))
                      .foregroundColor(Color.custom(.text))
                      .padding(EdgeInsets(top: 29.0, leading: 19.0, bottom: 22.0, trailing: 19.0))
                  }
                }
                .padding(.bottom, geometry.safeAreaInsets.bottom)
              }
            }
          }
        }
        .navigationBarHidden(true)
        .ignoresSafeArea()
      }
    }
  }
  
  /// Navigation Bar
  /// - Parameters:
  ///   - viewModel: AnimalsListViewModel
  ///   - topInset: CGFloat
  /// - Returns: Navigation Bar View
  @ViewBuilder private func navigationBar(viewModel: AnimalsListViewModel, topInset: CGFloat) -> some View {
    HStack(alignment: .top) {
      VStack(alignment: .leading, spacing: 10.0) {
        Text("Hey Spikey,")
          .font(.custom("Sailec-Bold", size: 20))
          .foregroundColor(Color.custom(.text))
          .frame(alignment: .leading)
        
        Text("Adopt a new friend near you!")
          .font(.custom("Sailec", size: 16))
          .foregroundColor(Color.custom(.text))
      }
      
      Spacer()
      
      Button(action: {
        viewModel.toggleColorScema(colorScheme: colorScheme)
      }, label: {
        Image("Light Icon", label: Text("Light Icon"))
      })
      .padding(EdgeInsets(top: 1.0, leading: 6.0, bottom: 6.0, trailing: 6.0))
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding(EdgeInsets(top: topInset + 8.0, leading: 19.0, bottom: 15.0, trailing: 39.0))
    .background(
      Rectangle()
        .fill(Color.custom(.background))
    )
  }
  
  /// Animal List Row View
  /// - Parameter item: Animal
  /// - Returns: Animal List Row View
  @ViewBuilder private func animalRow(item: Animal) -> some View {
    VStack(alignment: .leading, spacing: 0.0) {
      HStack(alignment: .center, spacing: 18.0) {
        VStack(spacing: 0) {
          // Image
          KFImage(item.primary_photo_cropped?.small)
            .resizable()
            .scaledToFill()
            .frame(width: 93.0, height: 96.0)
            .cornerRadius(12.0)
        }
        .frame(width: 93.0, height: 96.0)
        .background(
          RoundedRectangle(cornerRadius: 12.0)
            .fill(Color.custom(.listImagePlaceholder))
        )
        
        VStack(alignment: .leading, spacing: 0.0) {
          // Name
          Text(item.name)
            .font(.custom("Sailec-Medium", size: 16))
            .foregroundColor(Color.custom(.text))
            .multilineTextAlignment(.leading)
          
          // Age/Breeds
          Text("\(item.age.rawValue) | \(item.breeds.primary ?? "")")
            .font(.custom("Sailec", size: 12))
            .foregroundColor(Color.custom(.text))
            .padding(EdgeInsets(top: 10.0, leading: 0.0, bottom: 17.0, trailing: 0.0))
            .multilineTextAlignment(.leading)

          // Distance
          if let distance = item.distance {
            HStack(alignment: .center, spacing: 10.0) {
              Image("Pin", label: Text("Pin"))
              
              Text("\(distance)m away")
                .font(.custom("Sailec", size: 12))
                .foregroundColor(Color.custom(.text))
            }
          }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        
        Spacer()
        
        // Gender
        VStack(alignment: .trailing, spacing: 0.0) {
          if item.gender == .male {
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
          }
          
          Spacer()

          // Published
          Text(item.published_at.timeAgo())
            .font(.custom("Sailec", size: 12))
            .foregroundColor(Color.custom(.text))
            .frame(alignment: .trailing)
            .padding(.trailing, 7.0)
        }
        .padding(EdgeInsets(top: 5.0, leading: 0.0, bottom: 11.0, trailing: 0.0))
      }
      .padding(EdgeInsets(top: 12.0, leading: 12.0, bottom: 12.0, trailing: 11.0))
      .background(
        RoundedRectangle(cornerRadius: 16.0)
          .fill(Color.custom(.listCardBackground))
      )
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding(EdgeInsets(top: 0.0, leading: 12.0, bottom: 12.0, trailing: 15.0))
  }
  
  /// Loader View
  var loader: some View {
    VStack() {
      ProgressView()
        .progressViewStyle(CircularProgressViewStyle())
    }
    .frame(maxHeight: .infinity)
  }
  
  /// Error View
  /// - Parameter error: ErrorResponse
  /// - Returns: Error View
  @ViewBuilder private func error(error: ErrorResponse) -> some View {
    VStack() {
      Text(error.localizedDescription)
        .font(.custom("Sailec", size: 14))
        .foregroundColor(Color.custom(.text))
        .frame(alignment: .center)
        .padding(.bottom, 24.0)
      
      Button(action: {
        viewModel.update(error: nil)
        viewModel.getAnimals()
      }, label: {
        Text("Try again")
          .font(.custom("Sailec-Bold", size: 16))
          .foregroundColor(Color.custom(.text))
      })
    }
    .frame(maxHeight: .infinity)
    .padding(24.0)
  }
}
