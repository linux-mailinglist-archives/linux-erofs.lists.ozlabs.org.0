Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBDF821DA0
	for <lists+linux-erofs@lfdr.de>; Tue,  2 Jan 2024 15:29:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1704205761;
	bh=nO208LISpLMPfA8dmtTuEXhY9uFYF07kLTA7MyFiVak=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=oBtfwnfXgTVy+8QCyiutnd1d6fxv7v/x6SK4+nOKBK1w/9U9qBsb0bFCYFDFsNOAp
	 rUDTqQfjkT5XyEwH98wHBnAm35EQBdjOin6e3aL21cKJgr/quD0VF6XT1drKPWl8Iy
	 njoeJW7By21mDyBwPEzJlnUikhZ2HFGWQTTlbmALkhwcBudCkE25KJ2mv/r/ZddVyY
	 r+FiLihWO1zieLHAiNb6lOCObFHEpquEcuYzgJw4LCRoyaA6qY7oLofTkpKoqZh5sJ
	 tzzCF0khN5X+rOXY7FxHvukWJHOibmzO2vujpTo6BN/SNB2c8WBtvJ7sRsBpR6u4YS
	 2kg6nVVEkMKrA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4T4Fbj552Zz3bn8
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Jan 2024 01:29:21 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=UKDUnrGC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f400:feae::711; helo=apc01-psa-obe.outbound.protection.outlook.com; envelope-from=guochunhai@vivo.com; receiver=lists.ozlabs.org)
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on20711.outbound.protection.outlook.com [IPv6:2a01:111:f400:feae::711])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4T4Fbb4BR4z2ydW
	for <linux-erofs@lists.ozlabs.org>; Wed,  3 Jan 2024 01:29:14 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Co16FdlUOwiVlvTUpMsqyIYpB31PRZXobGRh97g9X29QGG23GMIWYX7j8KfmfOs488URyikNfwnv3TO8kmuUwIn6e+1ICFnBKaVCPQUkRk4eDbPfk56nkC54AHBukZUWNZyxD0UTPGrc77Uu564AxcBc52vn7V7j74pUdRTtl7dssgytpgDy9eeyKQ3fQXl6+8PQT0vhPqNweshOi7QnRiYC/rajE+JIQwMCQfmc7y6MStDX5qfH/wnoIJU/iFMsy6r9HOV7GfCTIroqn1yrI7uNfuODCAFo5Z6G7RPZPIsYowRKKadO9jrlVwrZI+hdvfex4IoVm96DNisJNPBDJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nO208LISpLMPfA8dmtTuEXhY9uFYF07kLTA7MyFiVak=;
 b=OMs6wMzlx7K3H1VyeFcH680xkj9dwzIUXQPwVt2EaEXfGKHWW9qCUCFY4AAEdHG9ejmpMgPs9vTMSdKqlkrdT+Cdigg/SZCNRTaPCJajycTosfqaUABHe/I/240RAhDhFn9OQT+34UtrPUgaN4NFf6hh5SoDRADjI+vF47HofUCTUOtoyE2XR0jbtZk8zjXwWZE3oFuN24TYyrpp8gkPyMZ/KQWzGLyJ0VyOzt9xCKhGvtLjePu/s6rMJ6poMbVITbiMBtxW6B/CoztQWuCmuxo/Hc+jajVli+afo7rjskTRfx80Sb12Np2Qcxsu6viHLmI5L092dNRECCiYO+V7bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TY2PR06MB3342.apcprd06.prod.outlook.com (2603:1096:404:fb::23)
 by KL1PR0601MB3892.apcprd06.prod.outlook.com (2603:1096:820:32::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Tue, 2 Jan
 2024 14:28:52 +0000
Received: from TY2PR06MB3342.apcprd06.prod.outlook.com
 ([fe80::b403:721d:ec13:d457]) by TY2PR06MB3342.apcprd06.prod.outlook.com
 ([fe80::b403:721d:ec13:d457%5]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 14:28:52 +0000
To: xiang@kernel.org
Subject: [PATCH] erofs: make erofs_err() and erofs_info() support NULL sb parameter
Date: Tue,  2 Jan 2024 07:37:45 -0700
Message-Id: <20240102143745.2880560-1-guochunhai@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0028.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::15)
 To TY2PR06MB3342.apcprd06.prod.outlook.com (2603:1096:404:fb::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PR06MB3342:EE_|KL1PR0601MB3892:EE_
X-MS-Office365-Filtering-Correlation-Id: 20e0a896-2601-44a6-6112-08dc0b9f246a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	sAs0cPNyqJu7HJ4JPrmW40FeRMM0mtj2sImjap7B+gxrt5O2MqPCmmwRHWufw8wdwJjtFNoL7uNmMFkVy+CC1kT65JE3VOqO9fKJEbsAyX/Nx6UkoBo0t8qa4dQIxyR+0SQnAduAefQ3fYs7jxEO63EIgWcnNnYhg8skSDDIgjPWGkZ5nE827FxjJbaTwrTl6UrxYy30v+7sJrMh80//EGfATPYyrpnin5qfYlnmEQwVx6YzJrKfOJOrchAUo6ro8nJQAm11ylRe5ezWGu03IkZauAtemJ/Hbj9IUkPxnrulFSjSa39La3vOX5V9ePCK3zTiyQMthGGmcW825hyf+JEDewmhFAuCYcEyVMtOAzlVODQC2IbNpcuS+p7JKdyVtI77OD/ZoLFg/ielmMXeQYp1WcwlQZMPoFysP/sAOZzKdXtVpQoLliQ8xunLxg+xYCuOeW7rAnHVLoRiw3vsIXfuTSuCmt7yhbHSBXdNb5+smZWxcsc2+tbCaLbatbGt73lxiFzxPPHb+lWn6auCqkF2fEjp+KpKdrIhBLE6NzngK5wkgcuWvIDaWLIan1G3eohG9Ic+O+7aGhpyURq/I+dz48rzSUIo5PvOSlMp+vVIBgJCLRvxsS8bFAwotwJj
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3342.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(366004)(39860400002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(6506007)(52116002)(4326008)(6666004)(2906002)(6512007)(4744005)(5660300002)(6916009)(66476007)(66556008)(66946007)(6486002)(478600001)(8676002)(8936002)(316002)(41300700001)(38100700002)(86362001)(36756003)(38350700005)(26005)(1076003)(83380400001)(2616005)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?56zDVatsrM4Clxgi0nHrNkTIygAnrOG9FrvT6eLZxNSWZxU6Ei5m7jO2jYmn?=
 =?us-ascii?Q?E0fQ1b8itBtMgfc/lRn+VqrfMjqQwrOd5lZZkvbnDQxaP7rR7rSCNDCPRocu?=
 =?us-ascii?Q?2yKdf/ue3fkjpE6w9jqlpkpdEdPrvwm4aT+aH23pT9YIIEChjJNPNOqBPHgr?=
 =?us-ascii?Q?OJ/wRq8i1IhY5aWsVzvAAQ3hVmjwb4JoZCQF/UOyDNq5VFVICae2/DQByu1K?=
 =?us-ascii?Q?PaYtO3bIeNVuOzAHiAFZx3gmEoKKy1m/sSin9jPl3Ghay7WSUgN1ztMZK7Cd?=
 =?us-ascii?Q?vgIUpb36bbsxh5jTUa48BVa0kYyFvt5dflwLUpB8XjeHoI8YdhVnVyHnCkPk?=
 =?us-ascii?Q?A1SsUKW3EoRuq/mnA5/Rv4yiTWDQwMsghvf709gSkMCeWEmazOLBxF8BF/7V?=
 =?us-ascii?Q?RhuK2Cgk0mpll4jrXb2n6MYNMAg53R7oQXZFfmqtdFn8q3SyJvz0z5u4lG5r?=
 =?us-ascii?Q?EcHe4YhzyQZivuYiMamqCjWOfiQ6woHnkGqWPKbqvFnJAQui8IEjMZK2xU1C?=
 =?us-ascii?Q?343L06sAKkjagZqoiZYejoiBB32MNXsoOIXtEl2OYgyY33WweepK7ZuoZo3G?=
 =?us-ascii?Q?Ok/UeJxiCOqMz/3MS5a+s0D7fS//49irrYaJ9YrqWScKlPWeWP1LnQQhHSQZ?=
 =?us-ascii?Q?NKZLYNQecqlPWW52uUtuemZGMxaEemwLJ+O8QLRLK7c4slq/ElzX13+htsTL?=
 =?us-ascii?Q?chW4SYUYGi0/H/qOgNHfoLNu6VU0DI7JGOl6KJU0ioSAKD1rsyvLVCnUdO1l?=
 =?us-ascii?Q?moSUxZ3ggFqk6dHKPA5CN/GvxCUuyovvj9733JZ/IZa9Nb7aUS5XFHSlPH95?=
 =?us-ascii?Q?W0UzAbjPeXI4rVxGalWJhprcYsETweoBgOKqnSZeXjEp1/dvrsjHTEPwORhI?=
 =?us-ascii?Q?IVWxDo3fYuj1nBehcd/kILAIbM2rMU8U1kBibx3VbTG8cqcPCSeN/XcFRaoK?=
 =?us-ascii?Q?+fhiZOVFFvdWAHZgcFpprDvHGphTO2OwWlx/7SPV0beyhlwqZEgIxk/xdyhe?=
 =?us-ascii?Q?mCO4xO5KimV4mmR4W3jn1nswbF0UmddM/rjPkNurHG0TkOSfhauB0D5guX5u?=
 =?us-ascii?Q?OdsXRtGL0rjpNOVyiDDA2JY+FeXhGCTGxc/QiUSucAD7VFBtol4ADjqHMKRA?=
 =?us-ascii?Q?CYe8T3YmUcJSgKsGs49uQqWEKl+agnij1QMNDm/FCgqppOjz6RhTq/r3Bpyy?=
 =?us-ascii?Q?jp1zflqhyDZHqwCAg4NBoF2D2w6Ba2ZJO4+ECL3kPohE95TSSOicFWYTGIkk?=
 =?us-ascii?Q?3Wzp8UJJDzc2cGvmLHWd93Yhk1PVHxdwaHelJEvleHHTt1nZ7vnO9qLVM8xT?=
 =?us-ascii?Q?hhDb6qVP5x4fHciAUbO2GY9vyDd5pd6c/kjzLDkW6QuNO8sKibjXtz8ZM+Fz?=
 =?us-ascii?Q?ExoXKVcDWuBH5FJmHjbnmFnkMPM2bFjgLL906j4VuOFAfj1VUyK/zXRvEcwT?=
 =?us-ascii?Q?rma+1qIZE9peUu000h6sgPXqFE2ZEBK8UwNPCTSINw0QxPhj6vRqvil5JgUD?=
 =?us-ascii?Q?15WZQPU2oRXM+uGHYdRUSqcgLuY5NQsdldoSHBvhcOA8FHJzHbwRSnE0yVSd?=
 =?us-ascii?Q?2DjlLglpW8Uq8KHaVIMLgz8n5q/bneHy0HPWCcc9?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20e0a896-2601-44a6-6112-08dc0b9f246a
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3342.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 14:28:52.2172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w0NgjkwrdS+xrUKGCONthT6BcS6dkR3q6eYfuDb8yS4O540Bz+ZQ2IjQCsdr+KfApPE+UANVXq104/EHKrpLUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB3892
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
From: Chunhai Guo via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Chunhai Guo <guochunhai@vivo.com>
Cc: Chunhai Guo <guochunhai@vivo.com>, linux-erofs@lists.ozlabs.org, huyue2@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Make erofs_err() and erofs_info() support NULL sb parameter for more
general usage.

Suggested-by: Gao Xiang <xiang@kernel.org>
Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
---
 fs/erofs/super.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 3789d6224513..96a9d19de96b 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -27,7 +27,11 @@ void _erofs_err(struct super_block *sb, const char *func, const char *fmt, ...)
 	vaf.fmt = fmt;
 	vaf.va = &args;
 
-	pr_err("(device %s): %s: %pV", sb->s_id, func, &vaf);
+	if (sb)
+		pr_err("(device %s): %s: %pV", sb->s_id, func, &vaf);
+	else
+		pr_err("%s: %pV", func, &vaf);
+
 	va_end(args);
 }
 
@@ -41,7 +45,10 @@ void _erofs_info(struct super_block *sb, const char *func, const char *fmt, ...)
 	vaf.fmt = fmt;
 	vaf.va = &args;
 
-	pr_info("(device %s): %pV", sb->s_id, &vaf);
+	if (sb)
+		pr_info("(device %s): %pV", sb->s_id, &vaf);
+	else
+		pr_info("%pV", &vaf);
 	va_end(args);
 }
 
-- 
2.25.1

