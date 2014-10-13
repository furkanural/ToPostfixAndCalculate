require_relative './Stack'

class ToPostfix
	def initialize(infix)
		@input = infix
		@postfix = ""
		@opStk = Stack.new(@input.length)
		@sumStk = Stack.new(@input.length)
	end

	def ConvertToPostfix
		
		for i in 0..@input.length-1
			temp = @input[i]
			if temp == ' '
				next
			end
			if temp == '+' or temp == '-' or temp == '*' or temp == '/'
				if @opStk.empty?
					@opStk.push(temp)
				else
					symbolTop = @opStk.peek
					while (@opStk.empty? == false) and (level(symbolTop) >= level(temp))
						@postfix = @postfix + " " + @opStk.pop
						if @opStk.empty? == false
							symbolTop = @opStk.peek
						end
					end
					@opStk.push(temp)
				end
			else
				@postfix = @postfix + " " + temp
				
			end
		end
		while @opStk.empty? == false
			@postfix = @postfix + " " + @opStk.pop
		end
		return @postfix
	end

	def Calculate

		for i in 0..@postfix.length-1
			temp = @postfix[i]
			if temp == ' '
				next
			end
			if temp == '+' or temp == '-' or temp == '*' or temp == '/' 
				case temp
				when '+'
					@sumStk.push(@sumStk.pop + @sumStk.pop)
				when '-'
					@sumStk.push(-@sumStk.pop + @sumStk.pop)
				when '/'
					@sumStk.push(1 / @sumStk.pop * @sumStk.pop)
				when '*'
					@sumStk.push(@sumStk.pop * @sumStk.pop)
				end
			else
				@sumStk.push(temp.to_f)
			end
		end
		return @sumStk.pop
	end

	private

	def level(opr)
		case opr
		when "+","-"
			1
		when "*","/"
			2
			end
		end
end