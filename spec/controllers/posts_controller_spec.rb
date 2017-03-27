require 'rails_helper'

RSpec.describe PostsController, type: :controller do
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

		it "assigns all posts as @posts" do
			post_1, post_2 = FactoryGirl.create(:post), FactoryGirl.create(:post) 
			get :index
			expect(assigns(:posts)).to match_array([post_1, post_2])
		end
	end

	describe '#new' do
		login_user

		it "responds successfully with an HTTP 200 status code" do
			get :new
			expect(response).to have_http_status(200)
		end

		it "renders the new template" do
			get :new
			expect(response).to render_template('new')
		end

		it "assigns new post as @post" do
			get :new
			expect(assigns(:post)).to be_a_new(Post)
		end
	end

	describe '#show' do
		let(:post) { FactoryGirl.create(:post) }

 		it "responds successfuly with an HTTP 200 status code" do
			get :show, id: post
			expect(response).to have_http_status(200)
		end

		it "render renders the show template" do
			get :show, id: post
			expect(response).to render_template('show')
		end

		it "assigns the requested post to @post" do
			get :show, id: post
			expect(assigns(:post)).to eq(post)
		end
	end

	describe '#create' do
		context "with valid attributes" do
			let(:post_params) { FactoryGirl.attributes_for(:post) }
			login_user

			it "creates a new post" do
				expect { post :create, :post => post_params }.to change(Post, :count).by(1)
			end

			it "should increase the user's post count by one" do
				expect { post :create, :post => post_params }.to change(subject.current_user.posts, :count).by(1)
			end

			it "redirects to root page" do
				post :create, :post => post_params
				expect(response).to redirect_to(root_path)
			end
		end

		context "with invalid attributes" do
			let(:user) { FactoryGirl.create(:user) }
			let(:invalid_post_params) { FactoryGirl.attributes_for(:invalid_post) }
			login_user

			it "does not create a new post" do
				expect { post :create, :post => invalid_post_params }.to_not change(Post, :count)
			end

			it "renders the new template" do
				post :create, :post => invalid_post_params
				expect(response).to render_template('new')
			end
		end
	end

	describe '#edit' do
		let(:post) { FactoryGirl.create(:post) }
		login_user

		it "responds successfully with an HTTP 200 status code" do
			get :edit, id: post
			expect(response).to have_http_status(200)
		end

		it "renders the edit template" do
			get :edit, id: post
			expect(response).to render_template('edit')
		end

		it "assigns the requested post to @post" do
			get :edit, id: post
			expect(assigns(:post)).to eq(post)
		end
	end

	describe '#update' do
		let(:post) { FactoryGirl.create(:post) }
		let(:updated_attributes) { FactoryGirl.attributes_for(:post, title: "New Title") }
		let(:invalid_updated_attributes) { FactoryGirl.attributes_for(:invalid_post) }
		login_user

		context "with valid attributes" do
			it "assigns the requested post to @post" do
				patch :update, id: post, :post => updated_attributes
				expect(assigns(:post)).to eq(post)
			end

			it "updates post attributes" do
				patch :update, id: post, :post => updated_attributes
				post.reload
				expect(post.title).to eq("New Title")
			end

			it "redirects to post page" do
				patch :update, id: post, :post => updated_attributes
				expect(response).to redirect_to(post_url(post))
			end
		end

		context "with invalid attributes" do
			it "does not update post" do
				patch :update, id: post, :post => invalid_updated_attributes
				post.reload
				expect(post.title).to eq("MyString")
			end

			it "renders the edit template" do
				patch :update, id: post, :post => invalid_updated_attributes
				expect(response).to render_template('edit')
			end
		end
	end

	describe '#destroy' do
		before :each do 
			@post = FactoryGirl.create(:post)
  		end
  		login_user

		it "assigns the requested post to @post" do
			delete :destroy, id: @post
			expect(assigns(:post)).to eq(@post)
		end

		it "deletes the requested post" do
			expect { delete :destroy, id: @post }.to change(Post, :count).by(-1)
		end

		it "redirects to the post's user page" do
			delete :destroy, id: @post
			expect(response).to redirect_to(user_path(@post.user)) 
		end
	end


	describe '#post_params' do
		let(:user) { FactoryGirl.create(:user) }
		login_user

   		it "should permit only whitelisted attributes" do
    		params = {
		      	post: {
			        title: 'Title',
			        body: 'Body',
			        author: 'author',
			        user_id: 1,
	      		}
    		}
    		
	    should permit(:title, :body, :author, :user_id).
	    	for(:create, params: params).
	    	on(:post)
	    end
	end
end
