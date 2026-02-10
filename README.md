# Lab SMK Server (DNS + Web + CACTI)

## 🎯 Config:
| Record | IP |
|--------|----|
| lab-smk.xyz | 192.168.30.10 |
| www | 192.168.30.10 |
| **monitor** | **192.168.30.10** |

## 🚀 Deploy:
```bash
chmod +x *.sh
sudo ./01-dns-web-server.sh    # DNS + Web + HTTPS
sudo ./02-cacti.sh             # CACTI Monitoring


***

## 🎯 **Cara Pakai CACTI**
1. [**http://monitor.lab-smk.xyz**](http://monitor.lab-smk.xyz)
2. Login: `admin` / `admin` → **ganti password**
3. **Console → Create Devices:**
