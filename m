Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BDA4649A3
	for <lists+linux-erofs@lfdr.de>; Wed,  1 Dec 2021 09:28:47 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4J3sgK2Lg8z2yng
	for <lists+linux-erofs@lfdr.de>; Wed,  1 Dec 2021 19:28:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1638347325;
	bh=4k3vfgzKWkgNJT6FkI1rWd5HQN6P7t9q83ZWvRYgk+w=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=KzQyZf1f8l+E9b12LasGjJ5Zvq0oR8uWgzUfQd2oiKJD+8jqlATdMWjQI1+61UKuj
	 XAXBL4+D9jadUV6FqzRZccbfvzYVnKVRt9FYatILharqdEwVrcPzgE45QZH8Z3pXmd
	 iWFtnMB+2l+XLG+YLPMcVh4BN84tu20yaCjWpmzaie15+1fmixDW9KV8OP/063lMNM
	 VO1mKeJHB5uZw71DWX4RQMyJeZ2HATniIGd+UFbhTA67OAq8WFGsAl8G5tHgXI2vxH
	 QawNO48IhvqbEizUvznBnCWKva/dt3kZwmny0sCuH9IxMpGQepsM/hMjEYa0CVClLm
	 CXV9YkTIaD0/w==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.215.52;
 helo=apc01-sg2-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256
 header.s=selector1 header.b=Kq+huXWG; 
 dkim-atps=neutral
Received: from APC01-SG2-obe.outbound.protection.outlook.com
 (mail-sgaapc01on2052.outbound.protection.outlook.com [40.107.215.52])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4J3sg81S7gz2xXV
 for <linux-erofs@lists.ozlabs.org>; Wed,  1 Dec 2021 19:28:32 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=np2LomFcUdyhrct+8atfjeq7sM5oMv8ZwxhrbwkfHfBisq/O6aDYe/cDjH1UqeDMSpTg8555ZrecgOEwK0ok5lnCBIJqbnJb8+0GS0PIpjsv64hGp+QgL73YSOB/XG0+f+G50q/6o394oqxvpeu2Uk3s/fy2XWhtw7cby7MgMqWJdJ9BvA5uhz4viwB8tnQAkALo1w0gENoloF1bCD4KCjmYhL6FwUJ4yDL2WgH9DOBL0GMh5H+X+130PNvlVesVG863TRQd85aWjkGC94hQCPnXe1NdalA/T04gJPE6KUdH5DVlx4aRDe4G/p9BeJC5IoF4+RkZtmpB7ZxxelMYeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4k3vfgzKWkgNJT6FkI1rWd5HQN6P7t9q83ZWvRYgk+w=;
 b=aBllEcMCY5u75UM60u4pIUfIqdwXMO0Ub1zmdd2spQgqQSe9JEdrBaMdIxzC2N2pdptJ75Ahi8DdVdBncqdImSaO+z9gQXIH4AUzuMKLGbv9D/fUadcHlwNtUEiq586kYmxPLzE5Uf3sn61RSHeNEgvezyQ6/fvlEJTBy9f3HGLg++U91L4yQ7oQPpsKPLyU2WTnh8poi4HOlV2yrEr/kosTKzv3/xhxWlsal2AQp6pG0/LpA7dsY9WWSW05ayFV3LC1EP6qUv4Xwz55qJd3J3JQX/ExGZ8iHd5onA6G8pMjOljp84TU7xuH7pGcjiTUE7wb+7WbesRjv+lHvKxEuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB3116.apcprd02.prod.outlook.com (2603:1096:4:59::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.23; Wed, 1 Dec 2021 08:28:09 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::12a:f861:9ae2:b8f0]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::12a:f861:9ae2:b8f0%5]) with mapi id 15.20.4734.024; Wed, 1 Dec 2021
 08:28:09 +0000
To: linux-erofs@lists.ozlabs.org,
	xiang@kernel.org
Subject: [PATCH] erofs-utils: update AUTHORS
Date: Wed,  1 Dec 2021 16:27:46 +0800
Message-Id: <20211201082746.1642-1-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0013.apcprd06.prod.outlook.com
 (2603:1096:202:2e::25) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
