require File.dirname(__FILE__) + '/../spec_helper'

describe ScoresController, "showing a score" do
#  integrate_views
#  fixtures :menu_items

# not finished
# I'm afraid without some guidance testing like this is still a bridge too far for me



  
  it "show a score if it belong to the current user"
    User.stub!(:find).and_return(@user = mock_model(User, :id => 1))
    Score.stub!(:find).and_return(@score = mock_model(Score, :user_id => 1))
    MenuItem.any_instance.stubs(:valid?).returns(true)
    get 'show', :id => 1
    assigns[:menu_item].should_not be_new_record
    flash[:notice].should_not be_nil
    response.should redirect_to(menu_items_path)
  end
end

=begin
require File.dirname(__FILE__) + '/../spec_helper'

describe MenuItemsController, "new with a valid menu item" do
  before(:each) do
    MenuItem.stub!(:new).and_return(@menu_item = mock_model(MenuItem, :save=>true))
  end
  
  def do_create
    post :create, :menu_item=>{:name=>"value"}
  end
  
  it "should create the menu item" do
    MenuItem.should_receive(:new).with("name"=>"value").and_return(@menu_item)
    do_create
  end
  
  it "should save the menu item" do
    @menu_item.should_receive(:save).and_return(true)
    do_create
  end
  
  it "should be redirect" do
    do_create
    response.should be_redirect
  end
  
  it "should assign menu_item" do
    do_create
    assigns(:menu_item).should == @menu_item
  end
  
  it "should redirect to the index path" do
    do_create
    response.should redirect_to(menu_items_url)
  end
end

describe MenuItemsController, "new with an invalid menu item" do
  before(:each) do
    MenuItem.stub!(:new).and_return(@menu_item = mock_model(MenuItem, :save=>false))
  end
  def do_create
    post :create, :menu_item=>{:name=>"value"}
  end
  
  it "should create the menu item" do
    MenuItem.should_receive(:new).with("name"=>"value").and_return(@menu_item)
    do_create
  end
  
  it "should save the menu item" do
    @menu_item.should_receive(:save).and_return(false)
    do_create
  end
  
  it "should be success" do
    do_create
    response.should be_success
  end
  
  it "should assign menu_item" do
    do_create
    assigns(:menu_item).should == @menu_item
  end
  
  it "should re-render the new form" do
    do_create
    response.should render_template("new")
  end
end
=end
