$version = "8.0.33"
$url = "https://cdn.mysql.com//Downloads/MySQL-8.0/mysql-${version}-winx64.zip"

Write-Host "mysql version: ${version}"
Write-Host "url: ${url}"

If (!(test-path ".\mysql80")) {

    $client = new-object System.Net.WebClient
    $client.DownloadFile("${url}", ".\mysql-${version}-winx64.zip")

    Write-Host "ZIPファイルを解凍して、削除する。"
    Write-Host ".\mysql-${version}-winx64.zip >>>> ."
    Expand-Archive -Path ".\mysql-${version}-winx64.zip" -DestinationPath "." -Force
    Remove-Item ".\mysql-${version}-winx64.zip"

    Rename-Item -Path "mysql-${version}-winx64" -NewName "mysql80"
}

Write-Host "----------------------------------------"

$version = "2.4.55"
$url = "https://www.apachehaus.com/downloads/httpd-${version}-o111s-x64-vs17.zip"

Write-Host "php version: ${version}"
Write-Host "url: ${url}"

If (!(test-path ".\Apache24")) {
    $client = new-object System.Net.WebClient
    $client.DownloadFile("${url}", ".\httpd-${version}-o111s-x64-vs17.zip")

    Write-Host "ZIPファイルを解凍して、削除する。"
    Write-Host ".\httpd-${version}-o111s-x64-vs17.zip >>>> ."
    Expand-Archive -Path ".\httpd-${version}-o111s-x64-vs17.zip" -DestinationPath "." -Force
    Remove-Item ".\httpd-${version}-o111s-x64-vs17.zip"
    Remove-Item ".\readme_first.html"
}

Write-Host "----------------------------------------"

$version = "8.1.18"
$url = "https://www.apachehaus.com/downloads/httpd-${version}-o111s-x64-vs17.zip"

Write-Host "apache version: ${version}"
Write-Host "url: https://windows.php.net/downloads/releases/php-${version}-nts-Win32-vs16-x64.zip"

If (!(test-path ".\php81")) {
    Write-Host "PHPをダウンロードする。"
    Write-Host "https://windows.php.net/downloads/releases/php-${version}-nts-Win32-vs16-x64.zip"
    $client = new-object System.Net.WebClient
    $client.Headers.Add("user-agent", "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.2; .NET CLR 1.0.3705;)");
    $client.DownloadFile("https://windows.php.net/downloads/releases/php-${version}-nts-Win32-vs16-x64.zip", ".\php-${version}-nts-Win32-vs16-x64.zip")

    Write-Host "ZIPファイルを解凍して、削除する。"
    Write-Host ".\php-${version}-nts-Win32-vs16-x64 >>>> ."
    Expand-Archive -Path ".\php-${version}-nts-Win32-vs16-x64.zip" -DestinationPath ".\php-${version}-nts-Win32-vs16-x64" -Force
    Remove-Item ".\php-${version}-nts-Win32-vs16-x64.zip"

    Rename-Item -Path "php-${version}-nts-Win32-vs16-x64" -NewName "php81"
}

Write-Host "環境変数を設定する"
$PHP_HOME = Resolve-Path ".\php81"
Write-Host "PHP_HOME = $PHP_HOME"
[Environment]::SetEnvironmentVariable("PHP_HOME", $PHP_HOME, "User")
Write-Host "Pathに[%PHP_HOME%]を追加してください。"

Write-Host "----------------------------------------"

Copy-Item "configs\mysql\my.ini" -Destination "mysql80"
Copy-Item "configs\apache\httpd.conf" -Destination "Apache24\conf"

Write-Host "何かキーを押してください。" -NoNewLine
[Console]::ReadKey() | Out-Null
