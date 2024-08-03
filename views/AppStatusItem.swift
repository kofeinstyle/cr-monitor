import SwiftUI
import Combine

private struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) { value = nextValue() }
}

struct AppStatusItem: View {
    @StateObject var gasFetcher = GasFetcher()
    var sizePassthrough: PassthroughSubject<CGSize, Never>

    public init(sizePassthrough: PassthroughSubject<CGSize, Never>) {
        self.sizePassthrough = sizePassthrough
    }

    @ViewBuilder
    var mainContent: some View {
        HStack {
            
            Image(systemName: getIcon())
                .fixedSize()
                .imageScale(.large)
                .symbolEffect(.variableColor.cumulative, value: isFirstLoading())
            
            Text(getText())
                .fixedSize()
                .contentTransition(.symbolEffect(.replace))
                .bold()
        }
        .padding(.horizontal, 8)
        .foregroundColor(currentColor())
        
        .contentShape(Rectangle())
    }

    var body: some View {
        mainContent
            .overlay(
                GeometryReader { geometryProxy in
                    Color.clear
                        .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
                }
            )
            .onPreferenceChange(SizePreferenceKey.self, perform: { size in
                sizePassthrough.send(size)
            })
    }
    
    private func getText() -> String {
        if (gasFetcher.errorMessage != nil) {
            return "~"
        }
        return gasFetcher.gas?.standart ?? "~"
    }
    
    private func currentColor() -> Color {

        if (gasFetcher.errorMessage != nil) {
            return Color.red
        }
        
        if isFirstLoading() {
            return Color.gray
        }
        
        switch (gasFetcher.gas?.level ?? GasLevel.low) {
            case GasLevel.low:
                return Color("GasLow")
            case GasLevel.medium:
                return Color("GasMedium")
            default:
                return Color("GasHigh")
        }
    }
    
    private func isFirstLoading() -> Bool {
        return gasFetcher.gas?.level == nil
    }
    
    private func getIcon() -> String
    {
        return gasFetcher.errorMessage != nil ? "network.slash" : "network"
    }
}
