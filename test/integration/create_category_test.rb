require 'test_helper'

class CreateCategoryTest < ActionDispatch::IntegrationTest
  setup do
    @admin_user = User.create(username:"last",email:"last@last.com",password:"rad", admin:true)
    sign_in_as(@admin_user)
  end

  test "get new category form and creating the category " do
    get "/categories/new"
    assert_response :success
    assert_difference "Category.count", 1 do
      post categories_path, params: {category: {name: "Health"} }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "Health", response.body
  end

  test "get new category form and reject invalid submission " do
    get "/categories/new"
    assert_response :success
    assert_no_difference "Category.count" do
      post categories_path, params: {category: {name: " "} }
    end
    assert_select 'div.alert'
    assert_select 'h6.alert-heading'
  end
end
