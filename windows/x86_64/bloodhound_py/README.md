# Impacket Toolkit

* https://github.com/dirkjanm/BloodHound.py

## Build environment

* Windows 11 24H2 26100.7171
* Python 3.12.10
* Impacket 0.13.0

## Build steps

```bash
python -m venv venv
./venv/scripts/activate
pip install impacket pyinstaller
git https://github.com/dirkjanm/BloodHound.py
cd BloodHound.py

# copy build.ps1 to impacket/scripts and run build.ps1
```

