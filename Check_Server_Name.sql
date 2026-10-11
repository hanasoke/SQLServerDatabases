SELECT 
    SERVERPROPERTY('ServerName')      AS server_name,
    SERVERPROPERTY('MachineName')     AS machine_name,
    SERVERPROPERTY('InstanceName')    AS instance_name,
    SERVERPROPERTY('ComputerNamePhysicalNetBIOS') AS physical_name,
    @@SERVERNAME                      AS server_name_alias;

    SELECT
    name AS username,
    is_disabled
FROM sys.sql_logins
ORDER BY name;