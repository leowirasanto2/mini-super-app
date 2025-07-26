//
//  HeightObserver.swift
//  MiniSAPlayground
//
//  Created by Leo Wirasanto Laia on 26/07/25.
//
import SwiftUI

struct HeightPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct WidthPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero

    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

// Height observer view modifier
struct HeightObserver: ViewModifier {
    @Binding var height: CGFloat

    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { geometry in
                    Color.clear
                        .preference(key: HeightPreferenceKey.self, value: geometry.size.height)
                }
            )
            .onPreferenceChange(HeightPreferenceKey.self) { newHeight in
                self.height = newHeight
            }
    }
}

// Width observer view modifier
struct WidthObserver: ViewModifier {
    @Binding var width: CGFloat

    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { geometry in
                    Color.clear
                        .preference(key: WidthPreferenceKey.self, value: geometry.size.width)
                }
            )
            .onPreferenceChange(WidthPreferenceKey.self) { newWidth in
                self.width = newWidth
            }
    }
}

// Size observer view modifier
struct SizeObserver: ViewModifier {
    @Binding var size: CGSize

    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { geometry in
                    Color.clear
                        .preference(key: SizePreferenceKey.self, value: geometry.size)
                }
            )
            .onPreferenceChange(SizePreferenceKey.self) { newSize in
                self.size = newSize
            }
    }
}

// Extension to make these modifiers easier to use
extension View {
    func observeHeight(_ height: Binding<CGFloat>) -> some View {
        self.modifier(HeightObserver(height: height))
    }

    func observeWidth(_ width: Binding<CGFloat>) -> some View {
        self.modifier(WidthObserver(width: width))
    }

    func observeSize(_ size: Binding<CGSize>) -> some View {
        self.modifier(SizeObserver(size: size))
    }
}

// Example usage with custom presentation detent
extension PresentationDetent {
    static func contentHeight(_ height: CGFloat) -> PresentationDetent {
        return .height(height)
    }
}

// Example View demonstrating usage
struct HeightObserverDemoView: View {
    @State private var viewHeight: CGFloat = 0
    @State private var viewWidth: CGFloat = 0
    @State private var viewSize: CGSize = .zero

    var body: some View {
        VStack {
            Text("This view's height is being observed")
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue.opacity(0.2))
                .observeHeight($viewHeight)

            Text("Height: \(Int(viewHeight))")
                .padding()

            Divider()

            Text("This view's width is being observed")
                .padding()
                .background(Color.green.opacity(0.2))
                .observeWidth($viewWidth)

            Text("Width: \(Int(viewWidth))")
                .padding()

            Divider()

            Text("This view's size is being observed")
                .padding()
                .frame(width: 200)
                .background(Color.orange.opacity(0.2))
                .observeSize($viewSize)

            Text("Size: \(Int(viewSize.width)) x \(Int(viewSize.height))")
                .padding()
        }
        .padding()
    }
}

// Example for sheet with dynamic height
struct SheetWithDynamicHeight: View {
    @State private var isShowingSheet = false
    @State private var sheetContentHeight: CGFloat = 0

    var body: some View {
        Button("Show Sheet") {
            isShowingSheet = true
        }
        .sheet(isPresented: $isShowingSheet) {
            VStack(spacing: 20) {
                Text("Dynamic Content")
                    .font(.title)

                ForEach(1..<4) { index in
                    Text("Content item \(index)")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue.opacity(0.1))
                }

                Button("Close") {
                    isShowingSheet = false
                }
                .padding()
            }
            .padding()
            .observeHeight($sheetContentHeight)
            .presentationDetents([.contentHeight(sheetContentHeight + 50)])
            .presentationDragIndicator(.visible)
            .onChange(of: sheetContentHeight) { _, _ in
                // This is needed because presentationDetents doesn't update automatically
                // when the detent value changes. We'd need a better solution in a real app.
                print("Content height changed to: \(sheetContentHeight)")
            }
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        HeightObserverDemoView()
        SheetWithDynamicHeight()
    }
}
