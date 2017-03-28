require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "renders the new template" do
      get :new
      expect(response).to render_template('new')
    end

    it "assigns a new comment to @comment" do
      get :new
      expect(assigns(:comment)).to be_a_new(Comment)
    end
  end

  describe "POST #create" do
    context 'with valid attributes' do 
      before :each do
        @post = FactoryGirl.create(:post)
        @user = FactoryGirl.create(:user)
        @comment_params =  FactoryGirl.attributes_for(:comment, post_id: @post.id, user_id: @user.id )
      end

            let(:create) { post :create, :comment => @comment_params }

            it "creates new comment" do
                expect { create }.to change { Comment.count }.by(1)
            end

            it "increases the post comment count by 1" do
              expect { create }.to change { @post.comments.count }.by(1)
            end

            it "increases user comment count by 1" do
              expect { create }.to change { @user.comments.count }.by(1)
            end
    end

    context 'with invalid attributes' do
      before :each do
        @post = FactoryGirl.create(:post)
        @user = FactoryGirl.create(:user)
        @invalid_comment_params =  FactoryGirl.attributes_for(:invalid_comment)
      end

      let(:create) { post :create, :comment => @invalid_comment_params }

      it "does not create a new comment" do
        expect { create }.to change { Comment.count }.by(0)
      end
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      @comment = FactoryGirl.create(:comment)

      get :edit, id: @comment.id

      expect(response).to have_http_status(:success)
    end

    it "renders edit template" do
      @comment = FactoryGirl.create(:comment)

      get :edit, id: @comment.id

      expect(response).to render_template('edit')
    end

    it "assigns the correct comment to @comment" do
      @comment = FactoryGirl.create(:comment)

      get :edit, id: @comment.id

      expect(assigns(:comment)).to eq(@comment)
    end
  end

  describe '#update' do
    context 'with valid attributes' do 
      before :each do
        @comment =  FactoryGirl.create(:comment)
        @updated_comment_attributes = FactoryGirl.attributes_for(:comment, body: "New comment body")
      end

      let(:update) { patch :update, id: @comment, :comment => @updated_comment_attributes }
      login_user

      it "assigns the selected comment to @comment" do
        update
        expect(assigns(:comment)).to eq(@comment)
      end

      it "updates the comment's attributes" do
          update
          @comment.reload
          expect(@comment.body).to eq("New comment body")
      end

      it "redirects to the comment's post" do
        update
        expect(response).to redirect_to(@comment.post)
      end
    end

    context 'with invalid attributes' do
      before :each do
        @post = FactoryGirl.create(:post)
        @user = FactoryGirl.create(:user)
        @comment =  FactoryGirl.create(:comment)
        @invalid_comment_attributes = FactoryGirl.attributes_for(:invalid_comment)
      end

      let(:update) { patch :update, id: @comment, comment: @invalid_comment_attributes }
      login_user

      it "assigns the selected comment to @comment" do
        update
        expect(assigns(:comment)).to eq(@comment)
      end

      it "does not update the comment's attributes" do
        update
        @comment.reload
        expect(@comment).to have_attributes(FactoryGirl.attributes_for(:comment))
      end
    end
  end

  describe "DELETE #destroy" do
    before :each do 
      @comment = FactoryGirl.create(:comment)
    end

    it "assigns the requested comment to @comment" do
      delete :destroy, id: @comment
      expect(assigns(:comment)).to eq(@comment)
    end

    it "deletes the requested comment" do
      expect { delete :destroy, id: @comment }.to change(Comment, :count).by(-1)
    end

    it "redirects to the comment's post page" do
      delete :destroy, id: @comment
      expect(response).to redirect_to(post_path(@comment.post)) 
    end
  end

  describe '#comment_params' do
    @user = FactoryGirl.create(:user)
    @post = FactoryGirl.create(:post)

      it "should permit only whitelisted attributes" do
        params = {
            comment: {
              body: 'Comment Body',
              author: 'author',
              user: @user,
              post: @post
            }
        }
        
      should permit(:body, :author, :user_id, :post_id).
        for(:create, params: params).
        on(:comment)
      end
  end

end
