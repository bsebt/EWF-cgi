note
	description: "[
				application execution
			]"
	date: "$Date: 2016-10-21 10:45:18 -0700 (Fri, 21 Oct 2016) $"
	revision: "$Revision: 99331 $"

class
	FEEZBUZZ_EXECUTION


inherit
	WSF_MESSAGE_EXECUTION

create
	make

feature {NONE} -- Initialization

	message: WSF_HTML_PAGE_RESPONSE
			-- Computed response message.
		local
			s: STRING_8
			i: INTEGER
			input: INTEGER_32
		do
			create Result.make
			create s.make_empty
			Result.set_title ("EWF FizzBuzz!")
			s.append ("[
							<form action="/" method="POST">
								<p>Hello, what is the highest number?</p>
								<input type="text" name="limit"/>
							<input type="submit" value="Validate"/>
							</form>
						]" + "<br>")
			if attached request.string_item ("limit") as a_limit then
				--| If yes, say hello world #name

				if not a_limit.is_empty then
					input := a_limit.to_integer_32
					if input <= 0 then
						s.append ("limit should be greater than zero")
					else
						from
							i := 1
						until
							i > input
						loop
						if (i \\ 3) = 0 and (i \\ 5) = 0 then
							s.append ("FizzBuzz" + "<br>")
						elseif (i \\ 3) = 0 then
							s.append ("Fizz" + "<br>")
						elseif (i \\ 5) = 0 then
							s.append ("Buzz" + "<br>")
						else
							s.append (i.out + "<br>")
						end
						i := i + 1
						end
					end
				else
				s.append ("limit should be greater than zero")
				end
			end
			Result.set_body (s)
		end
end
