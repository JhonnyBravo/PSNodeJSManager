$URL=@{
    x32="https://nodejs.org/dist/v8.12.0/node-v8.12.0-win-x86.zip";
    x64="https://nodejs.org/dist/v8.12.0/node-v8.12.0-win-x64.zip"
}

<#
.SYNOPSIS
Node.js をインストールします。

.PARAMETER x32
32 bit 版 Node.js をインストールします。

.PARAMETER x64
64 bit 版 Node.js をインストールします。
#>
function Install-NodeJS([switch]$x32,[switch]$x64){
    if($x32 -eq $false -and $x64 -eq $false){
        Write-Output "オプションを指定してください。"
        return
    }

    Uninstall-NodeJS

    if($x32){
        Invoke-WebRequest $URL["x32"] -OutFile "${HOME}/nodejs.zip"
    }elseif($x64){
        Invoke-WebRequest $URL["x64"] -OutFile "${HOME}/nodejs.zip"
    }
    
    Expand-Archive "${HOME}/nodejs.zip" $HOME

    Remove-Item "${HOME}/nodejs.zip"
}

<#
.SYNOPSIS
Node.js をアンインストールします。
#>
function Uninstall-NodeJS(){
    if(Test-Path "${HOME}/node-v[0-9]*"){
        Remove-Item -Recurse "${HOME}/node-v[0-9]*"
    }
}

<#
.SYNOPSIS
環境変数 Path へ Node.js がインストールされているフォルダーのパスを追加します。
#>
function Set-NodeJSPath(){
    $nodejs_path=(Resolve-Path "${HOME}/node-v[0-9]*")
    $env:Path="${env:Path}${nodejs_path};"
}
