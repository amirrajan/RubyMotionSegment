class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    rootViewController = MainViewController.alloc.init
    rootViewController.title = 'RubyMotionSegment'
    rootViewController.view.backgroundColor = UIColor.whiteColor

    navigationController = UINavigationController.alloc.initWithRootViewController(rootViewController)

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = navigationController
    @window.makeKeyAndVisible

    # Never run synchronously on the main ui thread.
    configure_segment_async

    true
  end

  def configure_segment_async
    Dispatch::Queue.main.async do
      configuration = SEGAnalyticsConfiguration.configurationWithWriteKey("[YOURKEYHERE]")
      configuration.trackApplicationLifecycleEvents = true
      configuration.recordScreenViews = true
      SEGAnalytics.setupWithConfiguration(configuration)
    end
  end

  def self.run_after delay, &block
    NSTimer.scheduledTimerWithTimeInterval(
      delay,
      target: block,
      selector: 'call:',
      userInfo: nil,
      repeats: false
    )
  end
end
