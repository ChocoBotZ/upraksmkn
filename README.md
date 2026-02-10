# Lab SMK Server (DNS + Web + CACTI)

## 🎯 Config:
| Record | IP |
|--------|----|
| lab-smk.xyz | 192.168.30.10 |
| www | 192.168.30.10 |
| **monitor** | **192.168.30.10** |

## 🚀 Cara Install:
```bash
apt install git
git clone https://github.com/ChocoBotZ/upraksmkn
cd lab-smk-server
chmod +x *.sh
sudo ./dnsweb.sh
sudo ./cacti.sh


***

## 🎯 **Cara Pakai CACTI**
1. [**http://monitor.lab-smk.xyz**](http://monitor.lab-smk.xyz)
2. Login: `admin` / `admin` → **ganti password**
3. **Console → Create Devices:**
