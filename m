Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BEC5950231
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Aug 2024 12:14:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1723544075;
	bh=JrUD/ffHDDmQTWKjXvkmbrsvDKAVoljy+Oj8y1VsfMw=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=FwLZncoOG2eVu1JOsR6I8OEgdfq1Y9gjYdha1xb74CyYmIWaWqDBikCtpXZb6wxXQ
	 FN1wqhsax3mowRRusgWUewflLGhkKzyV679lb1grmg0EoF9O9Ut/N1Kbj+Du3aNLH2
	 n3KWjhHcDThrK6wKRwAKKGLGlK2kqycThfx1FwrGiJRzqr9+o50G4NO8ohlymonppr
	 AGQxrXMkY2ywmVAkyyV8c7FX4xFpO2Sxt/a6uDskjbE6cX4OZ11IF+p1Xyzb1ELCkZ
	 4zD6fAg5T00MPQZA+KXPa7uHFByw4T2YxGDnWZ7Ey/BY8K46Sumc/jRcPE5ur2hSCV
	 aKwLjEOtfZzsw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WjnLM088kz2yNc
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Aug 2024 20:14:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=VyyDm+K7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f403:2011::600; helo=apc01-tyz-obe.outbound.protection.outlook.com; envelope-from=guochunhai@vivo.com; receiver=lists.ozlabs.org)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on20600.outbound.protection.outlook.com [IPv6:2a01:111:f403:2011::600])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WjnLH54Fxz2xG5
	for <linux-erofs@lists.ozlabs.org>; Tue, 13 Aug 2024 20:14:31 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UerF02nBuBEAgCK2UTUQqfFaMXZnwmfnAfCbnminpGQ4qY/LYHVBaWlJHGmS2+ahG3ECNFYDUoNIeG8FUZmwLM4iNLlVJ33YERtwTeA6YaY66RAIB9jk9Ba7o8cnz81iWjPWE+NWsLw1M8f4Zt1p1tVhhH6oFaNNOKlG1BSPT9Exn7zjM8vk0hseNU5PHuJ1CxW90qVgdvzN31gudokXZT3e9/TejpCQlwPoGB8y+Dv8Hc998tWbYUQqXcu3h0uabk3rpfhtfUhm95RedSknVjhmSurXpRILNZqirbW9nUY4slyweNEmN1g8P/+aoSvnD746taRlOzvc0rYoESkO4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JrUD/ffHDDmQTWKjXvkmbrsvDKAVoljy+Oj8y1VsfMw=;
 b=HRQCUU8pTKuVowxPUktIKnjafgt3hxLAi7UFthHoxycaX5Q9TYBUTaCWGFpBYpO+hFMcavOQmLNQ8YBaAAQRAiMZz0a2ESqqGSS8kRnt7yTWNGMoSZTU8YB6A5J/EAGneE9dVZqMtmtBj/udNAaDGAm6zKiANXsw89MPGOeV9fklYGqbqKINjHyFx0NQlt3EOxBUxb2jHr+YRpt+6RpguNAexVavKUj5P/tPGmEu2EUYsneFhcIEDMVKWRQ/MihXFy5xcywqeXyFU+BwX65YqxoWUva8LoKX5Eilz7aaYJZdEntHtwyHNud2ja26UUc7Pp660hPdK/nXXbZJ2Ev6hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB7096.apcprd06.prod.outlook.com (2603:1096:405:b5::13)
 by SEZPR06MB6600.apcprd06.prod.outlook.com (2603:1096:101:179::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Tue, 13 Aug
 2024 10:14:13 +0000
Received: from TYZPR06MB7096.apcprd06.prod.outlook.com
 ([fe80::6c3a:9f76:c4a5:c2b]) by TYZPR06MB7096.apcprd06.prod.outlook.com
 ([fe80::6c3a:9f76:c4a5:c2b%5]) with mapi id 15.20.7849.021; Tue, 13 Aug 2024
 10:14:12 +0000
To: xiang@kernel.org
Subject: [PATCH] erofs: free pcluster right after decompression if cache decompression is disabled
Date: Tue, 13 Aug 2024 04:28:35 -0600
Message-Id: <20240813102835.640534-1-guochunhai@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0196.apcprd04.prod.outlook.com
 (2603:1096:4:14::34) To TYZPR06MB7096.apcprd06.prod.outlook.com
 (2603:1096:405:b5::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB7096:EE_|SEZPR06MB6600:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c24532d-6b69-4a98-5b60-08dcbb80ad66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 	=?us-ascii?Q?ANHlqCSYOuFttI980EoxuD4snYTw6wHJmZectEgm0zMsjI36mmpSGD0NoFXH?=
 =?us-ascii?Q?weXT0gwI8/CHfo2W0gv0G0KHvw0OCkeP2RxvzzMMwxgzqM4xr9eI5uXgFpa1?=
 =?us-ascii?Q?j8Ob+xWQ8y0eDfPWrITqcXQFwO2i9XGAihGWcSJpPlYR0dRCRcduG5D2yOGM?=
 =?us-ascii?Q?XrQ2hKxNYTqmPH+AlfavR+f7tXeXHRM6um1HCOVZXVxwR13gXRit2ShYjk73?=
 =?us-ascii?Q?aIoCdDZCegD/dQzNcIYndn6edzZ/2nze/VqDlxPfuCmUsefOUV65GHF4NQyA?=
 =?us-ascii?Q?QqGaxHnK9PNeI0a1FgaV9pY5sauKBz/KVj5To2wE8/7c89yAe14sPv4mE0MS?=
 =?us-ascii?Q?MEd+7dSL8M+Lg4hX2XlcETgyoaf0GHvJ9XrxsMFiqq4S1iLTqlPjn8jjacyF?=
 =?us-ascii?Q?NupmX71JY26vakKZCJ5vgknaI4dCzCW/zsxk9CUnPsXrJMNxRud9w/QDL5KW?=
 =?us-ascii?Q?EtQELDWCIA6PMICcZwd5bR/cb8CLrcPPIDsPjcM3TSg0pLPJckJLrUpYhsRM?=
 =?us-ascii?Q?mukVqin6/epfgMP67HF7o5IUCS1KCcr/cemzTTn1nPUn812wlJsBLaung2tb?=
 =?us-ascii?Q?v87JE4PIrKHOUwSMaKcVyAGTrmGOBoxAZUY62wFISD/cW952VW5Usz1yw/86?=
 =?us-ascii?Q?MovKmOwa3DaAZMEIr4v0E+sSrFtUSSnaOwrZ+4ZnkKo4PcUk/3y40uchGWcL?=
 =?us-ascii?Q?4E4D60qBwMfxeIqTjn72gktY6QdmfJS0K3SRgIHaExGwljuMYC8k+gGPY8Uw?=
 =?us-ascii?Q?zbWCKPNop61vpQbY5Vu+kj10E47ymESGlGfHzR1+iIDJVi1QslWve+GPcYXD?=
 =?us-ascii?Q?vrKdfirnAWf0bYu7tcpDttYzXOeii5SkF2AFGH8/+WWZ2iiysJpf7E5EVHYW?=
 =?us-ascii?Q?UR+93m6e+QMVbt5rNm08oJb/z1IhBlbNF9dXPalwlsuk3mX0gjA8dT3KW5Ku?=
 =?us-ascii?Q?AQCgV+y6a2DXdtMqrkNe+0ZH4mfIjgG5JZz23Gt684L7dzV7DNZRTjyuYBgL?=
 =?us-ascii?Q?EOzE3XFChHTjUd+wV33czOskUBezPeSFmgKilHkaVECYc95EJASlb17ClftZ?=
 =?us-ascii?Q?22LnUuWUGUCNRDnuZwYRFjGNxsae4mVy2MJx7mTI8dQJjmJFtE4abRVGSFHU?=
 =?us-ascii?Q?UnXuHV7+pDGjUWjtN+6/WfEJ//cSW1LwubakjCQRTSyBqt2fDj8h9ro1WiQU?=
 =?us-ascii?Q?TJIybch5hDc0b0y0ZNzhmg7906f9BOlEGwwFBLTy0xeAuaEMdhfUuPTF4wL6?=
 =?us-ascii?Q?nnotCFHc0V2f66l+uRMoVfgFzWOfF3cBtt2TV68wUOGi6Ew+cDAAIMFv8s2J?=
 =?us-ascii?Q?7pvlt/0BKRreahFiAh835P+lwh2WUX8BOJkpRHWmSigA47GTQHq9AwoIjkxJ?=
 =?us-ascii?Q?uU9y7wwjxlS2Nx/fDubffco1BTKJtJ1Zi8s4PGPOcPpoHZbvVw=3D=3D?=
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB7096.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?tjLCPm/OxIQpfla08DwmFZYhOkdT1HAk9RGC1e0WBuRc6iqhBHcLHjfssMuT?=
 =?us-ascii?Q?Drjxm1VvsUAKiCWWF3e6DfuYAI2gZKbLTgV3kLfrHEjY0TtxHP9l/v6n5Vde?=
 =?us-ascii?Q?2N3EbSRAAUCnPfTScCcTRWDBPRuN18PanFvBQig5yWUS9qpPjnmPjxTHmdZR?=
 =?us-ascii?Q?qoUWv90DCfsztYGxrYDhy4a2Jm1PglwJ4Uq8NeIznW2JX6S0JhZ0XgD7UoiI?=
 =?us-ascii?Q?sw6Vu6bKWBQPW1WghPqnpbCvNeIJXmUK7Nn4PmJFfeM98YYTc5H3BHSZMt2Y?=
 =?us-ascii?Q?CUxLPUoUIReIPQWwmAuksbbWTWYpNaT0x9d3qHRRCPHinPKX4RToRBlOzZC6?=
 =?us-ascii?Q?0CeZL5FFWRad93Mz5w58Dwd4o10Lvu9yL6+L01QHY2QKX+AZ1uK7OthhOOfK?=
 =?us-ascii?Q?xfC60cj4z8LE2yizqKXci3+V1e8zNFsbE/hzLCc8B4ou1G2bKsHD7ZiCLZiw?=
 =?us-ascii?Q?GIYwKGkIYqy536FID3DhZqq5F/6AUQjxSIWh3knlVy3Ve+3aWGaw3K54COMn?=
 =?us-ascii?Q?B68WSRB5UwZMNsToir5nCk4qrNpSdO9gt/owGL1Mxqc/Itlu6shz4EWXNxHT?=
 =?us-ascii?Q?Du4AF2O9/UMdgXujz+WynOIDzkOIkbn1X+HgO9seXfIP+ScxTMXgVBUu1ar7?=
 =?us-ascii?Q?CAaCXO0E4Q2Z9x7nwmkO7X02mcEnaCaamlr/2YFWiJ27tq/F3OyJ3xGHvIS5?=
 =?us-ascii?Q?X6yJtf85o+oVleWMaG1eiQJTK8afmuPI0qy+6EdbeDuoNuHMjzNmquGq9H5o?=
 =?us-ascii?Q?lJH8LnWryp+B4bVUcciR1LC5bZNIc2kfJ0UOLJJnH7kjX0VRMS4RJmGd21SD?=
 =?us-ascii?Q?kviJX0NPnKDQ5ISU9ZRmS/0nYn0JXtuYxwLNdNMEpvAdj+2JkYeWbR87vEUi?=
 =?us-ascii?Q?2zLLBnTBg6yB08hcQzicUy1YccjyG1ciw33uNXAy9kaICzT5xd4Ioa7nBfaa?=
 =?us-ascii?Q?ZZfikNsXRLlWvcw7t3HtY3XKkPz4T3/rVWue9ao5ydxSyHNtu77anwfH3BLw?=
 =?us-ascii?Q?L6wWwYryX8OOROKC9M5AFW425ETjZwoPKukRZ5+h7zD+DGcGMyU8Iq18XC5R?=
 =?us-ascii?Q?6RxI3SGpcKYFPdq3BbgURwrO8RTkyakdJouBsROKjcEAwSmCJ7dT4jb/NraD?=
 =?us-ascii?Q?t6ObCNb7UZ2dxG+hPN1JS4vAjabAvGhmC+z2+GA6aH7I5Zh+DBtvZSgof1tk?=
 =?us-ascii?Q?Ti/ef80qBl1gWPO7tFdn9P2Rd+SnlC5bvGi3/SbHYDOC1qPW4XDE95AEYrUf?=
 =?us-ascii?Q?XbIetTtzZQNHTvaUpy4yYMQJC08MweaUVThD7jvGpqRPYZ/4I4fZXZivaWw+?=
 =?us-ascii?Q?emM02F18cbJKcCIlU70yDIADz3/StfypRWWKRN4fTJLCnDqK/smDTFX/4Ex6?=
 =?us-ascii?Q?wF0/yqrt0aeEVXmh1uPtofkFK5rtyr0PXQxuqryjz1BgJO3YvM54tGe+y3ub?=
 =?us-ascii?Q?B/HlptZ3R+t5l59q4X0I27bic4CRv1bUKo4dgDVoZxKbQilLoDj/5bNVjuEa?=
 =?us-ascii?Q?bgmzC0vrcaYpA9VoX8xL5ojMJr7H7rzlCsFHqebdGq5OeT1NapIwrH2rRKd+?=
 =?us-ascii?Q?HKV3Iwpo9yGaPJMmHBew0Ngw/CqfIqznHkaWQHmS?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c24532d-6b69-4a98-5b60-08dcbb80ad66
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB7096.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 10:14:12.0571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XH75eTCBZmM+FJ98XDmNCtGBI/f2ykUQfQN69BsSJ+jS49maVS2JappIP4DBtBJbPNZSUgo9mJtnZRO5n5tLwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6600
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
Cc: huyue2@coolpad.com, Chunhai Guo <guochunhai@vivo.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

When the erofs cache decompression is disabled
(EROFS_ZIP_CACHE_DISABLED), all pages in pcluster are freed right after
decompression. There is no need to cache the pcluster as well and it can
be freed.

Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
---
 fs/erofs/internal.h |  3 ++-
 fs/erofs/zdata.c    |  4 ++--
 fs/erofs/zutil.c    | 32 +++++++++++++++++++-------------
 3 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index e768990bf20f..cc6a61a422d8 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -449,7 +449,8 @@ static inline void erofs_pagepool_add(struct page **pagepool, struct page *page)
 void erofs_release_pages(struct page **pagepool);
 
 #ifdef CONFIG_EROFS_FS_ZIP
-void erofs_workgroup_put(struct erofs_workgroup *grp);
+void erofs_workgroup_put(struct erofs_sb_info *sbi,
+		struct erofs_workgroup *grp);
 struct erofs_workgroup *erofs_find_workgroup(struct super_block *sb,
 					     pgoff_t index);
 struct erofs_workgroup *erofs_insert_workgroup(struct super_block *sb,
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 428ab617e0e4..03b939dc2943 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -924,7 +924,7 @@ static void z_erofs_pcluster_end(struct z_erofs_decompress_frontend *fe)
 	 * any longer if the pcluster isn't hosted by ourselves.
 	 */
 	if (fe->mode < Z_EROFS_PCLUSTER_FOLLOWED_NOINPLACE)
-		erofs_workgroup_put(&pcl->obj);
+		erofs_workgroup_put(EROFS_I_SB(fe->inode), &pcl->obj);
 
 	fe->pcl = NULL;
 }
@@ -1355,7 +1355,7 @@ static void z_erofs_decompress_queue(const struct z_erofs_decompressqueue *io,
 		if (z_erofs_is_inline_pcluster(be.pcl))
 			z_erofs_free_pcluster(be.pcl);
 		else
-			erofs_workgroup_put(&be.pcl->obj);
+			erofs_workgroup_put(EROFS_SB(io->sb), &be.pcl->obj);
 	}
 }
 
diff --git a/fs/erofs/zutil.c b/fs/erofs/zutil.c
index 9b53883e5caf..4f5783cca5c6 100644
--- a/fs/erofs/zutil.c
+++ b/fs/erofs/zutil.c
@@ -284,18 +284,6 @@ static void  __erofs_workgroup_free(struct erofs_workgroup *grp)
 	erofs_workgroup_free_rcu(grp);
 }
 
