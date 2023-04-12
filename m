Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B32E6DE9CE
	for <lists+linux-erofs@lfdr.de>; Wed, 12 Apr 2023 05:11:50 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Px76D2kJTz3ccg
	for <lists+linux-erofs@lfdr.de>; Wed, 12 Apr 2023 13:11:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=RIVv4CSb;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f400:feab::711; helo=apc01-sg2-obe.outbound.protection.outlook.com; envelope-from=frank.li@vivo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=RIVv4CSb;
	dkim-atps=neutral
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on20711.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::711])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Px7654Gthz3cKj
	for <linux-erofs@lists.ozlabs.org>; Wed, 12 Apr 2023 13:11:40 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SifmJLq8GBM80T8ktPEVziTfPRJdPzZAg9wEI3gUM2gjX+vFc74j/9b9sY4xr/ViOSV8Wy7zlGbxBjJXTG+EA4JcDXw+4zgIy+Z307+YqaBv5LO+yGd0G8ajsQYhMBBsQq6HW/we0SqsY9Qry8E8WXaytIi+2rswSYYEaD6cqJ65Slt5BsNE3CPynjb0WJcOJHqDmNsuVYGjaewPaOG6UqFwmmBE64Q3mZsbGys/8i7PdmlF4LpZ0z8Uk/nEO2AJPMy8tWQEvzwpPZhzI1Pr2UFBF4+TGOoLvtuayEj0rQ4mnI47jArMjwOMd1eO4OXV0F7rUx8IlFjNI1JWVmrDRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9zXQNDGCKEzOQKyI2e5H8HfU3Z0SsSS5A3HLrl5PEqI=;
 b=T+3UiqMPdhuiPw07knRL9oZwwSLaQcWph40D4zgybvQkzzpsvVuvjwuyVsHnzw+LYHYzX8KnUTbW+ntBAkv2uJqccRQoRDqFA24G+9EAdjl3Xx1MA8ZmB51v7HZjYqsCYGxc/dokp2aHtkOZ7nDhvcSHcYL+KQWu9pODHLQQXUTLERVLHq9xbatzdtkHs6uoxPeWNCDBS6NifQR4SRw/1RmQV7xKfwY/noac5hb82dcjouBTI9POa+boQtQ36EKRhp8k2c8cYjvFP5MFARPfcTVqed0oQjI44sKsEhVhkgCP5DjEHWfB7h7ypltoxhxNeUtcGhfq6MuOd8Yl9+byyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9zXQNDGCKEzOQKyI2e5H8HfU3Z0SsSS5A3HLrl5PEqI=;
 b=RIVv4CSbVcL9tgc3jPFoIZdOma8NPLeI7OnTg0jtUlCZ/VZ8/2Kxe7J1gjgthkJNtp2ItPHowSDpT4JCDLEB9+0LHmEaTNx09dr9/D4Sf8Dw4gjRqLbwVLdF+7rU5P0JgcElRhYvaPVOGqn3N1SJvy1D67YH1G6E9+w1pf6pTJGkULs2AY3vzR8/NpyQVSrEqJXFoZwBzUR/RP64F1HcfMPP4k++r3/hTQ+dMDxaIMiqgh6fK/yIKm0wX93L8tEKq3kavRIrs6FQ9dJTcsgjFGh9stUyupLNLTLqNARDXmIcMIz6JsnOB6HrqmCf0DpEEVnzj0PdY5K+Yuawek/ncA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY0PR06MB5777.apcprd06.prod.outlook.com (2603:1096:400:270::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Wed, 12 Apr
 2023 03:11:22 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::a3a1:af8e:be1e:437c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::a3a1:af8e:be1e:437c%6]) with mapi id 15.20.6277.038; Wed, 12 Apr 2023
 03:11:22 +0000
