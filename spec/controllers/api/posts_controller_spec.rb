require 'spec_helper'

describe API::PostsController do
  before do
    @request.env['HTTP_ACCEPT'] = 'application/json' # use this for json format
    @post = Post.make!
  end

  describe 'GET index' do
    it 'return success' do
      get :index
      expect(response).to be_success
      expect(response).to_not be_nil
    end
  end

  describe 'GET show' do
    it 'return success' do
      get :show, id: @post.to_param
      expect(response).to be_success
      expect(json).to have_key('post')
    end

    it 'return error for not found' do
      get :show, id: @post.id+1
      expect(response.status).to eql 404
      expect(json).to have_key('errors')
      expect(json).to eql({"errors" => "not_found"})
    end
  end

  describe 'POST create' do
    let(:valid_attributes) { {title: 'Title of the post', link: 'http://google.com'} }
    let(:invalid_attributes) { {link: 'http://google.com'} }

    it 'with valid attributes' do
      post :create, post: valid_attributes
      expect(response.status).to eql 201
      expect(Post.last.title).to eql 'Title of the post'
    end

    it 'with invalid attributes' do
      post :create, post: invalid_attributes
      expect(response.status).to eql 422
      expect(json).to have_key('errors')
      expect(json).to eql({"errors" => {"title"=>["não pode ficar em branco"]}})
    end
  end

  describe 'PATCH update' do
    let(:valid_changes) { {title: 'Title of the post modified'} }
    let(:invalid_changes) { {title: ''} }

    it 'with valid changes' do
      patch :update, id: @post.to_param, post: valid_changes
      expect(response.status).to eql 204
      @post.reload
      expect(@post.title).to eql 'Title of the post modified'
    end

    it 'with invalid attributes' do
      patch :update, id: @post.to_param, post: invalid_changes
      expect(response.status).to eql 422
      expect(json).to have_key('errors')
      expect(json).to eql({"errors" => {"title"=>["não pode ficar em branco"]}})
    end

    it 'with invalid post id' do
      patch :update, id: @post.id+1, post: valid_changes
      expect(response.status).to eql 404
      expect(json).to have_key('errors')
      expect(json).to eql({"errors" => "not_found"})
    end
  end

  describe 'DELETE destroy' do
    it 'with valid post id' do
      delete :destroy, id: @post.to_param
      expect(response.status).to eql 204
    end

    it 'with invalid post id' do
      delete :destroy, id: @post.id+1
      expect(response.status).to eql 404
    end
  end
end
