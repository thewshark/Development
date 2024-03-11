reg add "HKEY_LOCAL_MACHINE\SOFTWARE\SAP BusinessObjects\Crystal Reports for .NET Framework 4.0\Report Application Server\InprocServer" /v PrintJobLimit /t REG_SZ /d "99.999" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\SAP BusinessObjects\Crystal Reports for .NET Framework 4.0\Report Application Server\InprocServer" /v AgentLimit /t REG_SZ /d "99.999" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\SAP BusinessObjects\Crystal Reports for .NET Framework 4.0\Report Application Server\Server" /v PrintJobLimit /t REG_SZ /d "99.999" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\SAP BusinessObjects\Crystal Reports for .NET Framework 4.0\Report Application Server\Server" /v AgentLimit /t REG_SZ /d "99.999" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\SAP BusinessObjects\Crystal Reports for .NET Framework 4.0\Report Application Server\InprocServer" /v PrintJobLimit /t REG_SZ /d "99.999" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\SAP BusinessObjects\Crystal Reports for .NET Framework 4.0\Report Application Server\InprocServer" /v AgentLimit /t REG_SZ /d "99.999" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\SAP BusinessObjects\Crystal Reports for .NET Framework 4.0\Report Application Server\Server" /v PrintJobLimit /t REG_SZ /d "99.999" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\SAP BusinessObjects\Crystal Reports for .NET Framework 4.0\Report Application Server\Server" /v AgentLimit /t REG_SZ /d "99.999" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows" /v GDIProcessHandleQuota /t REG_DWORD /d "65000" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows" /v USERProcessHandleQuota /t REG_DWORD /d "18000" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion\Windows" /v GDIProcessHandleQuota /t REG_DWORD /d "65000" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion\Windows" /v USERProcessHandleQuota /t REG_DWORD /d "18000" /f

pause