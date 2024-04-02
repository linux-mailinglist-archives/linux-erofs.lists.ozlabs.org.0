Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3368894D66
	for <lists+linux-erofs@lfdr.de>; Tue,  2 Apr 2024 10:28:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1712046529;
	bh=U5/fruxkkI/GWNXucSV44ooxEy0kSRskyPKqYLXhmxI=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=KQmgHXVPaCRawCg9lWYBkBZ683Mozm0FA5I2d4R5l3Vyc4FtT0pQOTnZIGks54fZ5
	 UrQa5jd13/JpSricht8uS+wmd/wkArFY1x/egj+MVEwAcsQx7s5nUex1DiheFVqfYA
	 em26bvpPDL2kbzbqHP+XsM827Z7+a371tjUdKYi2a9GU+lGY4yQVq89gqAROw8hqVt
	 Fre9YD2DEUH4bhTWbWDK7cj0z/e5123kzot1jHal7b5m0ZIv5idpTJfUnHH5MDnVDi
	 4IcZ1RTsog2Zfw8l6wkEWN4IgNDsuvVzskW69LB8sknkcrXVDEUart1XTPNWxkmA+x
	 QcQ6EfUa/nY/Q==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V81Hj5jD0z3dKG
	for <lists+linux-erofs@lfdr.de>; Tue,  2 Apr 2024 19:28:49 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=eLt42K50;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f400:feae::707; helo=apc01-psa-obe.outbound.protection.outlook.com; envelope-from=guochunhai@vivo.com; receiver=lists.ozlabs.org)
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on20707.outbound.protection.outlook.com [IPv6:2a01:111:f400:feae::707])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4V81Hb39t2z2xPW
	for <linux-erofs@lists.ozlabs.org>; Tue,  2 Apr 2024 19:28:41 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lMPNJk1C4z5ry07/eSbZnDKAwyE4TRI534jJBnzEdkSIOVkTRM8Mxb9DAJ8f72flmoMSV8wugaIiOSZPwy5TpsfNMUJ9HOBZ0lKiEo3jCfxvjX16QjGZkLoi9HAOtSg0lo70lNfCAfwIcCQegXyk79DPgWRhTbta5MpIfJo9SCcuJG5TNlIia6rwd4pFCG59kVeWGkYcjuYrahPnZQKHq5yH0m2OHD+NoTYZROyWHUEr76tWG5XYfQAEVm24ujGDBFoimILNapsFdzqykDTApy3yAu+GZ0yTkEMfCz/tG029gk7P6jK8cMR9nV69+dLfX2ods4f6yrJqTaGccHVYTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U5/fruxkkI/GWNXucSV44ooxEy0kSRskyPKqYLXhmxI=;
 b=ddzvAPVFZJcRRfLImTO/+D/7qZ3toaLsuTMwiYsL4u0/3X7uT54tX+mdptY4SgPtJr2H7sxhqQzO6Wu4M4VXekhUMd+VdUAMyyRT/FHxNUj7eWsfeqgUIEmv/hPyoioYslO3NxncgUos8Fs4Gz9pqVZc/nGsSx33P9Nm6KRFD9724VECg3cyCOhBmij1n6X3Nh7DdpjVXq7Q4UcfhIHRijEA0znoNSoIdDuEc9YVfXmMVI2aLq1NMR2wNzwntNlA22Q7Kpol/LG3zDth1+THUb/aIjykDgflkNAKhRuGNRt2re4eIYlnj2voEca+qTswqTS35k8L0HwSjIiZUYYPnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
