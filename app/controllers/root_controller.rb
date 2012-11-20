class RootController < UIViewController
  def viewDidLoad
    super
    self.view.addSubview(menu_table_view)

    back_button = UIBarButtonItem.alloc.initWithTitle("Back", style: UIBarButtonItemStylePlain, target: nil, action: nil)
    self.navigationItem.backBarButtonItem = back_button
    self.title = "Du Nord Map"
  end
  
  def menu_table_view
    @menu_table_view ||= begin
      table_view = UITableView.alloc.initWithFrame(self.view.bounds, style: UITableViewStyleGrouped)
      table_view.dataSource = table_view.delegate = self
      table_view.backgroundView = nil
      table_view.backgroundColor = "#EEEDE4".to_color
      table_view.separatorColor = "#9C9C9C".to_color
      table_view
    end
  end

  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    @reuseIdentifier ||= "CELL_IDENTIFIER"

    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
      UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:@reuseIdentifier)
    end

    cell.textLabel.text = menu_items.values[indexPath.row]
    cell.textLabel.textColor = "#7F7F7F".to_color
    cell.textLabel.backgroundColor = UIColor.clearColor;
    cell.textLabel.font = UIFont.fontWithName("Helvetica-Bold", size: 14)
    cell.imageView.image = UIImage.imageNamed("icon_#{menu_items.keys[indexPath.row]}.png")
    cell.imageView.setOpaque(false)
    cell.contentView.backgroundColor = "#F1F2F4".to_color
    cell.accessoryView = UIImageView.alloc.initWithImage(UIImage.imageNamed("arrow.png"))
    cell.accessoryView.backgroundColor = UIColor.clearColor
    cell
  end

  def tableView(tableView, numberOfRowsInSection:section)
    menu_items.size
  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    
    open(menu_items.keys[indexPath.row])
  end

  def open(controller_name)
    begin
      NSLog(controller_name)
      controller_class = Module.const_get("#{controller_name.capitalize}Controller")
      new_controller = controller_class.alloc.initWithNibName(nil, bundle: nil)
      self.navigationController.pushViewController(new_controller, animated: true)
    rescue NameError
      alert = UIAlertView.alloc.init
      alert.message = "Unimplemented option #{controller_name}"
      alert.addButtonWithTitle "OK"
      alert.show
    end
  end

  def menu_items
    { :buildings => 'Buildings nearby', :search => 'Search a building',
      :tour => 'Take a tour', :food => 'Food venues nearby', :computers => 'Computer rooms nearby' }
  end
end
