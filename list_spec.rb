require "rspec"

require_relative "list"
require_relative "task"

describe List do
  let(:task_one) { mock(:task, :description => "Learn RSPEC") }

  let(:title)       { "This is our title" }
  let(:task_one)    { double(:task, :description => "Learn RSPEC", :complete => false) }
  let(:task_two)    { mock(:task, :description => "Master RSPEC") }
  let(:tasks)       { [task_one, task_two] }

  let(:list)        { List.new(title, tasks)}

  describe "#initialize" do
    it "creates an object with just title included" do 
      List.new(title).should be_an_instance_of List
    end

    it "fails when no title is included" do 
      expect { List.new() }.to raise_error(ArgumentError)
    end

    it "creates list object with two tasks" do 
      list.should be_an_instance_of List
    end
  end

  describe "#title" do
    it "returns the right title when calling attr_reader method" do
      list.title.should eq "This is our title"
    end
  end

  describe "#tasks" do
    it "returns the right tasks array when calling attr_reader method" do
      list.tasks.should eq tasks
    end
  end

  describe "add_task" do
    it "returns a list of three tasks" do
      list.add_task(task_one)
      list.tasks.should eq [task_one, task_two, task_one]
    end
  end

  describe "complete_task" do
    it "completes a task when called on a task in the list" do  
      task_two.should_receive(:complete!).with(no_args())
      list.complete_task(1)
    end  
  end

  describe "delete_task" do
    it "deletes task when that task is called" do 
      tasks.should_receive(:delete_at).with(1)
      list.delete_task(1)
    end
  end

  describe "completed_tasks" do
    it "shows all completed tasks" do
     tasks.each do |task|
      task.should_receive(:complete?).with(no_args())
     end  
    list.completed_tasks
    end
  end

  describe "incompleted_tasks" do
    it "shows incomplete tasks" do 
      tasks.each do |task|
        task.should_receive(:complete?).with(no_args())
      end
      list.incomplete_tasks
    end
  end
end
