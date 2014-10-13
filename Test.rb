require_relative './ToPostfix'

@pst = ToPostfix.new(ARGV[0])
puts @pst.ConvertToPostfix
puts @pst.Calculate