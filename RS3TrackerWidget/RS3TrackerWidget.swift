//
//  RS3TrackerWidget.swift
//  RS3TrackerWidget
//
//  Created by Chad Hamdan on 8/1/22.
//  Copyright © 2022 Chad Hamdan. All rights reserved.
//

import WidgetKit
import SwiftUI

// MARK: Widget

@main
struct RS3TrackerWidget: Widget {
    let kind: String = "RS3TrackerWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            RS3TrackerWidgetEntryView(entry: entry)
        }
        .supportedFamilies([.systemSmall, .systemMedium])
        .configurationDisplayName("RS3Tracker Widget")
        .description("Stay updated with your game stats!")
    }
}

// MARK: Provider

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), username: "Username", totalLevel: "1234", totalXP: "123,456", rank: "12,234")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), username: "Username", totalLevel: "1234", totalXP: "123,456", rank: "12,234")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        if let fileURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "rs3tracker")?.appendingPathComponent("username"),
           let username = try? String(contentsOf: fileURL, encoding: .utf8),
           let requestURL = URL(string: "https://apps.runescape.com/runemetrics/profile/profile?user=\(username)&activities=5") {

            let task = URLSession.shared.dataTask(with: requestURL) { data, response, error in
                if let data = data, let playerData = try? JSONDecoder().decode(PlayerData.self, from: data) {
                    entries.append(SimpleEntry(date: Date(),
                                               username: username,
                                               totalLevel: "\(playerData.totalskill ?? -1)",
                                               totalXP: "\(playerData.totalxp ?? -1)",
                                               rank: "\(playerData.rank ?? "Error")"))

                    let timeline = Timeline(entries: entries, policy: .after(Date().addingTimeInterval(300)))
                    completion(timeline)
                }
            }
            task.resume()
        }
    }
}

// MARK: SimpleEntry

struct SimpleEntry: TimelineEntry {
    let date: Date
    let username: String
    let totalLevel: String
    let totalXP: String
    let rank: String
}

// MARK: Views

struct RS3TrackerWidgetEntryView : View {
    @Environment(\.widgetFamily) var widgetFamily
    var entry: Provider.Entry

    var body: some View {
        switch widgetFamily {
        case .systemSmall:
            SmallWidgetView(entry: entry)
        case .systemMedium:
            MediumWidgetView(entry: entry)
        default:
            Text("Unsupported Size")
        }
    }
}

struct SmallWidgetView: View {
    var entry: SimpleEntry

    var body: some View {
        VStack {
            Label("\(entry.username)", image: "default_chat").imageScale(.small)
            Divider()
            VStack() {
                HStack() {
                    Text("Total XP").bold()
                }
                HStack {
                    Text("\(entry.totalXP)")
                }
            }
        }
        .padding(.all, 8)
    }
}

struct MediumWidgetView: View {
    var entry: SimpleEntry

    var body: some View {
        VStack {
            Label("\(entry.username)", image: "default_chat").imageScale(.small)
            Divider()
            VStack() {
                HStack() {
                    Text("Total Level").bold()
                    Spacer()
                    Text("\(entry.totalLevel)")
                }.padding(.horizontal, 42)
                HStack {
                    Text("Total XP").bold()
                    Spacer()
                    Text("\(entry.totalXP)")
                }.padding(.horizontal, 42)
                HStack {
                    Text("Rank").bold()
                    Spacer()
                    Text("\(entry.rank)")
                }.padding(.horizontal, 42)
            }
        }
        .padding(.all, 8)
    }
}
