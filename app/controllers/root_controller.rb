class RootController < UIViewController
  def viewDidLoad
    super

    @menu_items = { :buildings => 'Buildings nearby', :search => 'Search a building',
                    :tour => 'Take a tour', :food => 'Food venues nearby',
                    :computers => 'Computer rooms nearby' }

    @table = UITableView.alloc.initWithFrame(self.view.bounds, style:UITableViewStyleGrouped)
    @table.dataSource = @table.delegate = self
    @table.backgroundView = nil
    @table.backgroundColor = "#EEEDE4".to_color
    @table.separatorColor = "#9C9C9C".to_color

    self.view.addSubview @table

    back_button = UIBarButtonItem.alloc.initWithTitle("Back", style:UIBarButtonItemStylePlain, target:nil, action:nil)
    self.navigationItem.backBarButtonItem = back_button
    self.title = "Du Nord Map"
  end

  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    @reuseIdentifier ||= "CELL_IDENTIFIER"

    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
      UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:@reuseIdentifier)
    end

    cell.textLabel.text = @menu_items.values[indexPath.row]
    cell.textLabel.textColor = "#7F7F7F".to_color
    cell.textLabel.font = UIFont.fontWithName("Helvetica-Bold", size: 14)
    cell.imageView.image = UIImage.imageNamed("icon_#{@menu_items.keys[indexPath.row]}.png")
    cell.contentView.backgroundColor = "#F4F5F6".to_color
    cell.accessoryView = UIImageView.alloc.initWithImage(UIImage.imageNamed("arrow.png"))
    cell
  end

  def tableView(tableView, numberOfRowsInSection:section)
    @menu_items.size
  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    
    self.send("open_#{@menu_items.keys[indexPath.row]}")
  end

  def open_buildings
    new_controller = BuildingsController.alloc.initWithNibName(nil, bundle: nil)
    self.navigationController.pushViewController(new_controller, animated: true)
  end

  def open_search
    alert = UIAlertView.alloc.init
    alert.message = "Unimplemented option"
    alert.addButtonWithTitle "OK"
    alert.show
  end

  def open_tour
    alert = UIAlertView.alloc.init
    alert.message = "Unimplemented option"
    alert.addButtonWithTitle "OK"
    alert.show
  end

  def open_food
    alert = UIAlertView.alloc.init
    alert.message = "Unimplemented option"
    alert.addButtonWithTitle "OK"
    alert.show
  end

  def open_computers
    alert = UIAlertView.alloc.init
    alert.message = "Unimplemented option"
    alert.addButtonWithTitle "OK"
    alert.show
  end
end
