require 'swagger_helper'

describe 'Reservations API' do
  path '/reservations' do
    post 'Creates a reservation' do
      tags 'Reservations'
      consumes 'application/json'
      parameter name: :reservation, in: :body, schema: {
        type: :object,
        properties: {
          user_id: { type: :integer },
          room_id: { type: :integer },
          check_in: { type: :string },
          check_out: { type: :string }
        },
        required: ['user_id', 'room_id', 'check_in', 'check_out']
      }

      response '201', 'reservation created' do
        let(:reservation) { { user_id: 1, room_id: 1, check_in: '2023-01-01', check_out: '2023-01-05' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:reservation) { { user_id: 2 } }
        run_test!
      end
    end
  end

  path '/reservations/{id}' do
    parameter name: :id, in: :path, type: :integer

    get 'Retrieves a reservation' do
      tags 'Reservations'
      produces 'application/json'

      response '200', 'reservation found' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 user_id: { type: :integer },
                 room_id: { type: :integer },
                 check_in: { type: :string },
                 check_out: { type: :string }
               }

        let(:id) { create(:reservation).id }
        run_test!
      end

      response '404', 'reservation not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end

    put 'Updates a reservation' do
      tags 'Reservations'
      consumes 'application/json'
      parameter name: :reservation, in: :body, schema: {
        type: :object,
        properties: {
          user_id: { type: :integer },
          room_id: { type: :integer },
          check_in: { type: :string },
          check_out: { type: :string }
        },
        required: ['user_id', 'room_id', 'check_in', 'check_out']
      }

      response '200', 'reservation updated' do
        let(:id) { create(:reservation).id }
        let(:reservation) { { user_id: 2, room_id: 2, check_in: '2023-02-01', check_out: '2023-02-05' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:id) { create(:reservation).id }
        let(:reservation) { { user_id: 2 } }
        run_test!
      end

      response '404', 'reservation not found' do
        let(:id) { 'invalid' }
        let(:reservation) { { user_id: 2, room_id: 2, check_in: '2023-02-01', check_out: '2023-02-05' } }
        run_test!
      end
    end

    delete 'Deletes a reservation' do
      tags 'Reservations'

      response '204', 'reservation deleted' do
        let(:id) { create(:reservation).id }
        run_test!
      end

      response '404', 'reservation not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end
