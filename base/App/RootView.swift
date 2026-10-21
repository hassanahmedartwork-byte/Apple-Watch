import SwiftUI
import WatchKit

struct RootView: View {
    @State private var count = 0
    @State private var selectedTasbeeh = 0
    @AppStorage("savedCount") private var savedCount = 0 
    
    let tasbeehList = ["سبحان الله", "الحمد لله", "لا إله إلا الله", "الله أكبر", "أستغفر الله"]
    
    var body: some View {
        VStack(spacing: 8) {
            Picker("", selection: $selectedTasbeeh) {
                ForEach(0..<tasbeehList.count, id: \.self) { index in
                    Text(tasbeehList[index])
                        .font(.headline)
                        .foregroundStyle(.green)
                        .tag(index)
                }
            }
            .pickerStyle(.wheel)
            .frame(height: 55) 
            
            Button(action: {
                count += 1
                savedCount = count
                WKInterfaceDevice.current().play(.click)
            }) {
                Text("\(count)")
                    .font(.system(size: 50, weight: .bold, design: .rounded)) 
                    .minimumScaleFactor(0.5)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(Color.green.opacity(0.2)) 
                    )
            }
            .buttonStyle(.plain)
            .handGestureShortcut(.primaryAction) 
            
            Button(action: {
                count = 0
                savedCount = 0
            }) {
                Text("تصفير")
                    .font(.footnote)
                    .foregroundStyle(.red)
            }
            .buttonStyle(.plain)
        }
        .onAppear {
            count = savedCount 
        }
    }
}

#Preview {
    RootView()
}
