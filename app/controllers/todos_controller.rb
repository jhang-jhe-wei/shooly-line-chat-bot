class TodosController < ApplicationController
  before_action :debug_info
  before_action :set_todo, only: [:show, :edit, :update, :destroy]

  # GET /todos
  # GET /todos.json
  def index
    @todos = Todo.all
  end

  def test0
    @todos = [
      {
        id: 1,
        name: "ruby",
      },
      {
        id: 2,
        name: "rails",
      },
      {
        id: 3,
        name: "kamiflex",
      },
    ]

    json = Kamiflex.build(self) do
      bubble do
        body do
          horizontal_box do
            text "🍔", flex: 0, action: message_action("/")
            text "Todos"
            text "🆕", align: "end", action: uri_action(new_todo_path)
          end
          separator
          if @todos.present?
            vertical_box margin: "lg" do
              horizontal_box @todos, margin: "lg" do |todo|
                text todo[:name], action: message_action("/todos/#{todo[:id]}")
                text "❌", align: "end", action: message_action("DELETE /todos/#{todo[:id]}")
              end
            end
          else
            text "no contents yet", margin: "lg"
          end
        end
      end
    end

    puts json
  end

  # GET /todos/1
  # GET /todos/1.json
  def show
  end

  # GET /todos/new
  def new
    @todo = Todo.new
  end

  # GET /todos/1/edit
  def edit
  end

  # POST /todos
  # POST /todos.json
  def create
    @todo = Todo.new(todo_params)

    respond_to do |format|
      if @todo.save
        @todos = Todo.all
        format.html { redirect_to @todo, notice: "Todo was successfully created." }
        format.json { render :show, status: :created, location: @todo }
        format.line { render :index }
      else
        format.html { render :new }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
        format.line { render json: flex_text(@todo.errors.to_s) }
      end
    end
  end

  # PATCH/PUT /todos/1
  # PATCH/PUT /todos/1.json
  def update
    respond_to do |format|
      if @todo.update(todo_params)
        @todos = Todo.all
        format.html { redirect_to @todo, notice: "Todo was successfully updated." }
        format.json { render :show, status: :ok, location: @todo }
        format.line { render :index }
      else
        format.html { render :edit }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
        format.line { render json: flex_text(@todo.errors.to_s) }
      end
    end
  end

  # DELETE /todos/1
  # DELETE /todos/1.json
  def destroy
    @todo.destroy
    @todos = Todo.all
    respond_to do |format|
      format.html { redirect_to todos_url, notice: "Todo was successfully destroyed." }
      format.json { head :no_content }
      format.line { render :index }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_todo
    @todo = Todo.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def todo_params
    params.require(:todo).permit(:name, :desc)
  end

  def debug_info
    puts ""
    puts "=== kamigo debug info start ==="
    puts "platform_type: #{params[:platform_type]}"
    puts "source_type: #{params[:source_type]}"
    puts "source_group_id: #{params[:source_group_id]}"
    puts "source_user_id: #{params[:source_user_id]}"
    puts "=== kamigo debug info end ==="
    puts ""
  end
end