Received: from PC80253450.adc.com (58.252.5.73) by
 HK2PR06CA0013.apcprd06.prod.outlook.com (2603:1096:202:2e::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.23 via Frontend Transport; Wed, 1 Dec 2021 08:28:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2376dd0a-7ae2-4737-3c90-08d9b4a481ce
X-MS-TrafficTypeDiagnostic: SG2PR02MB3116:
X-Microsoft-Antispam-PRVS: <SG2PR02MB31166AB7C703678CABB51C5EC3689@SG2PR02MB3116.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:849;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JCzexfvPhsWifMS9bBu84h2z8jEDIMhZjpFuTeis3FdQtrmI4vHoaY074oLeSL1eXFp9BXOPSECNAzMjAmxtvg9HA6Bt/7+/7Lh4Zk/RagGEmH2GHMlDjvbIKPSjtwMg5RhmpO2opkuMJFbJOKdv0CoWCIpqCg98gY6asqUNCQr/AmaALhzHGQQ4lJEtskB06mEqYuWJJ2N14QQW+T/j6VIq3ZAHq9XvUAwD5z3TBlW15Bn7YSeYeEq3Ax9kwPMYZjN5acIovmKQ/QSpyKiMnEao2N4H/+XKQjx2eZ6xYrTDWUVSJv9pAX5TPSU/UGSZAPdW+udcvDgVz8dkc8s/vBYK5QBsCD/HOWMqkH2AJWQIii7tDitf0RA6Y6bFjNmTruXkbdMKJIcArHisWOFKr0H/hAU14Q/gN2d3g+08Z9efzAp9Moq9hC4vhM3i9p6ZaBhQCnHsbqSb+NSZOHmqdCIMtpWSU1KyRE06YFpQ+lyc7/YmGWG2Tmf1jE/Sy6gQnzlx+/VpxsmNSJ2djbl1bWHHMaheICMW9vbnZBgDTDwQKbuMb//L8YC3vGFed7R/0Y4XnzerpkQYGawz1fahVhVSeCEuGLbHHjITIIjwSVf7Q3/ZSBkpbTAeTay3vzz9/PCIHtry7cYaRxF73daj9WvM07dkGhnlg60QIc50III58BzEW4w5lyUzEZy9K7RXl/oIuy3awE9djdJNnEoCvehtVp4XM3hNlW+Y/eqTnmw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6486002)(107886003)(2616005)(5660300002)(4744005)(86362001)(6666004)(508600001)(38350700002)(6506007)(52116002)(4326008)(8936002)(66556008)(38100700002)(956004)(2906002)(8676002)(36756003)(186003)(26005)(1076003)(316002)(6512007)(66476007)(66946007)(11606007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tAO+/axyqIqDXtKjIc27B+UwNOF2zpbpwsw2ru0xWvbMt/sYjLYlZ+/shld2?=
 =?us-ascii?Q?+6cQO6OnhneQyFi4MPEFhrnsmmouEARXhEMwrvB7AJVrH72ZXHDN5Wp4pLpT?=
 =?us-ascii?Q?KaWlQF9Dqp1cVz4rk+dQU0Yk9q1vixxtUZZugZr4m/lNH9vCMtuiGJbdMHV0?=
 =?us-ascii?Q?gf4xNthr7nlthYPs9BXje0SRZVVNSUlTw1S7g3Zjh4XkygVh6sDOYOmHUDm5?=
 =?us-ascii?Q?vNUc0yMg9bSzEg1lJD2TtG1B0stAJZEjmH5Z23wMC4BsmJfaFpuOBZ6V8U5f?=
 =?us-ascii?Q?w0MFVV7jGmfX8cjppwLN1SfQYC+NAHuaKPDmEe7SGrB7A6GdmM6BGayaMGnZ?=
 =?us-ascii?Q?nHKqKnXDwFDCQyemp0enw1odHlfU0M65LRNP+FHWkhOOMwjrfaW0/MdICi5A?=
 =?us-ascii?Q?8Ym2Ut3dfzjH0dKVQImw688vB4kyI2ZHo40GTHjyIDvEOitkDnNFPVyhFwCA?=
 =?us-ascii?Q?q0b7Vp2HBd7iyWTQXJKCGNlkO68ImahPfSA/DI0W3u3O0xBkK0LU2o37s4+N?=
 =?us-ascii?Q?S6CTE0OR6xmC0lY7dMpVXHR+TYoHa1O45ueySzoNjCw2ivK42b9pPM+cH/EI?=
 =?us-ascii?Q?0EaEQP1fyHvySh2hUXSfyd0tCiUUNv2+g78m/AX8Rf8VfcTHGlTRnp3tUgzJ?=
 =?us-ascii?Q?aQtY6PHoVxiJfYJSeiQT75ICVxYdYVFiPsiYZwMMueBJFTXKsfo7kNLWZH9e?=
 =?us-ascii?Q?sMXGlGEguNtU29hzW8+UwkDby6bxo3+RjdNeCzzDVdLWzKMUr7XGmOWgFCU1?=
 =?us-ascii?Q?Xc6XkWWaCexjLUPQB4LRpekfS00OTO87RhCmno6dYrBl3hBCQcnib+80oikX?=
 =?us-ascii?Q?0BY/yi1lMDUJMe+Dq6y0ejgw3X7doWZ0UjNJqHiFXeDR8J57nU59XEJe+qmC?=
 =?us-ascii?Q?boHJhTnQiTi1Y3nd69VJG1XFlsDi0/bKngyfPb2DpaM+F44iOHIHHwwbleIq?=
 =?us-ascii?Q?pVNMENipEwvbbQ4muTooVRTLejtl2/43MVNl3oAO9PRL3pNPDlUabiV9Xwdh?=
 =?us-ascii?Q?9ZeUsfhdPhcLnZc3Zxp/na9kH8GMwo/nti42YI51SPy/qnE0PSQTMcP7OErS?=
 =?us-ascii?Q?feRAxjndWTkfFspFBimxgoBCKunnDDOFrVSANQ1Htt2F1YXz2kY63Gh+nRV7?=
 =?us-ascii?Q?EWjWfn12NNfYtRvZE/yBKmuf5EgKCNqF8+88t6nTOXvy5PKyn/c4O1A0FE6e?=
 =?us-ascii?Q?PjODAA6bS54wkdsv03UCZXD16P4pxVz4mN+oMKzyh6+gPN33zSyqQUvdyhL0?=
 =?us-ascii?Q?gkS8dz3IRz5zS3EaRQMc1xmmVCh3gIScMsCxhuzbUVxgQed4kpqra3bgewoO?=
 =?us-ascii?Q?pAT+QSeEo+nYS8vcTNgf4EOi/qlAgQBqeMU81WM0c7DYALSFAfzeJ+ub8kIU?=
 =?us-ascii?Q?J4AfOKFxgbn4iZEiQEfk6sG2tTeFlhd6VGOhdqNhdisMt70iAy+G6lszhibi?=
 =?us-ascii?Q?Ec4trnuMAXYahtJzWcjhM2vhJ+1T5kpFiIhz87D78ABsdJDDUqHsAIutYLPa?=
 =?us-ascii?Q?U3P17yZP3LnsJZ6bTMKrk3S70t0GUfI92Izh3Rrt89VZORb4jt95NsjgYYgw?=
 =?us-ascii?Q?5npQnxaLMIzjDPc17O7aO9tNhYyOuARXrQZaTZ6UEcJmUnky19ebL6guiS49?=
 =?us-ascii?Q?sBVwfBsZE0+pewd5xQlPySU=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2376dd0a-7ae2-4737-3c90-08d9b4a481ce
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 08:28:09.6757 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dZuA0t02FT4GFLLLwcM3pEVOM/Tzyck3drnAyMR3eq2jKbDBuguGMsGgyTXqgNfnd86k5ZdeWGTUvROVrhNKeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB3116
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
From: Huang Jianan via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Huang Jianan <huangjianan@oppo.com>
Cc: zhangshiming@oppo.com, yh@oppo.com, guanyuwei@oppo.com, guoweichao@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Add myself to the AUTHORS file.

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
---
 AUTHORS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/AUTHORS b/AUTHORS
index 812042a..6b41df8 100644
--- a/AUTHORS
+++ b/AUTHORS
@@ -1,6 +1,7 @@
 EROFS USERSPACE UTILITIES
 M: Li Guifu <bluce.lee@aliyun.com>
 M: Gao Xiang <xiang@kernel.org>
+M: Huang Jianan <huangjianan@oppo.com>
 R: Chao Yu <chao@kernel.org>
 R: Miao Xie <miaoxie@huawei.com>
 R: Fang Wei <fangwei1@huawei.com>
-- 
2.25.1