-void erofs_workgroup_put(struct erofs_workgroup *grp)
-{
-	if (lockref_put_or_lock(&grp->lockref))
-		return;
-
-	DBG_BUGON(__lockref_is_dead(&grp->lockref));
-	if (grp->lockref.count == 1)
-		atomic_long_inc(&erofs_global_shrink_cnt);
-	--grp->lockref.count;
-	spin_unlock(&grp->lockref.lock);
-}
-
 static bool erofs_try_to_release_workgroup(struct erofs_sb_info *sbi,
 					   struct erofs_workgroup *grp)
 {
@@ -310,7 +298,8 @@ static bool erofs_try_to_release_workgroup(struct erofs_sb_info *sbi,
 	 * the XArray. Otherwise some cached pages could be still attached to
 	 * the orphan old workgroup when the new one is available in the tree.
 	 */
-	if (erofs_try_to_free_all_cached_folios(sbi, grp))
+	if (!erofs_is_cache_disabled(sbi)
+			&& erofs_try_to_free_all_cached_folios(sbi, grp))
 		goto out;
 
 	/*
@@ -329,6 +318,23 @@ static bool erofs_try_to_release_workgroup(struct erofs_sb_info *sbi,
 	return free;
 }
 
+void erofs_workgroup_put(struct erofs_sb_info *sbi, struct erofs_workgroup *grp)
+{
+	if (lockref_put_or_lock(&grp->lockref))
+		return;
+
+	DBG_BUGON(__lockref_is_dead(&grp->lockref));
+	if (--grp->lockref.count == 0)
+		atomic_long_inc(&erofs_global_shrink_cnt);
+	spin_unlock(&grp->lockref.lock);
+
+	if (erofs_is_cache_disabled(sbi)) {
+		xa_lock(&sbi->managed_pslots);
+		erofs_try_to_release_workgroup(sbi, grp);
+		xa_unlock(&sbi->managed_pslots);
+	}
+}
+
 static unsigned long erofs_shrink_workstation(struct erofs_sb_info *sbi,
 					      unsigned long nr_shrink)
 {
-- 
2.25.1

