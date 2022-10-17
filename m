Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A458C6004F9
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Oct 2022 03:56:38 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MrKq75RC2z3blY
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Oct 2022 12:56:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=BGqbrwG3;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=outlook.com (client-ip=40.92.99.37; helo=jpn01-tyc-obe.outbound.protection.outlook.com; envelope-from=set_pte_at@outlook.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=BGqbrwG3;
	dkim-atps=neutral
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2037.outbound.protection.outlook.com [40.92.99.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MrKpz1m8dz2yyZ
	for <linux-erofs@lists.ozlabs.org>; Mon, 17 Oct 2022 12:56:24 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJLcaMihQ3HQ2qLQ7H0yuDeFyg2Sjwp1TPJ9cvgT27a4YblunewmkJ+BPOtye/0AV+Q6o8/RckjVUPXDf5TiBGRzTj+Mboyqg9QLpaRKQDp9zrvCrUpY6KRsSJzxInrsTLoiuXHbYa6bW9fVMGtDMM6Pbc0L+5fLaW7M6Mli9sks+5l97M5CXnF983FOnsMmTod9DU2mHWzDAkRt2wYpGQLyjlli7sLiahOGMfMyjnpyugEgO4NnQT2++Fv/FQf5JYLRk0aE0Mq/hTsmvwWwwnZahyPqeVy+mY/qeebMPKttYOTWQN676fqZJMIMXPk2/L7WG55VF5fk/QW12EQYlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PHwKV3MPuAtaesPp/cey3q6qIj5U9avWEr8Is0N01pI=;
 b=gPdpicWfscD47wjYCzusBToM6Vb5nTTKRCU+sp9/Rsql5yrwXl0DSZ08Q4zIfApbNFxOlvmbDZjSXCQ6GCc9xP7TMwKxS0QAmjLD8EB5ZMgLZ8t9AMSQwOHxMM//z1+LQESkNmldyLWvUY8vdOrqRTgeh9AZYeQ629berQnAPCIhy9LEZHQkMNGdxj1NBzoEAF0m32GnzSevICvYNajLv8lwraQomc0RZIG7QqOksMm4//EqhCdIH7KyD3ZczvbSHGLE3F0qYtgZ13aPCv5ORIGdPJyPRrFk8O7oPqEIchrff0dC7HgTWEXsQ8r7XWlXK9SuPY+ZSDDyOBw3kxwInw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PHwKV3MPuAtaesPp/cey3q6qIj5U9avWEr8Is0N01pI=;
 b=BGqbrwG3R9aspyCuptsY2qFpkYruVZbwxwhu1jzuxKwHI4ROh0sKyi5oHyRq0yyq97uLHHvM3V9mPuqwwqgQOYJ4N626v1Ten2RgIf6tC6lNu0G6PzVijJbgGfaPIBvJZ1EbMx1R+jQUmn08ZshI/bB+zdszNsyEKfCzVhLkmzCxGdh/oe40Lz+qdOT5fHv7nQKh4zOUke9IJIi0sjgKZDSniEB2VZVp4QNa8Iz2WXtohcBUd+A3NZHNQqTHMBgE7KOGxdeoq18z9dpVcZK8nIyhgD/UJSjXLu1uFfdmjezrwdqlXf705mhnFbdhrHh41V5R34/ajvrzZ61lcJMjxA==
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:152::9)
 by TYWP286MB3382.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2dd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Mon, 17 Oct
 2022 01:56:03 +0000
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::4722:62da:4861:9d73]) by TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::4722:62da:4861:9d73%3]) with mapi id 15.20.5723.033; Mon, 17 Oct 2022
 01:56:03 +0000
From: Dawei Li <set_pte_at@outlook.com>
To: xiang@kernel.org,
	chao@kernel.org
