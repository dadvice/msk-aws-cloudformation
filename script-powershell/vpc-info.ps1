Param(
    $region
)

Function checkAWSCLI() {
    $aws = Get-Command aws
    if ( $? ) {
        Write-Output "[*] Obteniendo informacion de las vpcs desplegadas"
    }else {
        Write-Output "[!!] Es necesario tener instalado aws cli v2"
    }
} 

Function banner() { 
    Write-Host "#################################" -ForegroundColor Green
    Write-Host "### VPC Information           ###" -ForegroundColor Green
    Write-Host "#################################" -ForegroundColor Green
}

Function getSubnetsFromVPC($vpcId) {
    
    $response_subnets = aws ec2 describe-subnets --filters Name=vpc-id,Values=$vpcId
    $json_subnets = $response_subnets | ConvertFrom-Json

    foreach($subnet in $json_subnets.Subnets) {
        Write-Output "[*] Subnet ID : $($subnet.SubnetId)"
        Write-Output "..."
        Write-Output "AvailabilityZone -> $($subnet.AvailabilityZone)"
        Write-Output "CidrBlock -> $($subnet.CidrBlock)"
        Write-Output "MapPublicIpOnLaunch -> $($subnet.MapPublicIpOnLaunch)"
        foreach($tag in $vpc.Tags) {
            Write-Output "Key     -> $($tag.Key)"
            Write-Output "Value   -> $($tag.Value)"
        }
        Write-Output "...................................."
    }
}

banner;
checkAWSCLI;
   
$response_vpcs = aws ec2 describe-vpcs --region $region
$json_vpcs = $response_vpcs | ConvertFrom-Json

Write-Output "#! -> VPC Lists "
foreach($vpc in $json_vpcs.Vpcs) {
    Write-Output "[*] VPC ID : $($vpc.VpcId)"
    Write-Output  "..."
    Write-Output "CidrBlock -> $($vpc.CidrBlock)"
    Write-Output "Tags:"
    foreach($tag in $vpc.Tags) {
        Write-Output "Key     -> $($tag.Key)"
        Write-Output "Value   -> $($tag.Value)"
    }
    Write-Output "..."
    getSubnetsFromVpc($vpc.VpcId);
    Write-Output "...................................."
}   
