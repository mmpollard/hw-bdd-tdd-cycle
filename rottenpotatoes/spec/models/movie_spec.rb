require 'rails_helper'

describe Movie do
    describe 'similar director search' do
        it 'should find similar movies by director' do
            Movie.director('Max')
        end
    end
end