Subject: [PATCH v2] erofs: protect s_inodes with s_inode_list_lock
Date: Mon, 17 Oct 2022 09:55:53 +0800
Message-ID:  <TYCP286MB23238380DE3B74874E8D78ABCA299@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [N4IieOCPkr1neMxE730yOVXzDyzIztSe]
X-ClientProxiedBy: TY2PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:404:56::28) To TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:152::9)
X-Microsoft-Original-Message-ID:  <20221017015553.2013074-1-set_pte_at@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2323:EE_|TYWP286MB3382:EE_
X-MS-Office365-Filtering-Correlation-Id: ac3220d1-ffa3-4963-7314-08daafe2bf79
X-MS-Exchange-SLBlob-MailProps: 	ZILSnhm0P3lt+CQaDQ/GFhL8t+j9Xd9JgD+BCv9mZ0byB3ixr8ZJVtexTl0+TBLncmHRU9oafdzwUnFoG+APEeUYttaUrgrC7RadHxfs+/ROW42M+Dw3sL/Osqa7c2vKBY7EmNBhOX3YzI1LMJrze3bUy58d/S7L2m/kH6eSIpJPXM72VXGLaRPGI4rwhSaIgwbAQ6LpzBx7/TP3R8qpVvbD7dbDp7QSKyTZpn7aHf+1qxm13PCqxlakMEY6nsfYmzX6k+lFOEli+VuEF/7+sBupIRl9rCeUSZO4ZjPVMCaRm4o9JSRltqAfB5eK4d3ix+TAkaH3uNk578pPWyl6RyKE6WPAKW3k3NoHkWHZGn6APmeKP49Z0/5lKr3ChFeU2xGu0rJq2blraOQZ6GtNbsQuexXkvBZLsnRQEYrwEtxXlscYh/OSr8v6RvKWpTfFOWt5y4vtIfQ6mEyFNy+vpqCHTbfS7KSID4D0vIO09kIDaDB7NPKoDZfKRc42wr4VacuJ+YGrz8xXRoUxSI6JxyJ4gG1BreouOQeVrZmdQlwVbfOy6V+omDL9o65L+vPKoPh/E6n2aY25O8eUPn2SRk5268Gf7Le9rXX90X9gtAr0FwXpO2wNeQmjfR1hHOXvPHqNiIEQNdD64DqzCgvaF0L/eJy52fztFI8+xT+iZsgBLM3FL7Mq19XQu75BpeeECb6NcQiZWyAxLwVk91HAzQEO2C0XG07D/VTZKPa9vUNBu8YIuS/+FhMVD7E9clqd16QLr/ta1SlS84SB1vmUqnCbKjMcQCHV
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	JuK4Yw0cE9t+bgb9wzXsPYwfMSSfoxqzPW98qCKFIxJj5rsU+Pq2aPI7ToZScADbh+GvLPmTC1u8k4TpaBtbYi42R/FlDYYb4czp1CYToVLMcgJkbLDT/1BW40xkqeXuCMZkV0ltQJe2dS2XUrmDzJv52Kn/1PY4gXYfUsxzaE8rI6QLAbrR4kuAcEN0UlewyLwx6aCVeg2t7Q/4nntjDNOV9h+nVtzafGjF3PNXl5N3abfLcTkaHCsYetlin1g6T+oDvsBJQlo2bLfPHvlPkvGg7OZP6neYUQ/rKADfnnNqGTw3m0U5r5YtjLcuceju90Hx9eFekl25pHejqCcQoSxiuQ7dAmqOR2kL0rxTM+Opq1eoTLes7tRCkLL52COewnGCWkuRPFPn6v2AmzR097kSvM0jczlwNxeZetHFb+0lTptKg6Ol7ph5bSqV/jRagQm574zn3/0ziupTWzwtx2QkxSh5ucSaWSwF/qP0EJx6QlAXz5qTqZ/0TonQoY4Uwn0WfYw5EkjYgCw4VQW4Nk4ehLN/NSoSl5ciyajLHbmwFkPMlwK9J3G9aqY4TqqNsvMeS1c7HZNKG/5R9NaDCDx+aWKdO39zxTy1mSAAjzj4+WfcO5yFlkJra9KufDFoItUM/j8+BwAtYXG6JLI1jBAPOoB+Q4QjHjlLoSQWmVw=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?NuU1x2jxJCzYACTPaGO41NCW5gRZSmQxMrMBJJsp6MWWV8qvGcIaVpJ8UzrG?=
 =?us-ascii?Q?eVQ9dcU910AuCzqeYua09+3j/D+RhvgU+hbasUcGjw8HrcaMgjUkkcPbyCSE?=
 =?us-ascii?Q?74tehRjqS1DXsuw7tUltKWQ4c0VC9LqxEZjlxCPupU5R3A/niiZA5CWv5uuC?=
 =?us-ascii?Q?OACSaEwjc+WGsrjFEQ309D0U6lXwW1hntesojzfnfJBkCHvxniWTwLGSEO49?=
 =?us-ascii?Q?+QK/njVqgRwqYSMJN9Epv4Briu7+Agj2RQHWv6nM26ChXR13M9ZaeIM55q1R?=
 =?us-ascii?Q?kK8XbBrMCfYf0DiXgz44hWPVixJGQaZZhFAavypTa9pTHWeHiWGZ/K0Kvsr8?=
 =?us-ascii?Q?GBbT1lR1ZAK8u9U8QI4bm2PzKM2owQyaEGdMsCsr/xrFJMZhtDpd752j3WrR?=
 =?us-ascii?Q?5A0DiXzkc+S5zufrJbmj5zFYTwgPB+7feVdbVW+bW8bU12p+H/CDD4G5/2ac?=
 =?us-ascii?Q?Ugx3Ko+i4QZ1H7Saioj3ASPOoYvOWazRLj/zXxkjsojZYuJ1PryMml3cl9fa?=
 =?us-ascii?Q?0kCUCJUllJ9iZVAL4r/rhcueYGUSZxatBZR5n7n6MuxZG0M5BVSPWRaoqlUm?=
 =?us-ascii?Q?QHRyXD8oXqfqZR+Xe9SNLbiJudkUpAREK/r4/n2UmBHf1ZV7ZRNuYq+apGf2?=
 =?us-ascii?Q?4zVwBC/j+z7uHT5mo/nP1chaDEbiudNHM8iwsaO/RmtWieSVedc46r9TPR1n?=
 =?us-ascii?Q?CZvssg9DHIy2MddAyuSQefnmgJGbTHq6GoPl60tXGOdaEeglIR5/PqRgeh6z?=
 =?us-ascii?Q?JFMvRyCa5v5wIXy7SRSoxpwZs0ZJxvZHf2NaQPSvPHW7udBFW+gxZB/2LYNU?=
 =?us-ascii?Q?KJ3gR6/MRqQqIjwhuEp0H7dEMoNIUYQUC/RAgedBpLLrfbyR6WUpAzWPXVyr?=
 =?us-ascii?Q?i4fAWxIqYIb0MEAIxJiHWL38BrrQTfAv+3y/wBlkr3k0G70IrZ0Muz8qQ+5V?=
 =?us-ascii?Q?ibsvviaRzHam0whQ0YwG/LJTxcEl0nqXuSPhDWtZGobk0B0hq1/lEA2jRp++?=
 =?us-ascii?Q?8OJG0TKDa0SDhgVYYO4td1a4gXP8clUz1WfqXAFQFXlUqchAJBdBSC9qSFL1?=
 =?us-ascii?Q?lIdRopmCKX5NUlu6y4HVwcxMO00yu9bT9f5jPJuGeQQb042+aDbRzfWAQNJB?=
 =?us-ascii?Q?7y8VYw5XcemikDK69iJub8zDoenSNOdhi658NsLV9cPFICTJ5lMsRebbWPbP?=
 =?us-ascii?Q?2IRnDx2Y/ZL5eeFHhgCnIp717pdqXoGeEIML9CQPneNm84llBPMGGjNDudxg?=
 =?us-ascii?Q?yBQVdtYOILHcgbH9RQncNMPtowOe38qtEsKokx+k8w=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac3220d1-ffa3-4963-7314-08daafe2bf79
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 01:56:03.8879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB3382
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
Cc: linux-kernel@vger.kernel.org, huyue2@coolpad.com, Dawei Li <set_pte_at@outlook.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