Received: from TYZPR06MB7096.apcprd06.prod.outlook.com (2603:1096:405:b5::13)
 by KL1PR06MB7051.apcprd06.prod.outlook.com (2603:1096:820:11c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 08:28:09 +0000
Received: from TYZPR06MB7096.apcprd06.prod.outlook.com
 ([fe80::9eb4:3582:34e4:a83d]) by TYZPR06MB7096.apcprd06.prod.outlook.com
 ([fe80::9eb4:3582:34e4:a83d%6]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 08:28:08 +0000
To: xiang@kernel.org
Subject: [PATCH] erofs: do not use pagepool in z_erofs_gbuf_growsize()
Date: Tue,  2 Apr 2024 02:40:31 -0600
Message-Id: <20240402084031.2623314-1-guochunhai@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:195::20) To TYZPR06MB7096.apcprd06.prod.outlook.com
 (2603:1096:405:b5::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB7096:EE_|KL1PR06MB7051:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	gdfCFJLE/ez+cSqwXnvc1owCxO25c8QcQItLYo125ucKz2wslo4X5sfPED7i0WYLvK/TwS1BRhjwZ/gy4IVeDtC/eCMgFvtBKHaJR7zbivJIcAp5/vVpFLd90QZLNWkg9KsOwb0or2J/gsvEI3+NS5PScKNb/b4ZEm0XnTVeq06WrtWZvmwNTeq0wIvXiNl1tJVHIpG04hL1S+b/Z8qL8OFnE0bv4fofBPZNq4dRL8uhCPjQpb8U0BV4XknMdiXorEIZPOFITgtEYp3MyLGSgfZN8A0J7IkzmONFkXrZyHn26WklkvCXJHfzF9/ELP+0C3Ubu44usA+DULdGm/ORXatvEHn9LuzmobQ4oDEyx/1mEr28YP/+ZHggWfXL+Pzp7+NWFU+3T0pnjO3MK+0UqDXONpgSpyG5gmuLD4gulAUnCpE+x3NYxJ3jZIMal8hVTx9fvxV6WkOfYjYoAku6voP7V9yLrhPJ38Nx8TBkmS1HX0KWSedYHYtNHTjtuIzJrpcFg8N2hQGi7QxZFtQp7ZxAAzsWiBBPvao8ThyUT9hXkYl+uuKUqptZUgjeqlycC/Ba3UHKZT+EKfTSpgQs+XccqUCvgx4pjF+VyE8+mvlhKRF4UO2XwvCSSblrRPXxg7+isQpvEkpYMOtQrU2a3C9C/gdgah8ojCCtMOhJJj7ERGk0p/248Oa6Zj/zQ7khaDDQwVfwW/lhJ3IT7y7qJw==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB7096.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?ixfmfVGoppjUUZrSo8QYLJorFY4ks8ryAwx1soAvFgN2yuxNJHfBwVCGeaQN?=
 =?us-ascii?Q?oVSRcyk61TlvuGAo5PeNov1eOM7iCKYNM/ix8NCLXqcRWiVaitrPNdtDAp15?=
 =?us-ascii?Q?2QTNg3p0zZYyoqfJGnOElOIiQjYQZ7v19nbXgz/mL9hCDeXd0cHj+TRRZFnJ?=
 =?us-ascii?Q?EVjUv4oQjpg5gsy6N5FbuZn6QLCYn7sOOaXTujeNmzq3oCkwirBRddSwsai5?=
 =?us-ascii?Q?5dYItJ9CRU2gRSXtxgo3VNddnmSwPYz7cTJwJZUDELMKcKKmgLDkhKm5BEpB?=
 =?us-ascii?Q?65JujRUv9Vi06e+x9rbHUwzukfdztT8RHVoM4nq4GakA7czHv1dGExO55gWO?=
 =?us-ascii?Q?QNJVl8q30XaHBi/9dvn6D4Vn0Hc5AXKqGrDrvAWGHV7DgPgTOhfKrvkyhogo?=
 =?us-ascii?Q?LI0R0yXyouo70s/rTk3wmAmY81tD7+zCp5y/KAVAmW6X0CVUIveIw5Cu3Su5?=
 =?us-ascii?Q?SArhRVsBH0YIvo/DqUNEJ2yhd3EmJfyaXtlumEAV6gC+hx12rbJF2c9CYGIG?=
 =?us-ascii?Q?/v/sn2an67xeFPGcUvnzAQDI7UCKi/7nG8R+OAD2k1MsIgd1ccH5dZMWZghe?=
 =?us-ascii?Q?sPTTZPAPgxGXps3beJOxvQc8FQrCVx+7GBIbmjJ8eA9dhUpSwZpWBkXSHpB8?=
 =?us-ascii?Q?Ow3KF2D4yoaYYF0AsTKSrZJlRu5k/N9jvLcLk6frDUQFUKzQ9Au01DH8cWSM?=
 =?us-ascii?Q?xyKV6T8jCl0hZyTdA3Wr8h1a8f3hXAQivNTkYzCDj59p6vegNb6OXHVpMytd?=
 =?us-ascii?Q?V5fVdvhK5icN5BcJV4CVKQfEqzV7K/psM2tyvNr7NxMEUXv1RJyODjRH2N2p?=
 =?us-ascii?Q?rQ9a7j2IDAFSnaS4cGL8oQXM/Rrt+vtlhqoTkioPCvqJn89XQdqved+26l9Y?=
 =?us-ascii?Q?m6X7mKlwwVKLY8tzp/agi2a9vy17DEqlfV5j8p1M3fG9drJTmY4V4lVSUU0R?=
 =?us-ascii?Q?SrXEJrRwERuMTj34tdoda58Y2UfieaOgffTr1IUyJ6hlbZn0SAAdieo+UYzA?=
 =?us-ascii?Q?rRcY5iBbM0f+rFZsRbwLaP9TTGrxa5ZsdTtEazwUbPdCvqD4xEApg05G+Ljs?=
 =?us-ascii?Q?vil0CF39266O4Lz+1UiJ/R3C8UoNMxvQjR76nqzM8iW9bogIJmE+rULnJaJQ?=
 =?us-ascii?Q?lYhT9naMC+d9EZQTLNGlJHp+TAYzryhhbvkBGIFrvHt25KVzXHEc/rLd+26i?=
 =?us-ascii?Q?HBNmRK0YsBsxtCcmiCp+b6g4XtxYMbRZbUEIlIQH77hqHnzxhWPoR2+wYfTU?=
 =?us-ascii?Q?fzFQsJfFDGT3a2OBWQHHBSnu1CMZGBzdi3HBH1q0y+NCEvVqSY2bhAnCSdtj?=
 =?us-ascii?Q?M++omPlBqGXyBwrLpiyXvvauLKPDM91bgiIDPtod2kKBExBgQ7xXK4G3SD3b?=
 =?us-ascii?Q?7+NMGZzImCdIonH0DFEsfr+244EHs6hKJHf4Vw+tcbmSZY1QZbe9wZcPdveu?=
 =?us-ascii?Q?Rrk7fUI9ClCBA64kkTLkoZHsPambOYQzlJrcb3S0GbYBWq0XC4LnHgsnscrQ?=
 =?us-ascii?Q?wOwS73x2hc6heI5R043lCOeFQ6nZr47hBtJlDrOWBGZ+r3cGNbq6vj3fmE56?=
 =?us-ascii?Q?c1YessMqgO5TBJN+8Kh+3Q+GWMwnlF5ZXFME/UAG?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72e09f8b-8af6-4c4b-63c5-08dc52eed38f
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB7096.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 08:28:08.6405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HyWLTV2UmHN22sRS8SHUjUieNgXhZQ0WfOwlETQmmCN8+9Yz5JFd2u5pd1mnHuJ3QVwxk2NZUGKeMndzTemzpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB7051
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

Let's use alloc_pages_bulk_array() for simplicity and get rid of
unnecessary pagepool.

Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
---
 fs/erofs/zutil.c | 64 +++++++++++++++++++++++-------------------------
 1 file changed, 30 insertions(+), 34 deletions(-)

diff --git a/fs/erofs/zutil.c b/fs/erofs/zutil.c
index e13806681763..14440c0bf64e 100644
--- a/fs/erofs/zutil.c
+++ b/fs/erofs/zutil.c
@@ -60,61 +60,57 @@ void z_erofs_put_gbuf(void *ptr) __releases(gbuf->lock)
 int z_erofs_gbuf_growsize(unsigned int nrpages)
 {
 	static DEFINE_MUTEX(gbuf_resize_mutex);
-	struct page *pagepool = NULL;
-	int delta, ret, i, j;
+	struct page **tmp_pages = NULL;
+	struct z_erofs_gbuf *gbuf;
+	void *ptr, *old_ptr;
+	int last, i, j;
+	int ret = 0;
 
 	mutex_lock(&gbuf_resize_mutex);
-	delta = nrpages - z_erofs_gbuf_nrpages;
-	ret = 0;
 	/* avoid shrinking gbufs, since no idea how many fses rely on */
-	if (delta <= 0)
+	if (nrpages <= z_erofs_gbuf_nrpages)
 		goto out;
 
+	ret = -ENOMEM;
 	for (i = 0; i < z_erofs_gbuf_count; ++i) {
-		struct z_erofs_gbuf *gbuf = &z_erofs_gbufpool[i];
-		struct page **pages, **tmp_pages;
-		void *ptr, *old_ptr = NULL;
-
-		ret = -ENOMEM;
+		gbuf = &z_erofs_gbufpool[i];
 		tmp_pages = kcalloc(nrpages, sizeof(*tmp_pages), GFP_KERNEL);
 		if (!tmp_pages)
-			break;
-		for (j = 0; j < nrpages; ++j) {
-			tmp_pages[j] = erofs_allocpage(&pagepool, GFP_KERNEL);
-			if (!tmp_pages[j])
-				goto free_pagearray;
-		}
+			goto out;
+
+		for (j = 0; j < gbuf->nrpages; ++j)
+			tmp_pages[j] = gbuf->pages[j];
+		do {
+			last = j;
+			j = alloc_pages_bulk_array(GFP_KERNEL, nrpages,
+						   tmp_pages);
+			if (last == j)
+				goto out;
+		} while (j != nrpages);
+
 		ptr = vmap(tmp_pages, nrpages, VM_MAP, PAGE_KERNEL);
 		if (!ptr)
-			goto free_pagearray;
+			goto out;
 
-		pages = tmp_pages;
 		spin_lock(&gbuf->lock);
+		kfree(gbuf->pages);
+		gbuf->pages = tmp_pages;
 		old_ptr = gbuf->ptr;
 		gbuf->ptr = ptr;
-		tmp_pages = gbuf->pages;
-		gbuf->pages = pages;
-		j = gbuf->nrpages;
 		gbuf->nrpages = nrpages;
 		spin_unlock(&gbuf->lock);
-		ret = 0;
-		if (!tmp_pages) {
-			DBG_BUGON(old_ptr);
-			continue;
-		}
-
 		if (old_ptr)
 			vunmap(old_ptr);
-free_pagearray:
-		while (j)
-			erofs_pagepool_add(&pagepool, tmp_pages[--j]);
-		kfree(tmp_pages);
-		if (ret)
-			break;
 	}
+	ret = 0;
 	z_erofs_gbuf_nrpages = nrpages;
-	erofs_release_pages(&pagepool);
 out:
+	if (ret && tmp_pages) {
+		for (j = 0; j < nrpages; ++j)
+			if (tmp_pages[j] && tmp_pages[j] != gbuf->pages[j])
+				__free_page(tmp_pages[j]);
+		kfree(tmp_pages);
+	}
 	mutex_unlock(&gbuf_resize_mutex);
 	return ret;
 }
-- 
2.25.1

