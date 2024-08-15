import SwiftUI
import PhotosUI

struct CropView: View {
    var image: UIImage?
    var onCrop: (UIImage?, Bool) -> ()
    var cropSize: CGSize
    var isCircle: Bool
    
    /// - View Properties
    @Environment(\.dismiss) private var dismiss
    
    /// - Gesture Properties
    @State private var scale: CGFloat = 1
    @State private var lastScale: CGFloat = 0
    @State private var offset: CGSize = .zero
    @State private var lastStoredOffset: CGSize = .zero
    @GestureState private var isInteracting: Bool = false
    
    var body: some View {
        NavigationStack {
            imageView()
                .navigationTitle("Crop Your Avatar")
                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbarBackground(Color.clear, for: .navigationBar)
                .toolbarColorScheme(.dark, for: .navigationBar)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background {
                    IntroGradient()
                        .blur(radius: 10)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            let render = ImageRenderer(content: imageView(true))
                            render.proposedSize = .init(cropSize)
                            if let image = render.uiImage {
                                onCrop(image, true)
                            } else {
                                onCrop(nil, false)
                            }
                            dismiss()
                        } label: {
                            Image(systemName: "checkmark")
                                .font(.callout)
                                .fontWeight(.semibold)
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                                .font(.callout)
                                .fontWeight(.semibold)
                        }
                    }
                }
        }
    }
    
    /// Image View
    @ViewBuilder
    func imageView(_ hideGrids: Bool = false) -> some View {
        GeometryReader {
            let size = $0.size
            
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                
                /// - Reseting To last Location
                    .overlay(content: {
                        GeometryReader { proxy in
                            let rect = proxy.frame(in: .named("CROPVIEW"))
                            
                            Color.clear
                                .onChange(of: isInteracting) {oldValue, newValue in
                                    /// - true Dragging
                                    /// - false Stopped Dragging
                                    withAnimation(.easeInOut(duration: 0.2)) {
                                        if rect.minX > 0 {
                                            offset.width = (offset.width - rect.minX)
                                            haptic(.medium)
                                        }
                                        if rect.minY > 0 {
                                            offset.height = (offset.height - rect.minY)
                                            haptic(.medium)
                                        }
                                        if rect.maxX < size.width {
                                            offset.width = (offset.width + size.width - rect.maxX)
                                            haptic(.medium)
                                        }
                                        if rect.maxY < size.height {
                                            offset.height = (offset.height + size.height - rect.maxY)
                                            haptic(.medium)
                                        }
                                    }
                                    
                                    
                                    if !newValue {
                                        /// - Storing last offset
                                        lastStoredOffset = offset
                                    }
                                }
                        }
                    })
                    .frame(size)
            }
        }
        .scaleEffect(scale)
        .offset(offset)
        .overlay(content: {
            if !hideGrids {
                Grids()
            }
        })
        .coordinateSpace(name: "CROPVIEW")
        .gesture(
            DragGesture()
                .updating($isInteracting, body: { _, out, _ in
                    out = true
                }).onChanged({ value in
                    let translation = value.translation
                    offset = CGSize(width: translation.width + lastStoredOffset.width,
                                    height: translation.height + lastStoredOffset.height
                    )
                })
        )
        .gesture(
            MagnificationGesture()
                .updating($isInteracting, body: { _, out, _ in
                    out = true
                }).onChanged({ value in
                    let updatedScale = value + lastScale
                    /// - Limiting Beyond 1
                    scale = (updatedScale < 1 ? 1 : updatedScale)
                }).onEnded({ value in
                    withAnimation(.easeInOut(duration: 0.2)) {
                        if scale < 1 {
                            scale = 1
                            lastScale = 0
                        } else {
                            lastScale = scale - 1
                        }
                    }
                })
        )
        .frame(cropSize)
        .cornerRadius(isCircle ? cropSize.height / 2 : 0)
    }

    /// - Grids
    @ViewBuilder
    func Grids() -> some View {
        ZStack {
            HStack {
                ForEach(1...5, id: \.self) { _ in
                    Rectangle()
                        .fill(.white.opacity(0.7))
                        .frame(width: 1)
                        .frame(maxWidth: .infinity)
                }
            }

            VStack {
                ForEach(1...8, id: \.self) { _ in
                    Rectangle()
                        .fill(.white.opacity(0.7))
                        .frame(height: 1)
                        .frame(maxHeight: .infinity)
                }
            }
        }
    }
}

#Preview {
    CropView(
        image: UIImage(named: "woman"),
        onCrop: { _, _ in },
        cropSize: CGSize(width: 350, height: 350),
        isCircle: true
    )
}
