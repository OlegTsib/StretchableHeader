//
//  StretchableHeader.swift
//  StretchableHeader
//
//  Created by Oleg Tsibulevskiy on 20/09/2020.
//

import SwiftUI

struct MenuItem: Identifiable
{
    let id = UUID()
    let name: String
    let description: String
    let image: String
}

struct MenuRepository
{
    let data:[MenuItem]
  
    init()
    {
        var items = [MenuItem]()
      
        for i in 1...20
        {
            items.append(MenuItem(name: "Dish", description: "Description", image: "dish\(i % 2)"))
        }
      
        data = items
    }
}

struct Menu: View
{
    var repository: MenuRepository
    
    var body: some View
    {
        ScrollView(.vertical, showsIndicators: false, content:
        {
            StretchableHeader(image: Image("header"))
            
            LazyVStack(spacing: 8)
            {
                ForEach(repository.data) { item in
                    
                    MenuItemCard(item: item)
                        .frame(height:100)
                }
            }
            
        })
        .edgesIgnoringSafeArea(.top)
        .statusBar(hidden: true)
    }
}

struct StretchableHeader: View
{
    var image: Image
    var initialHeaderHeight: CGFloat = UIScreen.main.bounds.height * 0.25
    
    var body: some View
    {
        GeometryReader(content: { geometry in

            let minY = geometry.frame(in: .global).minY

            image
                .resizable()
                .offset(y: minY > 0 ? -minY : 0)
                .frame(height: minY > 0 ? initialHeaderHeight + minY : initialHeaderHeight)
                .aspectRatio(2, contentMode: .fill)
        })
        .frame(height: initialHeaderHeight)
    }
}

struct MenuItemCard: View
{
    var item: MenuItem
    
    let backgroundColor = Color(red: 248/255, green: 245/255, blue: 242/255)

    var body: some View
    {
        HStack(alignment: .top)
        {
            Image(item.image)
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .padding(4)
            
            VStack(alignment: .leading, spacing: 8)
            {
                Text(item.name).font(.title2)
                Text(item.description).font(.body).foregroundColor(Color.gray)
            }
            .padding(.top, 2)
        }
        .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
        .background(backgroundColor)
    }
}

struct StretchableHeaderPreviews: PreviewProvider {
    static var previews: some View {
        Menu(repository: MenuRepository())
    }
}
