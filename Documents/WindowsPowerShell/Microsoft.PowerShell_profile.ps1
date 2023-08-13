$kubeConfDirectory = "$env:USERPROFILE\.kube\conf.d"
$kubeConfigFiles = Get-ChildItem -Path $kubeConfDirectory
$kubeConfigPaths = $kubeConfigFiles.FullName -join ";"

$Env:KUBECONFIG="$kubeConfigPaths;$HOME\.kube\config"

if(Get-Command 'starship' -errorAction SilentlyContinue) {
    Invoke-Expression (&starship init powershell)
}
