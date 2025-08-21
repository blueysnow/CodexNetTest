#!/usr/bin/env bash
set -euo pipefail

# 1) �⺻ ��Ű��
apt-get update
apt-get install -y curl ca-certificates

# 2) dotnet-install ��ũ��Ʈ �ٿ�ε�
curl -fsSL https://dot.net/v1/dotnet-install.sh -o /tmp/dotnet-install.sh
chmod +x /tmp/dotnet-install.sh

# 3) .NET 9 �ֽ� ä�� ��ġ (�ʿ� �� --quality ga, --version 9.0.x�� ���� ����)
#   - �ý��� ���� ���(��Ʈ ����) �Ǵ� ����� Ȩ ��� �� ��1
INSTALL_DIR="/usr/share/dotnet"
mkdir -p "$INSTALL_DIR"
bash /tmp/dotnet-install.sh --channel 9.0 --install-dir "$INSTALL_DIR"

# 4) ȯ�溯�� ��� (���� �� + ���� ��)
export DOTNET_ROOT="$INSTALL_DIR"
export PATH="$DOTNET_ROOT:$PATH"

echo 'export DOTNET_ROOT=/usr/share/dotnet' > /etc/profile.d/dotnet.sh
echo 'export PATH=$DOTNET_ROOT:$PATH' >> /etc/profile.d/dotnet.sh
chmod +x /etc/profile.d/dotnet.sh

# 5) Ȯ��
dotnet --info
dotnet --version
