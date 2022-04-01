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

	conn, err := vm.VSockDial(ctx, logger, "/var/lib/firecracker-containerd/shim-base/default#ca688585-b1dd-4a83-aade-1be5c08265f3/firecracker.vsock", _defaultVsockPort)
	if err != nil {
		fmt.Println(err)
		return
	}

	rpcClient := ttrpc.NewClient(conn, ttrpc.WithOnClose(func() { _ = conn.Close() }))
	var resp drivemount.ExecCmdResponse
	req := drivemount.ExecCmdRequest{
		Cmd: "journalctl -u firecracker-agent",
	}
	err = rpcClient.Call(context.Background(), "DriveMounter", "ExecCmd", &req, &resp)

	fmt.Println(resp.Outstr)
	if err != nil {
		fmt.Println("Call ExecCmd failed with error:")
		fmt.Println(err)
		return
	}

	fmt.Println("successfully executed command")
	return

}
