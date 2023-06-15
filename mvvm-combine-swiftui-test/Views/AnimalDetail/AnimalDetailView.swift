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
          Color.custom(.detailBackground)
            .ignoresSafeArea()
          
          navigationBar(viewModel: viewModel, topInset: geometry.safeAreaInsets.top)
            .zIndex(1)
          
          if let animal = viewModel.animal {
            ScrollViewWithStickyHeader(
              header: header,
              headerHeight: 346,
              onScroll: handleOffset
            ) {
              VStack(alignment: .leading, spacing: 0.0) {
                Text(animal.name)
                  .font(.custom("Sailec-Bold", size: 24))
                  .foregroundColor(Color.custom(.text))
                  .frame(alignment: .leading)
                Text(animal.description ?? "")
                  .font(.custom("Sailec", size: 14))
                  .foregroundColor(Color.custom(.text))
                  .frame(alignment: .leading)
              }
              .padding(EdgeInsets(top: 36.0, leading: 26.0, bottom: 36.0, trailing: 26.0))
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
  
  func header() -> some View {
    ZStack {
      GeometryReader { geometry in
        if let animal = viewModel.animal {
          KFImage(animal.primary_photo_cropped?.full)
            .resizable()
            .scaledToFill()
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
      }
    }
    .background(
      Rectangle()
        .fill(Color.custom(.listImagePlaceholder))
    )
  }
  
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

  var loader: some View {
    VStack() {
      ProgressView()
        .progressViewStyle(CircularProgressViewStyle())
    }
    .frame(maxHeight: .infinity)
  }
}

