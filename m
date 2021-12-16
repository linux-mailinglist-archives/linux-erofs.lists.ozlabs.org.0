Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B024767BE
	for <lists+linux-erofs@lfdr.de>; Thu, 16 Dec 2021 03:10:18 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JDwYh5LJ0z2yph
	for <lists+linux-erofs@lfdr.de>; Thu, 16 Dec 2021 13:10:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1639620616;
	bh=W4f8Njg1ct1LXQP2VUDJR/dLoxgfN8bHq+mbIY7ScRQ=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=akOOKOuLxKrXXmGos/OkImPQ28VaYueWgp4WFktv8Pp6mmkBZ5lbbIwVDy1XiDTln
	 Oab8SsoFlJk84qB4AUcMG3Nl+E767GtlemF6t0e7M3Dy5AcF/TE9bcQEW3IITgdkSN
	 QnpbyhqIcsDmz3+Q4A4ljyKgAkVVtGjAogokv4XU5wrm0GZN7hHbIRRHeW1lNr093J
	 4cTHeJpbNBw1m+FI9uwYaJ4osEQVm00d3A72RzmsYEscks8beYcXgAWS/5MT6yPSN4
	 yQKzsjrBxEf1NrSRjBI58GeukOjCIVgDSqJprgMMhPv5aEpXhCXqVL/0O/UNa+ZdN/
	 +LfMieJoM3y9A==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=2a01:111:f400:febc::602;
 helo=apc01-hk2-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256
 header.s=selector1 header.b=PVT5myJC; 
 dkim-atps=neutral
Received: from APC01-HK2-obe.outbound.protection.outlook.com
 (mail-hk2apc01on0602.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:febc::602])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JDwYX5jKGz2yRf
 for <linux-erofs@lists.ozlabs.org>; Thu, 16 Dec 2021 13:10:05 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fifPwce0UFWmmZLOc0fGOCtz3/BLUwnqHNtGmYLMpYDV3uRA2Y1SP8LaU4gFHj0u+a4K77Dm/+Gty307mfjIUx8FUvA4C/mlhsppfpbJ+OuwLJ6YaSwn3eh7wR8TBF+RtMN4EVc7MB2xM55l+VdC/jnrtCEya79dvc3WjEHS7280E24ySDgHEluZi7Sa7f+eNReqHF5WOwK84/+dHaUDUHND2QDLf6bjnez8k2f9OoGUoR5XTrXPf832qf+dRqf/Fp0PJeWvZRgWyhKGs0nwQips4FEtvAKL33WAp4iNV3LwI7VIiReR80AsUZZDmPvOyBMTNTiaGI3lr5ZtLv0eKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W4f8Njg1ct1LXQP2VUDJR/dLoxgfN8bHq+mbIY7ScRQ=;
 b=ZQg/DVBOoY0XZTR30yy5gYVpwFsOa9LiwQu8VL/NSvQuJ2h8PnHE8EYSC99zASwWt6hk1iBN4NsPAGLEVvNtIkv6KXJNGslrbEF4MNj91/EkHCBMECtLEp70Jo6B9J6YvmEyGVPmvib4XhhUmmAu6xDoX03BWew/79ZFsiey/NW0ORVZMYuaejZt3+j6WY+LM0S2XDe/XkKDJG7uGBcU/fvA3rmXX74qykIk5gGrLWWwL+JvYaFWpcAIqSJkwNv9qSQAADey+1Vp3GOrPEqM194pP5jC77gC/o5Y+PIv082IxiWsHTiIea/9lNZbUZVI69zxFQYZW4dSCWwSW9pxBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB2382.apcprd02.prod.outlook.com (2603:1096:3:1c::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.17; Thu, 16 Dec 2021 02:09:43 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::3032:4149:e5d7:982a]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::3032:4149:e5d7:982a%3]) with mapi id 15.20.4778.018; Thu, 16 Dec 2021
 02:09:43 +0000
