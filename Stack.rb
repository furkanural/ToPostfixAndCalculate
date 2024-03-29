class Stack
	def initialize(size)
		@size = size
		@store = Array.new(@size)
		@top = -1
	end

	def pop
		if empty?
			nil
		else
			popped = @store[@top]
			@top = @top.pred
			popped
		end
	end

	def push(element)
		if full? or element.nil?
			nil
		else
			@top = @top.succ
			@store[@top] = element
			self
		end
	end

	def size
		@size
	end

	def peek
		@store[@top]
	end

	def clear
		@top = -1
	end

	def full?
		@top == (@size -1)
	end

	def empty?
		@top == -1
	end
end