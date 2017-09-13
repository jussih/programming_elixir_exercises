[s] = :io_lib.format("~.2f", [5.678])  # float to string
IO.puts(s)

System.get_env("PATH")  # get env variable
|> IO.inspect

Path.extname("juba/foo.txt")  # file extension
|> IO.inspect

System.cwd()  # current working directory
|> IO.inspect

System.cmd("ls", [])  # exec cmd with args
|> IO.inspect
