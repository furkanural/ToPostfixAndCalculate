require_relative './Stack'

class ToPostfix
	def initialize(infix)
		@input = infix
		@postfix = ""
		@opStk = Stack.new(@input.length)
		@sumStk = Stack.new(@input.length)
	end

	def ConvertToPostfix
		i = 0
		while i<@input.length
			temp = @input[i]
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
			elsif integer? temp
				@postfix = @postfix + " " + temp
				while true
					if i == @input.length-1
						break
					end
					if integer? @input[i+1]
						i = i+1
						@postfix = @postfix + @input[i]
					else
						break
					end
				end
			end
			i = i+1
		end

		while @opStk.empty? == false
			@postfix = @postfix + " " + @opStk.pop
		end

		
		return @postfix
	end

	def Calculate
		i = 0
		while i<@postfix.length
			temp = @postfix[i]
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
			elsif integer? temp
				num = temp
				while true
					if i == @postfix.length-1
						break
					end
					if integer? @postfix[i+1]
						i = i+1
						num = num + @postfix[i]
					else
						break
					end
				end
				@sumStk.push(num.to_f)
			end
			i = i+1
		end
		return @sumStk.pop
	end

	private

	def integer?(str)
  		/\A[+-]?\d+\z/ === str
	end

	def level(opr)
		case opr
		when "+","-"
			1
		when "*","/"
			2
		end
	end
end