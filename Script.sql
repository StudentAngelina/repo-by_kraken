SELECT
    [MainSelect].[Id] [Id],
    [MainSelect].[Name] [Name],
    [MainSelect].[ParentRoleId] [ParentRoleId],
    0 [Level]
FROM
    [MainSelect]
INNER JOIN [SysUserInRole] sysUserInRole
    ON [MainSelect].[Id] = sysUserInRole.[SysUserId]
INNER JOIN [ChiefUnitsSelect] [AllUnits]
    ON [AllUnits].[Id] = sysUserInRole.[SysRoleId]
WHERE
    NOT EXISTS (
            SELECT
                [UserUnits].[Id]
            FROM [ChiefUnitsSelect] [UserUnits]
            INNER JOIN [SysUserInRole] [UserInRole]
                ON [UserUnits].[Id] = [UserInRole].[SysRoleId]
            INNER JOIN [SysAdminUnit] sau
                ON sau.[Id] = [UserUnits].[Id]
            WHERE sau.[SysAdminUnitTypeValue] = 2
                AND [UserInRole].[SysUserId] = @UserId
                AND [UserUnits].[Id] = [AllUnits].[Id])