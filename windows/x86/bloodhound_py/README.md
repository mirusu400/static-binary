# Impacket Toolkit

* https://github.com/dirkjanm/BloodHound.py

## Build environment

* Windows 7 (6.1) Build 7601 Service Pack 1 x86
* Python 3.8.10
* Impacket 0.13.0

## Build steps

```bash
python -m venv venv
./venv/scripts/activate
pip install impacket pyinstaller
git https://github.com/dirkjanm/BloodHound.py
cd BloodHound.py

# copy build.ps1 to impacket/scripts and run build.cmd
```
