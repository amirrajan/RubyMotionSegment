class MainViewController < UIViewController
  def viewDidLoad
    track_async("view controller loaded", { "ControllerName" => "MainViewController" })
  end

  def track_async(track_id, properties)
    # There is always a chance that async actions havn't been resolved yet.
    # If SEGAnalytics is nil, queue it up again to be run after one second.
    if !SEGAnalytics.sharedAnalytics
      AppDelegate.run_after(1.0) { track_async(track_id, properties) }
    else
      # Never run synchronously on the main ui thread.
      Dispatch::Queue.main.async do
        SEGAnalytics.sharedAnalytics.track(track_id, properties: properties);
      end
    end
  end
end