From: Yangtao Li <frank.li@vivo.com>
To: Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Yue Hu <huyue2@coolpad.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: [PATCH] erofs: don't access kobject object members directly
Date: Wed, 12 Apr 2023 11:11:10 +0800
Message-Id: <20230412031110.8965-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:194::16) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TY0PR06MB5777:EE_
X-MS-Office365-Filtering-Correlation-Id: 1818bfa1-0230-4598-2a0d-08db3b03976a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	m7zt65m4LE2jhkWdvJTeJTaHaKsIWc3/rCKYTIiAbRIk1tVjljH24nObg5QS47pGqVW6KW5l1cPnFCD7s3hrlu6C5AfxQ9fBUJpPzTDG7xMS0+nY/MIV7WGLc4SpuB0onR/Z1Jk35cF4ir+7o7fBR72GG8dDZ2yY+DXiFMC1jw4XklGr8hRNyPcFK0lDuk3W008yYkDZB9heZRDARhTaDQ8/5Axqd7WijNOssdshw+tkb/hR2wfLJw3J3FMrjpRdlxgEJGqEHmrKpcF3Xfc8Bec86d7d8WT6yplx3jCE1KNyfLTXa2LDOXOYWSKZVhJIkyqhlOannSiAa0PLkZVPyliy8GLtD/JBkRMM9+kzioMJYXSokUelXya2jnw2Q1Q6S1V/Kk9wk0ioXDhfdDAmBxj+XGYLtrYazA37djVIZKz565Wgd9vK3mkDEOQcIeUi53v7XUGS5MtKLmDmQ0UFXYGFmRUQlm9YSxFqNEVc3bG0SZTq9g5Nqjr6ukBYCH3v9tb3agjOkS1SXc2M1LbWFMkAd0Vu0+O5QCa0WwFePIzkO+3qHAZWgKGvSCS1RBEX42DnDw19yxmPQF83K3td0f1eSraenlP53V1ACHYmldXWwzsYIOXaOscpJT7108dr
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(366004)(376002)(39860400002)(451199021)(478600001)(110136005)(5660300002)(8936002)(8676002)(66556008)(66476007)(4326008)(66946007)(41300700001)(316002)(2906002)(36756003)(38350700002)(38100700002)(83380400001)(2616005)(52116002)(6486002)(6512007)(26005)(1076003)(6506007)(186003)(86362001)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?2ZAPPFD+1BB1pg1jNYMQIExoXw+qoAaq1hQS+SzNNPm6vDXecFymBTJXgmdo?=
 =?us-ascii?Q?8j0ePDAb2G2ifhkL+8qocpeYH4ecUobU/JYMz9MX8FZMNhKYHUjS/0t1NxoH?=
 =?us-ascii?Q?SYvRmLu3goOX6n3tVs9pI4yarvYVzo/T6E3Vb/1JgDtgDwMFWmrMpo97szKD?=
 =?us-ascii?Q?WrSsQJ22BM75MSen0JQpCYr1pjKkVRy+Ctzx1JjOrISoLj6bwhBrMGFKwd3u?=
 =?us-ascii?Q?lruXx5gOj1QP9IgyDSw+cx2WWeMMyUCYGyusv3FB+DTp+B/0X/FU2tzvd+UJ?=
 =?us-ascii?Q?I6P9Ju5/AZgvFaP7zbJ1nRUUnBFYjQ03IEemWTpQWJC8mP9K7o2MRxfJLnxT?=
 =?us-ascii?Q?sqLhhZke6VooJDeJXSMC913jxOpTL5njT3JLWo+EvM1A3a0RBDeZb4rf5xnW?=
 =?us-ascii?Q?uKMcnj/ugD9CrbBwvUNaTFITZhZXyXd9LxGQt8aw3sverf72/2ITDrhzOyK3?=
 =?us-ascii?Q?0jdkFoelpTeIenuyQmYlfDntD5ECiisLHg/MQGMJEVFwIb8yPT0Z5/KidRs/?=
 =?us-ascii?Q?YEMP+MtNnq3YIdKIHYmQcFOqSI5vExhnwbQg/PcSpWpfZ9HHI5pmfo+cb6de?=
 =?us-ascii?Q?e4wQI3MMRJdl20IypDBNU3PrqiA03rYRG0WfU3IyZDF3+IhM1cPoZc+d9JyJ?=
 =?us-ascii?Q?t2p+cZOlElaBbb5tt7HeIZ+W0lK4SADrTVm6ShKytEhSEneL69ycloluBoil?=
 =?us-ascii?Q?3/ImWplQxW2tx64CEbXKdKTihXy8B9gNgfdzU4L3/rJekAoWtcHE6ABsyQQ9?=
 =?us-ascii?Q?x470VJ4d+JMdvnxJvsMvJ6fLhhgvReZ1LeXfew6SeOFg/JuyJkXYfv1frFf0?=
 =?us-ascii?Q?l3GlKkth8aS0j5oVFSLU5mwtoCzwhcFa7ks8bbzUBIvLF8PYbvcNQOnRi/Ir?=
 =?us-ascii?Q?6DI39R4nMpXT4eJgrWxc9m/b0jMmPqjwA2/jrj3U8aeoj5kfduw4XdTZU2Cr?=
 =?us-ascii?Q?JSkaLJ+LqqEyQ3GP7L3ehmStuNvtx2Jgd6xDbtDk9oKOha2VbI9AXJH7j7Ij?=
 =?us-ascii?Q?TDjVituXv2jGmnyLB7oZO6FKJOrEG5t5v6Tof79JP3Fxjz8QduyioQdN5xmR?=
 =?us-ascii?Q?8hNDHiEEP7xxmtjFhNPIWNqk0pnyJWG2259Gxl+l9GUnZxU74uVMFjbC79vq?=
 =?us-ascii?Q?R22Gg/9J4z9CTOo9JcCpgHZ9uW9Kqhx2h4UfLwZ78nioTZua6j4FQX0z2Xkk?=
 =?us-ascii?Q?nWR3q4jCkQiHKESYW0vy0FJ0MXUc1Y428xUfjk/5bFINCu0YhW174bLSW2qP?=
 =?us-ascii?Q?ZWuOR08HMl/QxgIlv8by3Cq6Qw53cRsoy4VzqujsifPTNHuUgmOaibgZPF6g?=
 =?us-ascii?Q?l7zhGPO+MXKo9+0IsWZq6Z8VzuB9MRn6zPFyq7ujreSS/xkJW7hTu3IkrEnR?=
 =?us-ascii?Q?e59LXx9o0NikMWKqoNOxGkW5n6/iC02ywOTDacx2iOVVk4wtf/150rF8TOHT?=
 =?us-ascii?Q?mkWjWm4rHpRpw7wjf9aKywMO627skKU8vmOy3XW4y5CoXC3S0G3yyZEw94GV?=
 =?us-ascii?Q?NC9jaDwzD1MOcJdJRvTdT+LW2obh08z7j/1w2bLMNMrH1D2lJwyEsoEidZ38?=
 =?us-ascii?Q?VmLL4ckXoIyB06PLtWHBL4/9WylFpy2uJovovT9E?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1818bfa1-0230-4598-2a0d-08db3b03976a
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 03:11:21.6637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xDYqbIOGsFsPhtZY5tqOE7AVrX5F0LxSZFBlZgsrMkrsODFAvGX+8pIbkn3fgO+pedinxNUWeQ+de6IrurFSZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5777
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

