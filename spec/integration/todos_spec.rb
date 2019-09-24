require 'swagger_helper'

describe 'Todos API' do

  path '/todos' do

    post 'Creates a todo' do
      tags 'Todos'
      consumes 'application/json', 'application/xml'
      parameter name: :todo, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string }
        },
        required: [ 'title' ]
      }

      response '201', 'todo created' do
        let(:todo) { { title: 'foo', content: 'bar' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:todo) { { title: 'foo' } }
        run_test!
      end
    end
  end

  path '/todos/{id}' do

    get 'Retrieves a todo' do
      tags 'Todos'
      produces 'application/json', 'application/xml'
      parameter name: :id, :in => :path, :type => :string

      response '200', 'todo found' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            title: { type: :string }
          },
          required: [ 'id', 'title' ]

        let(:id) { Todo.create(title: 'foo').id }
        run_test!
      end

      response '404', 'todo not found' do
        let(:id) { 'invalid' }
        run_test!
      end

      response '406', 'unsupported accept header' do
        let(:'Accept') { 'application/foo' }
        run_test!
      end
    end
  end
end