s_inodes is superblock-specific resource, which should be
protected by sb's specific lock s_inode_list_lock.

v2: update the locking mechanisim to protect mutual-exclusive access
both for s_inode_list_lock & erofs_fscache_domain_init_cookie(), as the
reviewing comments from Jia Zhu.

v1: https://lore.kernel.org/all/TYCP286MB23237A9993E0FFCFE5C2BDBECA269@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM/

base-commit: 8436c4a57bd147b0bd2943ab499bb8368981b9e1

Signed-off-by: Dawei Li <set_pte_at@outlook.com>
---
 fs/erofs/fscache.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 998cd26a1b3b..fe05bc51f9f2 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -590,14 +590,17 @@ struct erofs_fscache *erofs_domain_register_cookie(struct super_block *sb,
 	struct super_block *psb = erofs_pseudo_mnt->mnt_sb;
 
 	mutex_lock(&erofs_domain_cookies_lock);
+	spin_lock(&psb->s_inode_list_lock);
 	list_for_each_entry(inode, &psb->s_inodes, i_sb_list) {
 		ctx = inode->i_private;
 		if (!ctx || ctx->domain != domain || strcmp(ctx->name, name))
 			continue;
 		igrab(inode);
+		spin_unlock(&psb->s_inode_list_lock);
 		mutex_unlock(&erofs_domain_cookies_lock);
 		return ctx;
 	}
+	spin_unlock(&psb->s_inode_list_lock);
 	ctx = erofs_fscache_domain_init_cookie(sb, name, need_inode);
 	mutex_unlock(&erofs_domain_cookies_lock);
 	return ctx;
-- 
2.25.1

