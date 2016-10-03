Write-Host "This is a generation 1 2003 R2 Hyper-V VM and should only be built on the 2012 R2 Host"
Write-host "checking operationg system now."
if(!([environment]::OSVersion.Version | where {$_.Major -eq "6" -and $_.Minor -eq "2" -or "3"})) `
    {
    write-host "This version of windows is not correct"
    exit
    } 
else {"Operating system matches. The script will proceed"}

$computer = $env:computername
$VMNAME = $computer.replace("CH","CG").remove(6)+"S2"
$VMNAME
Write-Host "$VMNAME is the new guest VM NAME"
$VMTEMPLATE = "E:\Content\VMTemplates\2003X86"
$integritycheck = if(Test-Path -path "D:\hyper-v\$VMNAME") {exit}
write-host "Checking to see if the VM folder already exists."
$integritycheck
$VMFOLDER = "D:\Hyper-V\$VMNAME"
new-item -path $VMFolder -ItemType directory
write-host "we're building the S3 guest. This will take a few minutes"
$temptoperm = if(test-path -path $VMFOLDER) {cmd /c robocopy $VMTEMPLATE $VMFOLDER}
$temptoperm

new-vm -Name $VMNAME -Path $VMFOLDER -Generation 1 -SwitchName guestVswitch
Set-VM -Name $VMNAME -ProcessorCount 4 -DynamicMemory -MemoryStartupBytes 800MB  -MemoryMaximumBytes 4GB

Add-VMHardDiskDrive -VMName $VMNAME -ControllerType IDE -ControllerNumber 0 -Path "$vmfolder\guest_C.vhd"
Get-VM $VMNAME | Add-VMHardDiskDrive –ControllerType SCSI -ControllerNumber 0 -path "$VMFOLDER\Guest_D.vhd"
Get-VM $VMNAME | Add-VMHardDiskDrive –ControllerType SCSI -ControllerNumber 0 -path "$VMFOLDER\Guest_E.vhd"
Get-VM $VMNAME | Add-VMHardDiskDrive –ControllerType SCSI -ControllerNumber 0 -path "$VMFOLDER\Guest_F.vhd"
Get-VM $VMNAME | Add-VMHardDiskDrive –ControllerType SCSI -ControllerNumber 0 -path "$VMFOLDER\Guest_G.vhd"
$VMNAME = get-vm "CG[0-9]*S2" | select -expandproperty name

Start-VM -Name $VMNAME





