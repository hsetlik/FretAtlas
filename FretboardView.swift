//
//  FretboardViet.swift
//  FretAtlasSwift
//
//  Created by Hayden Setlik on 8/1/21.
//

import SwiftUI

struct FretboardShape {
    static let points = [
        CGPoint(x: 0.05, y : 0.0),
        CGPoint(x: 0.95, y : 0.0),
        CGPoint(x: 1.0, y : 0.95),
        CGPoint(x: 0.0, y : 0.95),
    ]
    static func getFretPositions(numFrets: Int) -> [Double]
    {
        var values: [Double] = []
        values.append(0.0)
        var length = 1.0
        var pos: Double = 0.0
        for _ in 1...numFrets {
            length -= length / 17.817
            pos += length / 17.817
            values.append(pos)
        }
        return values
    }
}

struct FretShape
{
    static func getPath(width: Double, height: Double, center: Double) -> Path
    {
        var path = Path()
        let fretHeight = height * 0.002
        let yMid = center * height
        let y0 = yMid - (fretHeight / 2)
        let dXFull = 0.05 * width
        let x0 = (1.0 - center) * dXFull
        let x1 = width - x0
        path.move(to: CGPoint(x: x0, y: y0))
        path.addLine(to: CGPoint(x: x1, y: y0))
        let y1 = y0 + fretHeight
        path.addLine(to: CGPoint(x: x1, y: y1))
        path.addLine(to: CGPoint(x: x0, y: y1))
        return path
    }
}



struct FretboardView: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false, content: {
            VStack(alignment: .leading) {
                ZStack {
                GeometryReader { geometry in
                Path {path in
                    let width: CGFloat = geometry.size.width
                    let height: CGFloat = width * 7.0
                    path.move( to: CGPoint(x: width * 0.05, y: 0.0)
                            )
                    for point in FretboardShape.points
                    {
                        path.addLine(to: CGPoint(
                                        x: width * point.x,
                                        y: height * point.y)
                        )
                    }
                }.fill(Color(Color.RGBColorSpace.sRGB, red: 0.625, green: 0.28, blue: 0.18, opacity: 1.0))
                    let fretNum = 24
                    let fretCenters = FretboardShape.getFretPositions(numFrets: fretNum)
                    ForEach(fretCenters, id: \.self) {center in
                        FretShape.getPath(width: Double(geometry.size.width),
                                          height:
                                            Double(geometry.size.width) * 7, center: center)
                            .fill(Color.init(Color.RGBColorSpace.sRGB, red: 0.6, green: 0.6, blue: 0.6, opacity: 1.0))
                    }
                }
                    
            }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: 900, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
        })
        

    }
}

struct FretboardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FretboardView()
        }
    }
}
