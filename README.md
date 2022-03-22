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


## 联系

Discord:
https://discord.gg/ad5PfY9
