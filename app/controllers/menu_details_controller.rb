class MenuDetailsController < UIViewController
  attr_accessor :name, :image_url, :image

  def viewDidLoad
    super
    self.view.addSubview(scroll_view)
    self.title = name
  end

  def scroll_view
    @scroll_view = begin
      scroll_view = UIScrollView.alloc.initWithFrame(UIScreen.mainScreen.applicationFrame)
      scroll_view.backgroundColor = UIColor.blackColor

      image_data = NSData.alloc.initWithContentsOfURL(NSURL.URLWithString(self.image_url))
      image = UIImage.alloc.initWithData(image_data)
      image_view = UIImageView.alloc.initWithImage(image)

      scroll_view.contentSize = image_view.frame.size
      scroll_view.addSubview(image_view)
      scroll_view.minimumZoomScale = view.frame.size.width / image_view.frame.size.width
      scroll_view.maximumZoomScale = 2.0
      scroll_view.setZoomScale(scroll_view.minimumZoomScale)
      scroll_view
    end
  end
end
