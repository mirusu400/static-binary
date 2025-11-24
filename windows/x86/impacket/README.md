# Impacket Toolkit

* https://github.com/fortra/impacket

## Build environment

* Windows 7 (6.1) Build 7601 Service Pack 1 x86
* Python 3.8.10
* Impacket 0.13.0

## Build steps

```bash
python -m venv venv
./venv/scripts/activate
pip install impacket pyinstaller
git clone https://github.com/fortra/impacket
cd impacket/scripts

# copy build.cmd to impacket/scripts and run build.cmd
```

