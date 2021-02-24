### 硬件信息

- 主板: GA-Z97-D3H
- CPU: E3 v1231 v3
- 显卡: Radeon RX 570 4 GB
- 内存: 16 GB
- SSD: 512GB

### 使用

1. 在 [Actions](https://github.com/betteray/OpenCore-EFI-Actions/actions)下载最新编译版本。
2. 下载后解压检查 EFI/OC/Others 文件夹内 ocvalidate_result.txt 文件，看 config.plist 是否有缺失或多余字段等。
3. 没有报错，可以删除 Others 文件夹，有报错可以下载历史打包版本。
4. 自己做 [USB Map](https://dortania.github.io/OpenCore-Post-Install/usb/intel-mapping/intel.html)。 (可选: 不做的话，可能有些usb口被禁用，有些可用)
5. 自己生成 [机型信息](https://dortania.github.io/OpenCore-Install-Guide/config.plist/haswell.html#platforminfo)。（可选: 不做能开机，可能导致登陆icloud等有问题）
