#!/bin/bash
for key in ~/.ssh/id_rsa ~/.ssh/id_rsa_* ~/.ssh/id_ed25519 ~/.ssh/id_ed25519_*; do
    # Public key 파일을 배제하기 위해 .pub 확장자를 가진 파일은 건너뜁니다
    if [[ $key == *.pub ]]; then
        continue
    fi
    # 해당 파일이 존재할 경우에만 ssh-add를 실행합니다
    if [ -e "$key" ]; then
        ssh-add "$key"
    fi
done
