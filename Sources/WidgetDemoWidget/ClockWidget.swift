import SwiftUI
import WidgetKit

@main
struct WidgetDemoBundle: WidgetBundle {
    var body: some Widget {
        ClockWidget()
    }
}

struct ClockWidget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: "ClockWidget",
            provider: Provider()
        ) { entry in
            VStack(spacing: 4) {
                Text(entry.date, style: .time)
                    .font(.title2.bold())
                Text(entry.date, style: .date)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("Clock")
        .description("Shows the current time and date.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }

    struct Entry: TimelineEntry {
        var date = Date()
    }

    struct Provider: TimelineProvider {
        func placeholder(in context: Context) -> Entry {
            Entry()
        }

        func getSnapshot(in context: Context, completion: @escaping (Entry) -> Void) {
            completion(Entry())
        }

        func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
            // Refresh on the minute boundary so the clock stays accurate
            // without hammering the system.
            let next = Calendar.current.nextDate(
                after: Date(),
                matching: DateComponents(second: 0),
                matchingPolicy: .nextTime
            ) ?? Date().addingTimeInterval(60)
            completion(Timeline(entries: [Entry()], policy: .after(next)))
        }
    }
}
