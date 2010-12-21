require 'test_helper'

class ScoresControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Score.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Score.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Score.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to score_url(assigns(:score))
  end
  
  def test_edit
    get :edit, :id => Score.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Score.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Score.first
    assert_template 'edit'
  end
  
  def test_update_valid
    Score.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Score.first
    assert_redirected_to score_url(assigns(:score))
  end
  
  def test_destroy
    score = Score.first
    delete :destroy, :id => score
    assert_redirected_to scores_url
    assert !Score.exists?(score.id)
  end
end
