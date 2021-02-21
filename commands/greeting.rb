class Greeting < Command
  def call
    "Hello #{@params.first}\\!"
  end
end
