require 'rails_helper'

RSpec.describe UsersController, type: :controller do
	describe '#index' do
		it "responds successfully with an HTTP 200 status code" do
			get :index
			expect(response).to be_success
			expect(response).to have_http_status(200)
		end

		it "renders the index template" do
			get :index
			expect(response).to render_template('index')
		end

		it "assigns all users as @users" do
			user_1, user_2 = FactoryGirl.create(:user), FactoryGirl.create(:user) 
			get :index
			expect(assigns(:users)).to match_array([user_1, user_2])
		end
	end

	describe '#new' do
		it "responds successfully with an HTTP 200 status code" do
			get :new
			expect(response).to have_http_status(200)
		end

		it "renders the new template" do
			get :new
			expect(response).to render_template('new')
		end

		it "assigns new user as @user" do
			get :new
			expect(assigns(:user)).to be_a_new(User)
		end
	end

	describe '#show' do
		before :each do
			@user = create(:user)
		end

 		it "responds successfuly with an HTTP 200 status code" do
			get :show, id: @user.id 
			expect(response).to have_http_status(200)
		end

		it "render renders the show template" do
			get :show, id: @user.id 
			expect(response).to render_template('show')
		end

		it "assigns the requested user to @user" do
			get :show, id: @user.id
			expect(assigns(:user)).to eq(@user)
		end
	end

	describe '#create' do
		context "with valid attributes" do
			let(:user_params) { FactoryGirl.attributes_for(:user) }

			it "creates a new user" do
				expect { post :create, :user => user_params }.to change(User, :count).by(1)
			end

			it "redirects to user page" do
				post :create, :user => user_params
				expect(response).to redirect_to(User.last)
			end
		end

		context "with invalid attributes" do
			let(:invalid_user_params) { FactoryGirl.attributes_for(:invalid_user) }

			it "does not create a new user" do
				expect { post :create, :user => invalid_user_params }.to_not change(User, :count)
			end

			it "renders the new template" do
				post :create, :user => invalid_user_params
				expect(response).to render_template('new')
			end
		end
	end

	describe '#edit' do
		let(:user) { FactoryGirl.create(:user) }

		it "responds successfully with an HTTP 200 status code" do
			get :edit, id: user
			expect(response).to have_http_status(200)
		end

		it "renders the edit template" do
			get :edit, id: user
			expect(response).to render_template('edit')
		end

		it "assigns the requested user to @user" do
			get :edit, id: user
			expect(assigns(:user)).to eq(user)
		end
	end

	describe '#update' do
		before :each do
			@user = FactoryGirl.create(:user)
			@updated_attributes = FactoryGirl.attributes_for(:user, first_name: "new first name", email: "new_email@example.com")
			@invalid_attributes = FactoryGirl.attributes_for(:invalid_user)
		end

		context "with valid attributes" do
			it "assigns the requested user to @user" do
				patch :update, id: @user, :user => @updated_attributes
				expect(assigns(:user)).to eq(@user)
			end

			it "updates user attributes" do
				patch :update, id: @user, :user => @updated_attributes
				@user.reload
				expect(@user.first_name).to eq("new first name")
				expect(@user.email).to eq("new_email@example.com")
				expect(@user.password).to eq(@updated_attributes[:password])
			end

			it "redirects to user page" do
				patch :update, id: @user, :user => @updated_attributes
				expect(response).to redirect_to(user_url(@user))
			end
		end

		context "with invalid attributes" do
			it "does not update user" do
				@user = FactoryGirl.create(:user, first_name: "Ben", last_name: "Kinney")

				expect(@user.first_name).to eq("Ben")
				expect(@user.last_name).to eq("Kinney")

				patch :update, id: @user, :user => @invalid_attributes
				@user.reload

				expect(@user.first_name).to eq("Ben")
				expect(@user.last_name).to eq("Kinney")
			end

			it "renders the edit template" do
				patch :update, id: @user, :user => @invalid_attributes
				expect(response).to render_template('edit')
			end
		end
	end

	describe '#destroy' do
		before :each do 
			@user = FactoryGirl.create(:user)
  		end

		it "assigns the requested user to @user" do
			delete :destroy, id: @user
			expect(assigns(:user)).to eq(@user)
		end

		it "deletes the requested user" do
			expect { delete :destroy, id: @user }.to change(User, :count).by(-1)
		end

		it "redirects to the user index page" do
			delete :destroy, id: @user
			expect(response).to redirect_to(users_url) 
		end
	end

	describe '#user_params' do
		it "should permit only whitelisted attributes" do
    		params = {
		      	user: {
			        first_name: 'Ben',
			        last_name: 'Kinney',
			        email: 'ben@benkinney.com',
			        password: 'password',
			        about_me: 'Hey this is my about me'
	      		}
    		}
    		
	    should permit(:first_name, :last_name, :email, :password, :about_me).
	    	for(:create, params: params).
	    	on(:user)
	    end
	end

end

