#!/usr/bin/env bash
set -euo pipefail

# 1) 기본 패키지
apt-get update
apt-get install -y curl ca-certificates

# 2) dotnet-install 스크립트 다운로드
curl -fsSL https://dot.net/v1/dotnet-install.sh -o /tmp/dotnet-install.sh
chmod +x /tmp/dotnet-install.sh

# 3) .NET 9 최신 채널 설치 (필요 시 --quality ga, --version 9.0.x로 고정 가능)
#   - 시스템 전역 경로(루트 권한) 또는 사용자 홈 경로 중 택1
INSTALL_DIR="/usr/share/dotnet"
mkdir -p "$INSTALL_DIR"
bash /tmp/dotnet-install.sh --channel 9.0 --install-dir "$INSTALL_DIR"

# 4) 환경변수 등록 (현재 셸 + 향후 셸)
export DOTNET_ROOT="$INSTALL_DIR"
export PATH="$DOTNET_ROOT:$PATH"

echo 'export DOTNET_ROOT=/usr/share/dotnet' > /etc/profile.d/dotnet.sh
echo 'export PATH=$DOTNET_ROOT:$PATH' >> /etc/profile.d/dotnet.sh
chmod +x /etc/profile.d/dotnet.sh

# 5) 확인
dotnet --info
dotnet --version
