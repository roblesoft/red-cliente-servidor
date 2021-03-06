require 'tk'
require 'socket'
require 'json'
require_relative 'Cliet'
require_relative 'colorize'

class Nodo
    def initialize port_server
        @server_socket = TCPServer.open port_server
        @result = ' '
		@connection_details = Hash.new
		@connection_info = Hash.new
		@connected_clients = Hash.new
		@connection_info[:server] = @server_socket
		@connection_info[:clients] = @connected_clients
		@root = TkRoot.new
		@self = self
		@names = []
		@ips = []
		@cpus = []
		@ranks = []
		@index = 0
		@percent = 0
		@percent += 1
		@ranking = Hash.new
		@hidden_window = false
		print "#{'#' * @percent} #{@percent*10}% Started server node....\r".dark_purple.bold
		sleep 0.5
		print  ("\e[K") # Delete current line
        run
    end

    def run_server
		myself = @self
		@percent += 1
		print "#{'#' * @percent} #{@percent*10}% Started server node....\r".dark_purple.bold
		sleep 0.5
		print  ("\e[K") # Delete current line
		content = Tk::Tile::Frame.new(@root) { padding "3 3 12 12" }
		@names = @connection_details.map {|item| item['name'] }
		@ips = @connection_details.map {|item| item['ip'] }
		@rams_free = @connection_details.map {|item| item['ram_free']} 
		@cpus = @connection_details.map {|item| item['cpu']}
		@ranks = @connection_details.map {|item| item['cpu']}

		@cpus_percent = @connection_details.map {|item| item['cpu_percent']}
		@rams = @connection_details.map {|item| item['ram']}
		@memory = @connection_details.map {|item| item['memory']}

		$names_list_variable = TkVariable.new @names
		$ips_list_variable = TkVariable.new @ips
		$rams_free_list_variable = TkVariable.new @rams
		$cpus_list_variable = TkVariable.new @cpus
		$ranks_list_variable = TkVariable.new @rank
		$rams_list_variable = TkVariable.new @rams
		$cpu_percent_variable = TkVariable.new @cpus_percent
		$memory_free_variable = TkVariable.new @memory

		@percent += 1
		print "#{'#' * @percent} #{@percent*10}% Started server node....\r".dark_purple.bold
		sleep 0.5
		print  ("\e[K") # Delete current line
		names_list = TkListbox.new(content) do 
			listvariable $names_list_variable 
			width 10 
		end
		ips_list = TkListbox.new(content) do 
			listvariable $ips_list_variable 
			width 15 
		end
		ram_free_list = TkListbox.new(content)  do 
			listvariable $rams_free_list_variable 
			width 10 
		end
		cpu_list = TkListbox.new(content)  do
			listvariable $cpus_list_variable
			width 10 
		end
		@percent += 1
		print "#{'#' * @percent} #{@percent*10}% Started server node....\r".dark_purple.bold
		sleep 0.5
		print  ("\e[K") # Delete current line
		rank_list = TkListbox.new(content)  do 
			listvariable $ranks_list_variable 
			width 10 
		end
		ram_list = TkListbox.new(content)  do 
			listvariable $rams_list_variable 
			width 10 
		end
		cpu_percent_list = TkListbox.new(content)  do 
			listvariable $cpu_percent_variable 
			width 10 
		end
		memory_list = TkListbox.new(content)  do 
			listvariable $memory_free_variable
			width 10 
		end
		@percent += 1
		print "#{'#' * @percent} #{@percent*10}% Started server node....\r".dark_purple.bold
		sleep 0.5
		print  ("\e[K") # Delete current line

		namelbl = Tk::Tile::Label.new(content) {text 'Nombre'}
		iplbl = Tk::Tile::Label.new(content) {text 'Ip'}
		ramfreelbl = Tk::Tile::Label.new(content) {text 'Ram libre'}
		cpulbl = Tk::Tile::Label.new(content) {text 'Cpu'}
		ranklbl = Tk::Tile::Label.new(content) {text 'Ranking'}
		ramlbl = Tk::Tile::Label.new(content) {text 'Ram'}
		cpupercentlbl = Tk::Tile::Label.new(content) {text '% CPU libre'}
		memorylbl = Tk::Tile::Label.new(content) {text 'Memoria'}
		close_conection = TkButton.new(content) do 
			text "Cerrar"
			command(proc {myself.close_interface}) 
			width 10
		end

		content.grid column: 0, row: 0, sticky: 'nsew'
		namelbl.grid column: 1, row: 1
		iplbl.grid column: 2, row: 1
		ramlbl.grid column: 3, row: 1
		cpulbl.grid column: 4, row: 1
		memorylbl.grid column: 5, row: 1
		cpupercentlbl.grid column: 6, row: 1
		ramfreelbl.grid column: 7, row: 1
		ranklbl.grid column: 8, row: 1
		close_conection.grid column: 8, row: 3, pady: 10
		@percent += 1
		sleep 0.5
		print "#{'#' * @percent} #{@percent*10}% Started server node....\r".dark_purple.bold

		names_list.grid column: 1, row: 2
		ips_list.grid column: 2, row: 2
		ram_list.grid column: 3, row: 2
		cpu_list.grid column: 4, row: 2
		memory_list.grid column: 5, row: 2
		cpu_percent_list.grid column: 6, row: 2
		ram_free_list.grid column: 7, row: 2
		rank_list.grid column: 8, row: 2

		@percent += 1
		print "#{'#' * @percent} #{@percent*10}% Started server node....\r".dark_purple.bold
		sleep 0.5
		print  ("\e[K") # Delete current line

		def create_data name, ips, cpus, rams_free, ranks, rams, cpus_percent, memory
			$names_list_variable.value = name
			$ips_list_variable.value = ips
			$cpus_list_variable.value = cpus
			$rams_free_list_variable.value = rams_free
			$ranks_list_variable.value = ranks
			$rams_list_variable.value = rams
			$cpu_percent_variable.value = cpus_percent
			$memory_free_variable.value = memory
		end

		@percent += 1
		print "#{'#' * @percent} #{@percent*10}% Started server node....\r".dark_purple.bold
		sleep 0.5
		print  ("\e[K") # Delete current line

		@percent += 1
		print "#{'#' * @percent} #{@percent*10}% Started server node....\r".dark_purple.bold
		sleep 0.1
		print  ("\e[K") # Delete current line

		@percent += 1
		print "#{'#' * @percent} #{@percent*10}% Started server node....\r".dark_purple.bold
		sleep 0.1
		print  ("\e[K") # Delete current line
		
		puts "Start server node".dark_purple.bold
		
		def update_data index, client, remote_id
			loop do 
				sleep 1
				response = JSON.parse(client.gets)
				unless response['n'].nil?
					Thread.start do
						system("python3 ./PageRank/main.py")
					end
				else
					response['ip'] = remote_id
					@connection_details[index] = response

					@names = @connection_details.map {|item, value| value['name'] }
					@ips = @connection_details.map {|item, value| value['ip'] }
					@rams_free = @connection_details.map {|item, value| "#{value["ram_free"]} %"} 
					@cpus = @connection_details.map {|item, value| value['cpu']}
					@ranks = @connection_details.map {|item, value| value['rank']}
					@cpus_percent = @connection_details.map {|item, value| "#{value['cpu_percent']} %"}
					@rams = @connection_details.map {|item, value| "#{value['ram']} Gb"}
					@memory = @connection_details.map {|item, value| "#{value['memory']} Gb"}


					@ranks[0..-1].each do |rank|
						if @ranks[0] < rank && !@hidden_window
							@root.wm_withdraw
							@hidden_window = true
						elsif @ranks[0] > rank && @hidden_window
							@root.wm_deiconify
							@hidden_window = false
						end
					end

					create_data @names, @ips, @cpus, @rams_free, @ranks, @rams, @cpus_percent, @memory
				end
			end
		end

        begin
			loop do 
				@client_connection = @server_socket.accept
				Thread.start(@client_connection) do |client|
					sock_domain, remote_port, remote_hostname, remote_id = client.peeraddr
					puts "connect to #{remote_id}".yellow.bold

					#@root.wm_withdraw
					#sleep 4 
					#@root.wm_deiconify
					@index += 1
					client_number = @index
					response = JSON.parse(client.gets)
					response['ip'] = remote_id
					@connection_details[@index] = response
					update_data client_number, client, remote_id
				end
			end
        rescue => e

            puts e.message
            @client_connection.close
        end
    end

	def close_interface
		puts "close conexion"
		@server.kill
		@root.destroy()
	end

	def user_interface
		Tk.mainloop
	end

    def run
        @server = Thread.new do
            run_server
        end
		gui = Thread.new do 
			user_interface
		end
        @server.join
		gui.join
    end
end

Thread.start  do
	Client.new 'localhost', 5434
end
Thread.start  do
	Client.new '192.168.1.73', 5434
end
Nodo.new 5434
