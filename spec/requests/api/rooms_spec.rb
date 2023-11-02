require 'swagger_helper'

RSpec.describe 'Rooms API', type: :request do
  path '/rooms' do
    get 'Retrieves a list of rooms' do
      tags 'Rooms'
      produces 'application/json'
      response '200', 'successful' do
        run_test!
      end
    end

    post 'Creates a room' do
      tags 'Rooms'
      consumes 'application/json'
      parameter name: :room, in: :body, schema: { '$ref' => '#/definitions/room' }

      response '201', 'room created' do
        let(:room) { { description: 'A cozy room', capacity: 2, price: 100.00 } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:room) { { description: nil, capacity: 2, price: 100.00 } }
        run_test!
      end
    end
  end

  path '/rooms/{id}' do
    get 'Retrieves a room' do
      tags 'Rooms'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response '200', 'successful' do
        let(:id) { Room.create(description: 'A nice room', capacity: 2, price: 100.00).id }
        run_test!
      end

      response '404', 'not found' do
        let(:id) { 'nonexistent_id' }
        run_test!
      end
    end

    put 'Updates a room' do
      tags 'Rooms'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: :room, in: :body, schema: { '$ref' => '#/definitions/room' }

      response '200', 'room updated' do
        let(:id) { Room.create(description: 'A nice room', capacity: 2, price: 100.00).id }
        let(:room) { { description: 'Updated room' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:id) { Room.create(description: 'A nice room', capacity: 2, price: 100.00).id }
        let(:room) { { description: nil } }
        run_test!
      end
    end

    delete 'Deletes a room' do
      tags 'Rooms'
      parameter name: :id, in: :path, type: :string

      response '204', 'no content' do
        let(:id) { Room.create(description: 'A nice room', capacity: 2, price: 100.00).id }
        run_test!
      end

      response '404', 'not found' do
        let(:id) { 'nonexistent_id' }
        run_test!
      end
    end
  end
end
