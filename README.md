# 🌙 Moodi
A **privacy-first, on-device AI-powered mood tracking app for iOS** built with **SwiftUI**, **SwiftData**, **Charts**, **Core ML**, **HealthKit**, and **Screen Time APIs**.  
Track your **daily behavioral signals**, receive **on-device mood predictions**, and explore your **emotional patterns over time** through a calm, premium iOS experience.

---

### 📌 Short Description

Moodi is a polished iOS wellbeing app focused on **daily mood prediction**, **behavior-based emotional insights**, and **private on-device processing**.  
It combines behavioral inputs such as **sleep duration, physical activity, screen time, and step count** with an on-device machine learning model to predict the user’s mood, while still allowing manual correction whenever needed.

The app is designed around four core surfaces: a **Today** screen for the current prediction and daily inputs, a **Calendar** view for monthly mood history, an **Analytics** tab for period-based summaries and trend visualizations, and a **Settings** area for personalization, integrations, and privacy controls.

---

### 🚀 Why Moodi

- 🧠 On-device mood prediction powered by local machine learning
- 🔒 Private by design — your emotional and behavioral data stays on your device
- 📊 Clear history and analytics built for calm daily self-reflection

---

## 📹 App Demo

[Watch Demo](https://drive.google.com/file/d/1-yvwzZAwjo61pio9xkv9xDmLOze1D4iF/view?usp=sharing)

---

## ✨ Features

- 🤖 **On-device mood prediction** based on behavioral and wellness data
- 📝 Manual mood adjustment when the predicted result needs correction
- 📆 **Today** screen with a mood-first layout and fast daily input flow
- 🗓 **Monthly mood calendar** with tappable day-by-day history
- 📊 **Analytics dashboard** with period-based summaries for **week, month, year, and all time**
- 📈 Trend visualizations for **mood history** and **behavior metrics**
- 😴 Track and review key signals such as **sleep, activity, screen time, and steps**
- ❤️ Full **HealthKit integration** for wellness data access
- 📱 Full **Screen Time integration** for device usage insights
- 🎨 Personalized appearance with **System / Light / Dark theme selection**
- 💾 Local data persistence with **SwiftData**
- 🗑 One-tap **Delete All Data** reset flow
- 🌗 Carefully designed **Light and Dark Mode** support

---

## 🛠️ Tech Stack

iOS
- **SwiftUI**
- **SwiftData**
- **Charts**
- **Core ML**
- **HealthKit**
- **Screen Time APIs**

Architecture & UI
- **MVVM-style state organization**
- **Observation (`@Observable`)**
- **Native iOS design patterns**
- **SF Symbols**

Persistence & Personalization
- **SwiftData**
- **AppStorage / UserDefaults**

---

## 📄 Requirements

- Xcode 17+
- iOS 26+
- Health permissions for wellness data integration
- Screen Time permissions and supported configuration for device usage tracking

---

## 🚀 Installation

1. Clone the repository.
2. Open `Moodi.xcodeproj` in Xcode.
3. Build and run on an iPhone simulator or physical device.
4. Grant the requested **Health** and **Screen Time** permissions.

---

## 🧠 Notes

- Mood predictions are processed **entirely on-device**.
- Daily entries, behavioral metrics, and mood history are stored locally with **SwiftData**.
- Health and Screen Time integrations are used to enrich automatic behavioral tracking.
- Manual mood edits are preserved in local history and reflected across calendar and analytics views.
- The app is designed around a **calm, premium, privacy-first** iOS experience for long-term emotional self-observation.
