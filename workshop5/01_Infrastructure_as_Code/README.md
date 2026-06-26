## Ubuntu 24.04 LTS
- To use `Ubuntu Desktop 24.04 LTS` instead of `Ubuntu Server 24.04 LTS`:
  - In `01-packer.ipynb`, change `ubuntu-server-24` in each code cell to `ubuntudesktop-24`.
    - Also make sure you download the Ubuntu Desktop 24.04 LTS ISO file.
  - In `02-terraform.ipynb`, change `ubuntu-server-24` in each code cell to `ubuntudesktop-24`.
  - In `ansible/inventory.ini`, change `u24s01` and `u24s02` to `u24d01` and `u24d02` respectively.