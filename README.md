pfproxy
====

## 使用说明

`pfproxy` TCP 代理，无抽水，支持配置多个后端地址，自动选择速度最优的后端

```
Usage:
  pfproxy run [flags]

Flags:
  -h, --help                      help for run
  -L, --listen stringArray        listen address(can be given multiple times)
  -R, --remote stringArray        remote address(can be given multiple times)
  -N, --max-num-mux-conns int32   max number of multiplexing connections (default 128)
  -V, --verbose                   verbose mode
```


### 地址格式说明

| 地址                  | 说明          | 示例                                          |
| ----                  | ----          | ----                                          |
| `address`             | TCP 地址      | `8.8.8.8:3333, :3333`                         |
| `tcp://address`       | TCP 地址      | `tcp://8.8.8.8:3333, tcp://:3333`             |
| `tls://address`       | TLS 地址      | `tls://8.8.8.8:3443, tls://:3443`             |
| `ssl://address`       | TLS 地址      | `ssl://8.8.8.8:3443, ssl://:3443`             |
| `relay://address`     | 中继 TCP 地址 | `relay://8.8.8.8:3366, relay://:3366`         |
| `relay+tls://address` | 中继 TLS 地址 | `relay+tls://8.8.8.8:3366, relay+tls://:3366` |

`:port` 代表监听所有网卡


### 证书

`pfproxy` 内置了 TLS 证书，如果需要使用其他 TLS 证书，需要在命令行参数中指定，例如：

```
./pfproxy run -L 'tls://:3443?cert=/path/to/cert&key=/path/to/key' -R tls://pool-address
```


### 矿机支持 SSL

```
./pfproxy run -L tls://:3443 -R tls://pool-address1 -R tls://pool-address2
```

挖矿地址配置成 `stratum+ssl://vps-ip:3443`


### 矿机不支持 SSL

需要矿机本地网络部署一个 `pfproxy`，中转 VPS 部署一个 `pfproxy`

```
# VPS
./pfproxy run -L relay+tls://:3366 -R tls://pool-address1 -R tls://pool-address2

# 本地机器
./pfproxy run -L :3333 -R relay+tls://vps-ip:3366
```

挖矿地址配置成 `stratum+tcp://local-ip:3333`，这样流量到中转 VPS 就会被加密


## 示例

本地跑 `pfproxy` 时推荐用个专门的 `NUC`，装个 `Ubuntu` 系统，路由器为此 `NUC` 设置静态 IP


#### KDA

矿机不直接支持 `TLS`，需要本地部署一个 `pfproxy` 代理，矿机连接此代理

```
# VPS
./pfproxy run -V -L relay+tls://:3366 -R kda.ss.poolflare.net:443 -R kda-asia.ss.poolflare.net:443 -R kda-us.ss.poolflare.net:443 -R kda-eu.ss.poolflare.net:443

# 本地机器
./pfproxy run -V -L :3333 -R relay+tls://vps-ip:3366
```


#### CFX

矿机使用 `SSL` 连接 VPS 代理

```
# VPS
./pfproxy run -V -L tls://:3443 -R tls://cfx.ss.poolflare.net:3443 -R tls://cfx-asia.ss.poolflare.net:3443 -R tls://cfx-us.ss.poolflare.net:3443 -R tls://cfx-eu.ss.poolflare.net:3443
```


## 联系

Discord:
https://discord.gg/ad5PfY9
