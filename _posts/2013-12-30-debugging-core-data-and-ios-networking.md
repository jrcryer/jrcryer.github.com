---
layout: posts
current: posts
title: Debugging Core Data and Networking with PonyDebugger
description: PonyDebugger offers the ability to debug iOS applications Core Data and Networking
excerpt: PonyDebugger offers the ability to debug iOS applications Core Data and Networking.  Find out how to get started with it in this post.
keyword: iOS, Core Data, PonyDebugger, Networking, Debugging, Tooling
---

I'm forever searching for ways to make my life easier as a developer, I love trying new tools to help me whilst developing new apps.  I'd previously heard of [PonyDebugger from Square](https://github.com/square/PonyDebugger) but never had the opportunity use it on a project.  PonyDebugger allows you to view the data stored within your application, networking, remote logging and view hiearchy using Chrome DevTools whilst running in the iOS simulator.

I've just started a new iOS project which requires the use of CoreData and makes calls to a remote content store to periodically refresh the data within the application.  This seemed like the perfect opportunity to give it a spin.

# Installing

Installing PonyDebugger is very simple to install and takes less than 5 minutes.  Firstly you need to install the service that runs locally.  To install this service use the follow:

```
curl -sk https://cloud.github.com/downloads/square/PonyDebugger/bootstrap-ponyd.py |\
  python - --ponyd-symlink=/usr/local/bin/ponyd ~/Library/PonyDebugger

```

Once successfully installed, you can run the service using:

```
~/Library/PonyDebugger/bin/ponyd serve --listen-interface=127.0.0.1

```

If the service starts successfully, you should be able to access from Chrome by visiting `http://localhost:9000`.

Next the PonyDebugger client needs to be installed in your iOS application.  I'ved used [CocoaPods](http://beta.cocoapods.org/?q=ponydebugger) and added the following to my Podfile:

```
pod "PonyDebugger", "~> 0.3.0"

```

And running `pod install`.  Next you need to add use the newly added library to your app.  This will connect to the PonyDebugger service when the application starts.  This code should only be used during development and not in production for obivous reasons.

In your application delegate add the following to the start of `- (BOOL) application:didFinishLaunchingWithOptions`:

```
[[PDDebugger defaultInstance] connectToURL:[NSURL URLWithString:@"ws://localhost:9000/device"]];
[[PDDebugger defaultInstance] enableNetworkTrafficDebugging];
[[PDDebugger defaultInstance] forwardAllNetworkTraffic];

```

# Viewing the data

If you run your application in the iOS simulator and revisit the `http://localhost:9000` in Chrome, this should list all applications that are current talking to your service.  Selecting your application will display the Chrome DevTools interface for your application.  Click the Network tab to view the network connections made by your application.

For further information regarding setting up debugging for CoreData, Remote Logging and View Hiearchy read the excellent documentation produced by Square on their [Github page](https://github.com/square/PonyDebugger).
