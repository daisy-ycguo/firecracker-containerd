module github.com/firecracker-microvm/firecracker-containerd

require (
	github.com/Microsoft/go-winio v0.5.0 // indirect
	github.com/Microsoft/hcsshim v0.8.23 // indirect
	github.com/StackExchange/wmi v0.0.0-20181212234831-e0a55b97c705 // indirect
	github.com/alexflint/go-filemutex v1.1.0 // indirect
	github.com/awslabs/tc-redirect-tap v0.0.0-20200708224642-a0300978797d
	github.com/bits-and-blooms/bitset v1.2.1 // indirect
	github.com/buger/jsonparser v1.1.1 // indirect
	github.com/containerd/aufs v1.0.0 // indirect
	github.com/containerd/btrfs v1.0.0 // indirect
	github.com/containerd/containerd v1.5.9
	github.com/containerd/continuity v0.2.0 // indirect
	github.com/containerd/fifo v1.0.0
	github.com/containerd/go-cni v1.0.2 // indirect
	github.com/containerd/go-runc v1.0.0
	github.com/containerd/imgcrypt v1.1.1 // indirect
	github.com/containerd/nri v0.1.0 // indirect
	github.com/containerd/ttrpc v1.1.0
	github.com/containerd/typeurl v1.0.2
	github.com/containerd/zfs v1.0.0 // indirect
	github.com/containernetworking/cni v1.0.1
	github.com/containernetworking/plugins v1.0.1
	github.com/coreos/go-iptables v0.6.0 // indirect
	github.com/firecracker-microvm/firecracker-go-sdk v0.22.1-0.20210520223842-abd0815b8bf9
	github.com/go-ole/go-ole v1.2.4 // indirect
	github.com/go-openapi/runtime v0.21.1 // indirect
	github.com/gofrs/uuid v3.3.0+incompatible
	github.com/gogo/googleapis v1.4.1 // indirect
	github.com/gogo/protobuf v1.3.2
	github.com/golang/groupcache v0.0.0-20210331224755-41bb18bfe9da // indirect
	github.com/golang/protobuf v1.5.2
	github.com/google/uuid v1.3.0 // indirect
	github.com/hashicorp/go-multierror v1.1.1
	github.com/imdario/mergo v0.3.12 // indirect
	github.com/j-keck/arping v1.0.2 // indirect
	github.com/klauspost/compress v1.13.6 // indirect
	github.com/mattn/go-shellwords v1.0.12 // indirect
	github.com/mdlayher/vsock v1.1.1
	github.com/miekg/dns v1.1.25
	github.com/moby/locker v1.0.1 // indirect
	github.com/networkplumbing/go-nft v0.2.0 // indirect
	github.com/onsi/gomega v1.15.0 // indirect
	github.com/opencontainers/image-spec v1.0.2 // indirect
	github.com/opencontainers/runc v1.0.3
	github.com/opencontainers/runtime-spec v1.0.3-0.20210910115017-0d6cc581aeea
	github.com/opencontainers/selinux v1.8.5 // indirect
	github.com/pkg/errors v0.9.1
	github.com/safchain/ethtool v0.2.0 // indirect
	github.com/sclevine/agouti v3.0.0+incompatible // indirect
	github.com/shirou/gopsutil v2.18.12+incompatible
	github.com/shirou/w32 v0.0.0-20160930032740-bb4de0191aa4 // indirect
	github.com/sirupsen/logrus v1.8.1
	github.com/stretchr/testify v1.8.0
	github.com/tv42/httpunix v0.0.0-20191220191345-2ba4b9c3382c
	github.com/vishvananda/netlink v1.1.1-0.20210330154013-f5de75959ad5
	github.com/vishvananda/netns v0.0.0-20211101163701-50045581ed74 // indirect
	go.opencensus.io v0.23.0 // indirect
	golang.org/x/net v0.0.0-20220225172249-27dd8689420f // indirect
	golang.org/x/sync v0.0.0-20210220032951-036812b2e83c
	golang.org/x/sys v0.0.0-20220405210540-1e041c57c461
	golang.org/x/text v0.3.7 // indirect
	google.golang.org/genproto v0.0.0-20220222213610-43724f9ea8cf // indirect
	google.golang.org/grpc v1.44.0
	k8s.io/apiserver v0.20.6 // indirect
	k8s.io/cri-api v0.20.6 // indirect
)

replace (
	github.com/firecracker-microvm/firecracker-go-sdk => ../firecracker-go-sdk
	// Pin gPRC-related dependencies as like containerd v1.5.x.
	github.com/gogo/googleapis => github.com/gogo/googleapis v1.3.2
	github.com/golang/protobuf => github.com/golang/protobuf v1.3.5

	// Upgrade mongo-driver before go-openapi packages update the package.
	go.mongodb.org/mongo-driver => go.mongodb.org/mongo-driver v1.5.1

	// Pin gPRC-related dependencies as like containerd v1.5.x.
	google.golang.org/genproto => google.golang.org/genproto v0.0.0-20200224152610-e50cd9704f63
	google.golang.org/grpc => google.golang.org/grpc v1.27.1

	github.com/containernetworking/cni => github.com/containernetworking/cni v0.8.1-0.20201028171607-0050bfa52884
)

go 1.11
