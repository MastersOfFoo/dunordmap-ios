class AppDelegate
  attr_accessor :window

  def application(application, didFinishLaunchingWithOptions: launchOptions)
    # Setup main window
    self.window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    controller = RootController.alloc.initWithNibName(nil, bundle: nil)

    # Setup navigation controller
    navigation_controller = UINavigationController.alloc.initWithRootViewController(controller)
    self.window.rootViewController = navigation_controller

    # Setup navigation bar
    top_bar = UIImage.imageNamed("top_bar.png")
    navigation_bar = UINavigationBar.appearance
    navigation_bar.setBackgroundImage(top_bar, forBarMetrics: UIBarMetricsDefault)
    navigation_bar.setTitleTextAttributes({
      UITextAttributeFont: UIFont.fontWithName("Helvetica-Bold", size: 18),
      UITextAttributeTextShadowColor: UIColor.colorWithWhite(0.0, alpha: 0.4),
      UITextAttributeTextColor: UIColor.whiteColor
    })

    back_button = UIImage.imageNamed("button_back.png",
      resizableImageWithCapInsets:UIEdgeInsetsMake(12, 12, 12, 12))

    UIBarButtonItem.appearance.setBackButtonBackgroundImage(back_button, forState: UIControlStateNormal,
      barMetrics:UIBarMetricsDefault)

    load_splash_screen
    load_gps_timer
    true
  end

  private

  def load_gps_timer
    # Update GPS coordinates each five seconds
    EM.add_periodic_timer 5.0 do
      BW::Location.get do |result|
        if result[:to]
          App::Persistence['coordinates'] = [result[:to].latitude, result[:to].longitude]
        else
          UIAlertView.alloc.initWithTitle("Error", message:"Couldn't get current location",
            delegate: nil, cancelButtonTitle: "ok", otherButtonTitles: nil).show
        end
      end
    end
  end
  
  def load_splash_screen
    # Add a splash screen on start
    @splash_view = UIImageView.alloc.initWithImage(UIImage.imageNamed("Default.png"))
    self.window.rootViewController.view.addSubview(@splash_view)
    self.window.rootViewController.view.bringSubviewToFront(@splash_view)
    self.window.makeKeyAndVisible
    
    animation_handler = lambda { @splash_view.alpha = 0 }
    completion_handler = lambda { |finished| @splash_view.removeFromSuperview }

    # Make the splash screen to fade out after of 3.0 seconds
    UIView.transitionWithView(self.window, duration: 3.0, options: UIViewAnimationOptionTransitionNone,
      animations: animation_handler, completion: completion_handler)
  end
end
