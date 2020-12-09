# VaultをK8sにデプロイしてSecretをPodに挿入する

おそらくどのようなK8s環境でも試せる（と思います）。

## 事前準備

- K8s環境を構築してください。なんでもよいです。
	- AKS (on Azure)
	- EKS (on AWS)
	- GKE (on GCP)
	- Minikube
	- kind
	- etc
- kubectlのインストール
- helmのインストール


`kubectl config current-context`で準備したK8s環境が設定されているか確認ください。
もし別のK8s環境が設定されていた場合は、`kubectl config set-context <使いたいK8s環境>`で正しく設定ください。


## 手順

まずはこのRepositoryをCloneしてください。

とりあえず、このRepoに入っているScriptを順に実行していけば試せます。

### 各スクリプトが何をおこなうか

0. HashiCorpのHelm repoを追加します
1. Helmを使ってConsulをデプロイします。ConsulはVaultのStorage backendとして使用します。
2. Helmを使ってVaultをデプロイします。
3. Vaultの状態（Status)をチェックするスクリプトです。このスクリプトはいつでもVaultの状態をチェックしたい時に使ってください。
4. VaultのUIへのLocal proxyを設立します。このスクリプトを実行している間は、`http://localhost:8200`　にアクセスすればVaultのUIにアクセスできます。
5. Vaultを初期化します。初期化時のアウトプットは `cluster-keys.json` へ保管します。
6. VaultをUnsealします。
7. Root tokenでLoginしておきます。
8. VaultのPodへShellアクセスします。Vaultコマンドを直接実行できます。試し終わったらVault podのshellから`exit`してください。
9. VaultのKVシークレットエンジンを有効化します。
10. KVシークレットエンジンに任意のシークレットを登録します。値は自由に変更して構いません。
11. VaultのKubernetes認証を有効化します。
12. VaultのKubernetes認証の設定を行います。
13. VaultへpolicyとKubernetes認証で使うRoleを設定します。
14. Podの認証に使うService accountを作成します。
15. 実際のアプリケーションをデプロイします。
	- ここでは例としてnginxをデプロイします。
	- この実習での目的はVaultがいかにしてPodへSecretを挿入するか、という事ですので、nginx以外の好きなコンテナを使用しても構いません。
	- もし、nginxが実際にデプロイされてるか確認したければ以下を試してください。
		- `kubectl get services nginx-service` で表示される`EXTERNAL-IP`へブラウザや`curl`でアクセスしてみてください。Nginxのデフォルトのページが表示されると思います。
16. 15でデプロイしたPodにSecretが挿入されているか確認します。
	- `deployment-nginx.yml`のAnnotationで指定されている通り、`/vault/secrets/mysecret.txt`にSecretが入っているか確認します。
17. 15でデプロイしたPodへShellアクセスします。実際のファイルシステムなどを確認したいとき使ってください。

## まとめ

上記の手順で、いかにしてVaultがK8sのPodを認証し、Secretを挿入するかが理解いただけたと思います。

