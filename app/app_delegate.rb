class AppDelegate
  attr_accessor :window

  def application(application, didFinishLaunchingWithOptions:launchOptions)
    rootViewController = MainViewController.alloc.init
    rootViewController.title = 'RubyMotionSegment'
    rootViewController.view.backgroundColor = UIColor.whiteColor

    navigationController = UINavigationController.alloc.initWithRootViewController(rootViewController)

    self.window ||= UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    self.window.rootViewController = navigationController
    self.window.makeKeyAndVisible

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
