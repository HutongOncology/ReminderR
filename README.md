# ReminderR - R Script Completion Notifier

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)

A lightweight R package that sends push notifications to your iPhone when your R scripts finish running, so you don't need to constantly monitor long-running analyses.

## Features

- One-line setup for instant notifications
- Seamless integration with RStudio
- Works with iOS devices through Bark
- Customizable notification messages

## Installation

### 1. Install ReminderR Package (RStudio)

```r
if (!requireNamespace("devtools", quietly = TRUE))
  install.packages("devtools")

devtools::install_github("HutongOncology/ReminderR")
```

### 2. Install Bark App (iOS)

Download the free Bark app from the App Store: [Bark Official Website](https://apps.apple.com/cn/app/bark-%E7%BB%99%E4%BD%A0%E7%9A%84%E6%89%8B%E6%9C%BA%E5%8F%91%E6%8E%A8%E9%80%81/id1403753865)

## QuickStart

```r
# Usage Example
library(ReminderR)

# Set your Bark device key (get this from the Bark app)
set_bark_key("https://api.day.app/{your_device_key}")

# Your long-running R code here...

# after code ending
bark_notify("R Script Completed", "Your analysis has finished running")
```
