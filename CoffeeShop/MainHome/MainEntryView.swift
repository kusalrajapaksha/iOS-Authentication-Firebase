//
//  MainEntryView.swift
//  CoffeeShop
//
//  Created by Kusal on 2024-02-12.
//

import SwiftUI
import UIKit

struct MainEntryView: View {
    
    @State private var selectedTabIndex = 0
    
    var body: some View {
        let firstPageView = MainHomeView()
        let secondPageView = MainFavouritesView()
        let thirdPageView = MainCartView()
        let mainViewPages: [AnyView] = [AnyView(firstPageView), AnyView(secondPageView), AnyView(thirdPageView)]
        
        let iconWidth: CGFloat = 30
        
        ZStack{
            MainPageView(pages: mainViewPages, currentPage: $selectedTabIndex).ignoresSafeArea()
            
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    Image(systemName: "house.circle.fill")
                        .resizable()
                        .frame(width: iconWidth,height: iconWidth)
                        .foregroundColor(selectedTabIndex == 0 ? Color.orange : Color.white)
                        .scaleEffect(x: selectedTabIndex == 0 ? 1.5 : 1, y: selectedTabIndex == 0 ? 1.5 : 1)
                        .onTapGesture {
                            withAnimation{
                                selectedTabIndex = 0
                            }
                            
                        }
                    Spacer()
                    Image(systemName: "heart.circle.fill")
                        .resizable()
                        .frame(width: iconWidth,height: iconWidth)
                        .foregroundColor(selectedTabIndex == 1 ? Color.orange : Color.white)
                        .scaleEffect(x: selectedTabIndex == 1 ? 1.5 : 1, y: selectedTabIndex == 1 ? 1.5 : 1)
                        .onTapGesture {
                            withAnimation{
                                selectedTabIndex = 1
                            }
                        }
                    Spacer()
                    Image(systemName: "cart.circle.fill")
                        .resizable()
                        .frame(width: iconWidth,height: iconWidth)
                        .foregroundColor(selectedTabIndex == 2 ? Color.orange : Color.white)
                        .scaleEffect(x: selectedTabIndex == 2 ? 1.5 : 1, y: selectedTabIndex == 2 ? 1.5 : 1)
                        .onTapGesture {
                            withAnimation{
                                selectedTabIndex = 2
                            }
                        }
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .padding(.top,20)
                .frame(height: 50)
                .background(Color(hex: "3E3232"))
                
            }
        }
        
    }
}

#Preview {
    MainEntryView()
}


struct PageViewControllerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> PageViewController {
        return PageViewController()
    }
    
    func updateUIViewController(_ uiViewController: PageViewController, context: Context) {
        // Update the view controller if needed
        
        
    }
}

class PageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    // Your custom view controllers
    let views: [UIViewController] = [
        UIHostingController(rootView: MainHomeView()), // Page 1
        UIHostingController(rootView: MainFavouritesView()), // Page 2
        UIHostingController(rootView: MainCartView())  // Page 3
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        setViewControllers([views[0]], direction: .forward, animated: true, completion: nil)
    }
    
    // MARK: - UIPageViewControllerDataSource
    
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = views.firstIndex(of: viewController), index > 0 else {
            return nil
        }
        return views[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = views.firstIndex(of: viewController), index < views.count - 1 else {
            return nil
        }
        return views[index + 1]
    }
}
