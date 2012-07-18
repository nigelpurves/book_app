root = "/home/qusic/sites/qusic.co.uk/current"
working_directory root
pid "#{root}/tmp/pids/unicorn-qusic.pid"
stderr_path "#{root}/log/unicorn.log"
stdout_path "#{root}/log/unicorn.log"

listen "/tmp/unicorn.qusic.co.uk.sock"
worker_processes 4
timeout 30
