pushd $(pwd)
cd /var/lib/firecracker-containerd/shim-base
sed -i "s/default#.*\//$(ls default#* -d)\//g" /home/xinranwa/go/src/github.com/firecracker-microvm/firecracker-containerd/tools/main/ttrpc_client.go
popd

go run ttrpc_client.go