It is better not to directly access the internal members of the
kobject object, especially kobject_init_and_add() may failure.
BTW remove unnecessary kobject_del(), kobject_put() actually covers
kobject removal automatically, which is single stage removal.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/erofs/internal.h | 1 +
 fs/erofs/sysfs.c    | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index f675050af2bb..f364b1e9b35b 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -177,6 +177,7 @@ struct erofs_sb_info {
 	/* sysfs support */
 	struct kobject s_kobj;		/* /sys/fs/erofs/<devname> */
 	struct completion s_kobj_unregister;
+	bool sysfs_registered;
 
 	/* fscache support */
 	struct fscache_volume *volume;
diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
index 435e515c0792..c38018d3c442 100644
--- a/fs/erofs/sysfs.c
+++ b/fs/erofs/sysfs.c
@@ -228,6 +228,7 @@ int erofs_register_sysfs(struct super_block *sb)
 	kfree(str);
 	if (err)
 		goto put_sb_kobj;
+	sbi->sysfs_registered = true;
 	return 0;
 
 put_sb_kobj:
@@ -240,8 +241,7 @@ void erofs_unregister_sysfs(struct super_block *sb)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 
-	if (sbi->s_kobj.state_in_sysfs) {
-		kobject_del(&sbi->s_kobj);
+	if (sbi->sysfs_registered) {
 		kobject_put(&sbi->s_kobj);
 		wait_for_completion(&sbi->s_kobj_unregister);
 	}
-- 
2.35.1