To: linux-erofs@lists.ozlabs.org,
	hsiangkao@linux.alibaba.com
Subject: [PATCH v3] erofs-utils: sort shared xattr
Date: Thu, 16 Dec 2021 10:09:25 +0800
Message-Id: <20211216020925.24963-1-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <f96bfbdc-86f8-0dab-ae05-a6c32a87a7c0@oppo.coml>
References: <f96bfbdc-86f8-0dab-ae05-a6c32a87a7c0@oppo.coml>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0178.apcprd06.prod.outlook.com
 (2603:1096:1:1e::32) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71fa18b6-26e6-4ba7-33f8-08d9c0391fe4
X-MS-TrafficTypeDiagnostic: SG2PR02MB2382:EE_
X-Microsoft-Antispam-PRVS: <SG2PR02MB2382409B25CACBCDAFD2BCBEC3779@SG2PR02MB2382.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3AsutwrIGvWwOaQ6xzks+1cya59NONX3g5FtuozW5TIzUf7Md4yyGyZq/fRYbXTmZCM9dQn8SjKlzQv09MrL9GS9+8tDkXVspSk2hgwN9Tq9+lq8mBRy+kM5VZRdKgopahKAMdNdR5XMK3mcfQz2q6Fo/edrrrMamIxVsrNZN5YLw43Q70QvhkMp64T+7UGK0PRwyblZKC7E7MD96oVBlNa7t2EfH/pUTgD1494hdyIN8QhAlBhOeGiJ/6NQOVCOhQiVkqUDCywUN6Qfof17V0tbCWV6PFJdusQL1JKOH6eZD+aosI3+a/vRoZGO4ZGkyRijehR/axalYEq5+ljeXILRGVfvVtwei9NBf2YJwFSSuqEvFICIMYtvlk66LHfGvNfgTKIW5IK2zKEYOH5xHYpAwSXfHuBYcHG6jcTXmjZe/HKESrPMCpQOI4AttAhSa0yvI4Ef8fPLFta8KMReHCUKmeoKhZmh7sv9sFfPRA2mAPX/ljEnMpe0MAbyQGPjNiWLgviUviHpZeB24oWVGWLpRLY8zoMH5jLCQQdgjdoUoXVm4uedb5c3B7wAC8xIxw+C/7KRDF+/0sD1vhRTBrRn/TcTeLWd4CsOCJKXQONADoI5BhtDYAnRgAfnm6m8UhClx40KneE2l+Z59OxNMUsiJOwIpfvjfHXEjeZOCeQXUjCgxi+EtLhk2WsR+ELvoGhNoHx9XJr2E6GrFIc2HDYnLXAARgTwgtfLs7Jr44I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(107886003)(6512007)(86362001)(6506007)(1076003)(26005)(52116002)(2906002)(4326008)(66556008)(508600001)(8936002)(38350700002)(36756003)(38100700002)(5660300002)(6486002)(8676002)(316002)(66946007)(66476007)(6666004)(186003)(2616005)(83380400001)(11606007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?olLROdqHTsDGQqJ9lRbQ2jFgw1vC1ucmwcVBxFEY0Dbb0mj8Nl5TmqkqmMZQ?=
 =?us-ascii?Q?9yPgoqcsZhFRs3K176olxgoLvO1I0pDZCrro6yXS8ue/VvLD5KyJHZsWjp3x?=
 =?us-ascii?Q?Yd79lwSJMtU03j6/5pRksYQvVQHOFjnIyl8IyVDbU+y/ghBRm9MoYd5qX9qN?=
 =?us-ascii?Q?+XJf2y79B1NXMlk2Z4/yT8PXm6ZTqugIzpQ19e4uuVJmeSGKi0St9HO/K26h?=
 =?us-ascii?Q?X6aQmRaPNIrbJlIkI3DR1Sz0xzkzXxomusWFdFe4J59v/8axiU3N4n+GoZeD?=
 =?us-ascii?Q?xHoPFBZPGyhM9as3R3RugCIqnujttcAcy9Z0PkSu/bUdGyMI6Dqg/wDcicxZ?=
 =?us-ascii?Q?qiXEuSb+HUXZzy4xocpPhn7WbNaXWHk5owK7d5KYuAVpDi2NeJK48qCtvMXx?=
 =?us-ascii?Q?TB+ysu5AhfZs7Gi++PeTLq3MgVPUBiwZPQ9+CVc2uTODFAUdNK+Y69OxWr7C?=
 =?us-ascii?Q?pWXx8SZXQ/nJN6q64L2xZAUc6OL04nakw4xzCjjYQe6EuMgi5dj1Fl1eu/2R?=
 =?us-ascii?Q?zjLF3oxKqceeph0jCrH1C3rc0L5totj29+OqnYxYzH3uMr86gHtBx0XSGq50?=
 =?us-ascii?Q?xDX9/sgvPn+jcgqiqvBkAcL1GT/ZfRp5Qh3lrtmVmJVwFVVs0kI5dEUwPfYL?=
 =?us-ascii?Q?blgrk50yCDVUpI4AkbESa7+bPqnJgpqAZqvdFaVUPTKyvngE52vjwU9cW1fm?=
 =?us-ascii?Q?vOwYyGs2eGKRlUoIfYyItTgOQ3mu5NtGAYUNvQ0DyLBUi4qUgFIVt145gCU0?=
 =?us-ascii?Q?/EVm8kOoa9yaoIpItf8Io//HkVOiFWFJeoZngKwRZvbs3aMisyPeoHl7Znb0?=
 =?us-ascii?Q?oUNehjZsMh2SD1P+VpbRnddqjyd+0I7/i5uZAPKwXD4f67pbciEKcGRpN/g8?=
 =?us-ascii?Q?6SVVN4KHXl3m+a3HPYn0FBlJuN2nR+e9Y5TAkSaN6x+veHrrbgYL/ZjkYr6x?=
 =?us-ascii?Q?XFKaUR1ctk9gsSc+AYL6etBkEavEGuwMGXeA3bguAv7NmlQOkmrGa/+Sh0rO?=
 =?us-ascii?Q?yYeJP+S/59sPBerrT15WoNlhB5S74Jsi9aL9tO8TeWMHheTVWdHMN/6khvX7?=
 =?us-ascii?Q?FHFizgjsd1cKh9gIn2LKN7wXBDzLnROFn87LyqTt7cFLb77MeSp6jz+vWiBF?=
 =?us-ascii?Q?p8FneB5tfJsDRl0k5IJGCPXBUrgSbMX8zT6fdntvUG5kDoz2zFl0FmJvEzRE?=
 =?us-ascii?Q?PiZr887Obq4jv2wB32NKLFbAT+/QHHcc5VweWNGU78dQ480R4Yq215lTlekX?=
 =?us-ascii?Q?lHdQu63ek94dYUuugRT7cFT7/kBwDqn01SEau0lMBjyrsVcEySFnYxWBhFC3?=
 =?us-ascii?Q?4O+0a8cp/QDG2IgCzs4WvblOqk2yeKybM3pWswlvFPK6B3EV7O/iLqsOi7zH?=
 =?us-ascii?Q?5tf1A2ZmHwBctXYG/uay2HtDKEmD14OHAEQtYD2raiFIONKyfr3hFq4Tr4R0?=
 =?us-ascii?Q?U6hn9kwNvR3e5mdQr0Iw/b+ARjP4i0x6QdDAi7FXsoupOapjUuC5x6bjEnEx?=
 =?us-ascii?Q?uezfi9+HLwKjavIRXSKM9TtDA4gE77EGkMkEoWX/99YGe5h5zLYpRw+YI7bv?=
 =?us-ascii?Q?c/Mdc1j+vTUoAgOp8jv7UB0vz9k2XQ2AZysUC2PRBh/CavoSpyEG8eS0L/2U?=
 =?us-ascii?Q?nvxnFs4AqNlOS8ikj/VSZ4s=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71fa18b6-26e6-4ba7-33f8-08d9c0391fe4
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 02:09:43.3322 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +oEom7uYf+OHir9ry84nF8CydUJcZrrvYCwVtJAPkzo4wz8ctKGdlj5Q0s2NOr1ZBydwsY8yacoNcdAp7eOMDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB2382
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
Cc: yh@oppo.com, guoweichao@oppo.com, zhangshiming@oppo.com, guanyuwei@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Sort shared xattr before writing to disk to ensure the consistency
of reproducible builds.

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
---
since v2:
- Only traverse shared_xattrs_list once to clean up code.

since v1:
- Use strncmp instead of strcmp.

 lib/xattr.c | 42 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 36 insertions(+), 6 deletions(-)

diff --git a/lib/xattr.c b/lib/xattr.c
index 196133a..f6b2591 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -562,13 +562,31 @@ static struct erofs_bhops erofs_write_shared_xattrs_bhops = {
 	.flush = erofs_bh_flush_write_shared_xattrs,
 };
 
+static int comp_xattr_item(const void *a, const void *b)
+{
+	const struct xattr_item *ia, *ib;
+	unsigned int la, lb;
+	int ret;
+
+	ia = (*((const struct inode_xattr_node **)a))->item;
+	ib = (*((const struct inode_xattr_node **)b))->item;
+	la = ia->len[0] + ia->len[1];
+	lb = ib->len[0] + ib->len[1];
+
+	ret = strncmp(ia->kvbuf, ib->kvbuf, min(la, lb));
+	if (ret != 0)
+		return ret;
+
+	return la > lb;
+}
+
 int erofs_build_shared_xattrs_from_path(const char *path)
 {
 	int ret;
 	struct erofs_buffer_head *bh;
-	struct inode_xattr_node *node, *n;
+	struct inode_xattr_node *node, *n, **sorted_n;
 	char *buf;
-	unsigned int p;
+	unsigned int p, i;
 	erofs_off_t off;
 
 	/* check if xattr or shared xattr is disabled */
@@ -606,16 +624,26 @@ int erofs_build_shared_xattrs_from_path(const char *path)
 	off %= EROFS_BLKSIZ;
 	p = 0;
 
+	sorted_n = malloc(shared_xattrs_count * sizeof(n));
+	if (!sorted_n)
+		return -ENOMEM;
+	i = 0;
 	list_for_each_entry_safe(node, n, &shared_xattrs_list, list) {
-		struct xattr_item *const item = node->item;
+		list_del(&node->list);
+		sorted_n[i++] = node;
+	}
+	DBG_BUGON(i != shared_xattrs_count);
+	qsort(sorted_n, shared_xattrs_count, sizeof(n), comp_xattr_item);
+
+	for (i = 0; i < shared_xattrs_count; i++) {
+		struct inode_xattr_node *const tnode = sorted_n[i];
+		struct xattr_item *const item = tnode->item;
 		const struct erofs_xattr_entry entry = {
 			.e_name_index = item->prefix,
 			.e_name_len = item->len[0],
 			.e_value_size = cpu_to_le16(item->len[1])
 		};
 
-		list_del(&node->list);
-
 		item->shared_xattr_id = (off + p) /
 			sizeof(struct erofs_xattr_entry);
 
@@ -623,8 +651,10 @@ int erofs_build_shared_xattrs_from_path(const char *path)
 		p += sizeof(struct erofs_xattr_entry);
 		memcpy(buf + p, item->kvbuf, item->len[0] + item->len[1]);
 		p = EROFS_XATTR_ALIGN(p + item->len[0] + item->len[1]);
-		free(node);
+		free(tnode);
 	}
+
+	free(sorted_n);
 	bh->fsprivate = buf;
 	bh->op = &erofs_write_shared_xattrs_bhops;
 out:
-- 
2.25.1

