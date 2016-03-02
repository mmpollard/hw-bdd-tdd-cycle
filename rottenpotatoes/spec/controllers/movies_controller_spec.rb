require 'rails_helper'

describe MoviesController do
  describe 'sad path' do
    before :each do
      movie=Movie.create!(:title => 'When Harry Met Sally', :rating => 'R', :release_date => '21-Jul-1989', :director => nil, :id => 2)
      Movie.should_receive(:find).with('2').and_return(movie)
    end
    it 'should select the Index template for rendering and generate a flash' do
      get 'director', :id => 2
      response.should redirect_to(movies_path)
      flash[:notice].should_not be_blank
    end
  end
  describe 'create' do
    it 'should create a new movie' do
      post :create, {:movie => {:title => 'Chocolat', :rating => 'PG-13', :release_date => '5-Jan-2001'}}
      response.should redirect_to(movies_path)
      flash[:notice].should_not be_blank
    end
  end
  describe 'destroy' do
    it 'should delete a movie' do
      movie = Movie.create(:title => 'Spaceballs', :id => 5)
      Movie.should_receive(:find).with('5').and_return(movie)
      movie.should_receive(:destroy)
      delete :destroy, :id => '5'
      response.should redirect_to(movies_path)
      flash[:notice].should_not be_blank
    end
  end
  describe 'update' do
    it 'should update the movie' do
      movie1 = {:title => 'Raiders of the Lost Ark', :rating => 'PG', :release_date => '12-Jun-1981'}
      movie2 = {:title => 'Chicken Run', :rating => 'G', :release_date => '21-Jun-2000'}
      movies = Movie.create movie1
      put :update, {:id => movies.to_param, :movie => movie2}
      response.should redirect_to(movie_path(movies))
    end
  end
  describe 'index' do
    it 'should display movies' do
      get :index
      response.should render_template('index')
    end
    it 'should sort by release_date' do
      get :index, {:sort => 'release_date', :ratings => 'R'}
      response.should redirect_to(:sort => 'release_date', :ratings => 'R')
    end
  end
  describe 'show' do
    it 'should show movies' do
      movie = Movie.create(:title => 'TestMovie', :id => 10)
      Movie.should_receive(:find).with('10').and_return(movie)
      get :show, :id => '10'
      response.should render_template('show')
    end
  end
 end