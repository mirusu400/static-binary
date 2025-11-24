# Impacket Toolkit

* https://github.com/fortra/impacket

## Build environment

* Windows 11 24H2 26100.7171
* Python 3.12.10
* Impacket 0.13.0

## Build steps

```bash
python -m venv venv
./venv/scripts/activate
pip install impacket pyinstaller
git clone https://github.com/fortra/impacket
cd impacket/scripts

# copy build.ps1 to impacket/scripts and run build.ps1
```

