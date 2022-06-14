USE kcm;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
INSERT INTO
    `area`
VALUES
    (
    '1',
    'root',
    'root',
    null,
    0,
    1,
    'admin',
    now(),
    '根节点',
    0,
    1,
    ',1,',
    null
    );
INSERT INTO
    `strategy`
VALUES
    (
    '00000000000000000000000000000000',
    'default',
    '1',
    'admin',
    now()
    );
INSERT INTO
    `users` (
    `user_id`,
    `username`,
    `password`,
    `role_id`,
    `status`,
    `name`,
    `create_by_user_id`
    )
VALUES
    (
    1,
    'admin',
    'a1effce56d210d736a50bbf6f9d3a649',
    1,
    '1',
    null,
    0
    );
INSERT INTO
    `roles` (
    role_id,
    rolename,
    routes,
    introduce,
    create_by_user_id
    )
VALUES
    (
    1,
    'admin',
    'Dashbord,Permission,PageUser,PageAdmin,Roles,MonitorMain,MonitMain,ServerInformation,HostManage,Logs-index,Update-index,Activation-index,Table,BaseTable,ComplexTable,Icons-index,Components,Sldie-yz,Upload,Carousel,Echarts,Sldie-chart,Dynamic-chart,Map-chart',
    '管理员',
    NULL
    );
INSERT INTO
    `admin_area_relationships`
VALUES
    ('11111', 1, '1');
INSERT INTO
    `device_group`
VALUES
    (
    1,
    'kcm',
    NULL,
    now(),
    1,
    'admin',
    now(),
    '1',
    'admin'
    );
INSERT INTO
    `mode`
VALUES(1, '默认策略', 'default');
update
    users
set
    password = 'a1effce56d210d736a50bbf6f9d3a649'
where
    username = 'admin';
