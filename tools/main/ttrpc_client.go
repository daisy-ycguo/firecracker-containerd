package main

import (
	"context"
	"fmt"

	"github.com/containerd/containerd/log"
	"github.com/containerd/ttrpc"
	"github.com/firecracker-microvm/firecracker-containerd/internal/vm"
	drivemount "github.com/firecracker-microvm/firecracker-containerd/proto/service/drivemount/ttrpc"
)

const (
	_defaultVsockPort = 10789
)

func main() {
	ctx := context.Background()
	logger := log.G(ctx)

	conn, err := vm.VSockDial(ctx, logger, "/var/lib/firecracker-containerd/shim-base/default#5472982d-76a1-4504-9bc2-d91a8dc3b909/firecracker.vsock", _defaultVsockPort)
	if err != nil {
		fmt.Println(err)
		return
	}

	//command_str := "runc --rootless true --root /run/containerd/runc/default list"
	//command_str := "ls /run/containerd/runc/default"
	//command_str := "ls /usr/local/bin"
	//command_str := "netstat -p"
	//command_str := "ps -aux"
	//command_str := "cat /container/count155/config.json"
	//command_str := "ip netns list"
	//command_str := "curl http://127.0.0.1:8080/2015-03-31/functions/function/invocations"
	//command_str := "journalctl -u firecracker-agent"
	command_str := "busybox ip addr show eth0"
	//command_str := "chronyc -a makestep"
	//command_str := "env"
	//command_str := "chronyc"
	//command_str := "ls /var/run/containerd/runc/default/count155"
	//command_str := "cat /var/run/containerd/runc/default/count155/state.json"

	rpcClient := ttrpc.NewClient(conn, ttrpc.WithOnClose(func() { _ = conn.Close() }))
	var resp drivemount.ExecCmdResponse
	req := drivemount.ExecCmdRequest{
		//Cmd: "runc --rootless true --root /container/count152 list",
		Cmd: command_str,
	}
	err = rpcClient.Call(context.Background(), "DriveMounter", "ExecCmd", &req, &resp)

	fmt.Printf("Exec %s\n", command_str)
	fmt.Println(resp.Outstr)
	if err != nil {
		fmt.Println("Call ExecCmd failed with error:")
		fmt.Println(err)
		return
	}

	fmt.Println("successfully executed command")

}
