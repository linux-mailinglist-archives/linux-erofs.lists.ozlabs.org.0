Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 217915FFF37
	for <lists+linux-erofs@lfdr.de>; Sun, 16 Oct 2022 14:38:15 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Mr05r4cW5z3bjc
	for <lists+linux-erofs@lfdr.de>; Sun, 16 Oct 2022 23:38:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=Yq/ONTiV;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=outlook.com (client-ip=40.92.98.40; helo=jpn01-os0-obe.outbound.protection.outlook.com; envelope-from=set_pte_at@outlook.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=Yq/ONTiV;
	dkim-atps=neutral
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2040.outbound.protection.outlook.com [40.92.98.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Mr05g6v1Xz2xkV
	for <linux-erofs@lists.ozlabs.org>; Sun, 16 Oct 2022 23:37:58 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uud50/3g0yiBR1vN8igjogIINwxVHhVByR3vAMfJzqWPdGzKCwh32tKS3LM+KOXK+HMJ1Obmyl2K0P9o2iw8ykQ2qynCwjuw7zW/onSsViQladNlGBxhVOdnLGQZBekEiFvzotG9ahCWsg8Qg0e0ZBG4JmqN1ShToPpJyOY6Bf7mmCi2bUmfkMGQgqtXbnygbf/1LK9hl8OpzJEeUXzdcNVjRfm4sv6y5zJCKmz17Y5hUYwud918JHIiG8aFJ4FPLsDD5lo/nqtUZ/j5vY0/nq6u/WCpvY0WPsKz2r6hXq0kpmVccWHvu4c2CrxHCOriFYh9ndJdiy8PrzAp0Hy5dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WK7gp5/Aa/+dSRRDiVrvrlJIjgTrN7AtJ42tWhg73Oc=;
 b=IQNGMv/iheVpKycsoXStkYO7HD2IZ6IwwTvdlpdRF0jvtBsaZvCznagC+8UCtxDumk+Xijk068w6LTvMGHX1XWUk64zMvBD6/+JE0YUVARD+QmmP+4CUn/YZ9t5PTNffPMZexYhy45EvI61uw4T00QVI08AD1YmI2rFQDs+eVvubQeaHPasDZ/OeJ8V+PBJUcCfJaDz+wL8R+5CXNhL9F/fIKzca76c4ux254DYqkWalbAfO2NsZKduiRmqrh8701cD/6HGucJpjKP2eELWQ8cE+KkfGn6YYVfEMI477JsLhm397e/2qLnBP830UleSpp42nsDuZkOULRXlxNwmgaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WK7gp5/Aa/+dSRRDiVrvrlJIjgTrN7AtJ42tWhg73Oc=;
 b=Yq/ONTiVRQD5t3j85umKjNN0BCIgaXaeAMSeMDV3iHGbHFdSYlJQx6f/uiRY4klHF/eUuymTQQciI6Rps4zVcfa+swccZoyoL5Di2KyRZez7ia3pkO4vrZt95Aj9knUMC96TNcR/PbGFGhauK+99oD5Cy8D663bZeukbpauJJotmojOOPKhSUY5eN4r6+VOPCiDz+mzgvz8oSArop1btSRNB+LN4jZ4feLbathlEFBs9GQiobC5pNapPX7/9GgIKALY2iNlLtdi/3zabXOFKU/QVcFH0IA38l9ec/QLlmrAybcGrRZHjz8j6Onygkcj3NUhVvOh8AO11TmdwoLsdQQ==
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:152::9)
 by OS3P286MB1995.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Sun, 16 Oct
 2022 12:37:38 +0000
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::4722:62da:4861:9d73]) by TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::4722:62da:4861:9d73%3]) with mapi id 15.20.5723.032; Sun, 16 Oct 2022
 12:37:38 +0000
From: Dawei Li <set_pte_at@outlook.com>
To: xiang@kernel.org,
	chao@kernel.org
Subject: [PATCH] erofs: protect s_inodes with s_inode_list_lock
Date: Sun, 16 Oct 2022 20:37:27 +0800
Message-ID:  <TYCP286MB23237A9993E0FFCFE5C2BDBECA269@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [PbdqvwTyeoR3jwn62LfPi26ITmOTXWFk]
X-ClientProxiedBy: TYAPR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:404:15::25) To TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:152::9)
X-Microsoft-Original-Message-ID:  <20221016123727.968140-1-set_pte_at@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2323:EE_|OS3P286MB1995:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fe8c52a-684a-4826-27e4-08daaf733582
X-MS-Exchange-SLBlob-MailProps: 	rYPt1fhvLTUem4+YyY73AHtcx1Y7uWZY7h8dTY5gRgdLwDc/DfIlDBdyAyhkMh2RyyrUK3oItCkCUNAecS6PDZlRSCADoGgzPK/D8AphLX/CM8c7qtsHUK/7m24ivIwMOKmF/eDZWvt0TtS9YhgbbntMGvTuSCHCxNdcnJlkRBP8BWHVbmVKLtg5V+RwIAjQUUEAYVUmExqtzcwumcWik5rmK47FXWgNy+wBVUUtgEBL+Bc1jMC7Rk3vNSL7PFy3o5ohPrBb+RrwtpAyCqaAUNlCH3hXRMJ3hI0IjupFctZBF7/vSYHyCrf/izUlYEIdz60IcD3zeHueEG3eRK9UMqhUIYXjwUGNBoW7/aH6aeFxrOkBbCojCCsTN/6y9ViOlX8FSupfp5HSCjKuNFaDc+GC+GoBwA4C8EvxtUjDyxYv/Z2tI08glIPPA1vVBYMDRBR9B+wb70pmbL7lgeX0qmnUcdklS/a1oPbBRiReIjd+lpOTY4YoO3CwhtbMa+uvAd9lYFtjX/Gwubzv+onKbWCvCKr8AuGsvIbK5gOdKu4PYsouipWRdefk0omgxfw4gYXVgKrVfWcTP9/Vv2hjfhtmU6JcboRddSieVYshR7a8o0atfFkFRcYNMnK2XYW7cCjwaCKFtywfRH9InJDmyAmwe/WZecVpOeG0PXzVBZVnZ9XZQZYEXeVSbLpq1al0A162iltt8RvkcG5Jdjfd4g==
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	edA3GGXdf9DbAUizvnHZRSKOFN0KcoWJ1PPVSUtCuJb8/zJpQdYANJaXeVp6ZSjsAOrMZ8XPTuO3oIC2oq3aJ/lO+fC2ZGK5q8siwxS1sGFac/6sv0N+nne/oXEbVzpygK7GvRfTFupoznsWookwY5FUHPVxlfWDZhi8U3rSYiicUrdR+OwP1YawTihSOXW3mhjoJ8hoAbLhbxxhIj0CQ40qCY0+ccRx/7wt+qMnGn8vBLVBo2L0GhFsQtqs+191YyDl3oRm4QvmYMeME8zCrydwUK8BjpAvuzUY4wokMWB7xYI4zGlH78c299UnkiK3yyilQuKFcRjjhF/z3pp5BhPX2WYZOJOcPXZY0CoG9QPwYKDINJC/Ic9x9FH/oGU5mq9UUcOkMfzA+LgEzfjfEtg8+jV2fPUsLWazBX3PcE+2E1U72R4mciw+N+6j58LaI95dLJd6ZJw/uHcc+WC9WkXUIUKJeonTSeRnQMLkfbjCf3SiHpj/LKEm7bxvX3IpQ8UWeOp/WqVt+bxJEhh0LbDKXB+4NoVdpLKbgl0Wv2ScG/crloAYmXRF57ep+oncEFU31prn6sK0w9m3AR0/WG5kLDurmcp6v6PPpfXZ492gAR/5d/FRPNWlpK56VR1YkZkIqfg105iy0ArBQcBB2XAQ79olVc9vgnUoGDIY3gZVx0deihvnZPZHmJ3eR3tj
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?AkUkBAqEhjYXSaWyqxx7QLzdSxsjKUGG8DuKxZEuKU2nyxrxFTotZCSRCNYQ?=
 =?us-ascii?Q?bBScwQJVNgM2je91KACn/JPLJNF+06rX9fAtxNFsYuMJAvPOBztTuVvRqqaU?=
 =?us-ascii?Q?16vxNDVaUhl85IuDA6zNEo7mbT1SM0sGMst3uRVjphD03KrB3ZcVJuwv8rTQ?=
 =?us-ascii?Q?yvKrN0p8fYHxEOOn5fg8Nr9myThN2oa88yhkGpM/NlWWrst7CYk4/xisgqhx?=
 =?us-ascii?Q?0lIvvFIWnz0uQIBYRD7AHs6nDblYCXnkfrwcvO7vPK4CaHn71gQsZv2KjuC1?=
 =?us-ascii?Q?L3VH6fp3AMAsPmi413JnA2LyO+kQ/VAaFZU1Qky6Ap7LFaU1SspEhqBBSpCv?=
 =?us-ascii?Q?SoXoZ9bkcTWgLGNBhlHKEHoFAMw0lsFJQALhjExjGQBxooHTNGQgArOBl8m4?=
 =?us-ascii?Q?DB/WhDyV7tXI6oV3p6K+ggetmSPLYFN2xbuIBuyoD1eDGMGbvrwIeBxNkf2k?=
 =?us-ascii?Q?L/JHl1q6ph3Qhli378bjv7omwhj/4tImzQycN43tzzT7Hr6JGKPHcPVCfva2?=
 =?us-ascii?Q?GYIEMg3aERgmUkU+/Zsbityd8cEeZLKu3oQBF9OD1yjS3WgSHJKAEqz2wNH6?=
 =?us-ascii?Q?waNAixUtyjSh4x+WXzRPi5/VgRgsvwGIt57bSEuPKUgHAOrR2fJOoYQWB0jj?=
 =?us-ascii?Q?d4et2hiz8S8z3McecWWiib5413oqpnol9P3XjGfQREvSgQ36+CSoyTOAF0A0?=
 =?us-ascii?Q?rj6bTaPnmthCIaJMdispL12VeevPI4C17vDQFpJzxWGwt2mjyhLx5aS3ltyx?=
 =?us-ascii?Q?tx9mKt/T6SZFPELgzxa+10UpEjhleNyRfRWrVqtv/6N3r/Xm53Eb3FwQNmKj?=
 =?us-ascii?Q?0wj4w7yg01GCMJKuG+zCrZ1o00qyBHkIj3fwKpu/0NzqSAKdykT/ijEg6hdK?=
 =?us-ascii?Q?U6zxvbWUqeDv8mNolDBvpcdPBCcQL08rlfVjxv4OxIXSLnUQI6xPT+mpJpU6?=
 =?us-ascii?Q?ZZEyFyXb/8cpbFm+6WyoKQfhY3dLfwVsdQMkmsDEaLjsueGQug8xepIyk/qA?=
 =?us-ascii?Q?J7Hj2xm8lumRC3zmzfWLo6/ZtdLOpvdi368/2SZkzx0bUolq6pwyTt5v7GVH?=
 =?us-ascii?Q?8VYZTWKauZmugQGxwwIf8Y9ddltGwFi7qVn11xhgqUVg69uM4mCJi5vvBfLN?=
 =?us-ascii?Q?1/Lxn13vK+h8cvP6s+INz/zMlMzzxJvExWpJVzjdnmTUk5U4Knx/M+Tg/I1g?=
 =?us-ascii?Q?n1DJIZVNmUWlfgocq9wnn8FXKJswSH5SxlrGYdH+yMLVTKK9OJ2z/Opmb4Qj?=
 =?us-ascii?Q?F6rVUrV8iDZ1fSVBYECk1yNbNoE328xH/jiWukEexA=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fe8c52a-684a-4826-27e4-08daaf733582
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2022 12:37:38.2042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB1995
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
Cc: Dawei Li <set_pte_at@outlook.com>, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

s_inodes is superblock-specific resource, which should be
protected by sb's specific lock s_inode_list_lock.

base-commit: 8436c4a57bd147b0bd2943ab499bb8368981b9e1

Signed-off-by: Dawei Li <set_pte_at@outlook.com>
---
 fs/erofs/fscache.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 998cd26a1b3b..bbf5268440df 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -589,15 +589,18 @@ struct erofs_fscache *erofs_domain_register_cookie(struct super_block *sb,
 	struct erofs_domain *domain = EROFS_SB(sb)->domain;
 	struct super_block *psb = erofs_pseudo_mnt->mnt_sb;
 
-	mutex_lock(&erofs_domain_cookies_lock);
+	spin_lock(&psb->s_inode_list_lock);
 	list_for_each_entry(inode, &psb->s_inodes, i_sb_list) {
 		ctx = inode->i_private;
 		if (!ctx || ctx->domain != domain || strcmp(ctx->name, name))
 			continue;
 		igrab(inode);
-		mutex_unlock(&erofs_domain_cookies_lock);
+		spin_unlock(&psb->s_inode_list_lock);
 		return ctx;
 	}
+	spin_unlock(&psb->s_inode_list_lock);
+
+	mutex_lock(&erofs_domain_cookies_lock);
 	ctx = erofs_fscache_domain_init_cookie(sb, name, need_inode);
 	mutex_unlock(&erofs_domain_cookies_lock);
 	return ctx;
-- 
2.25.1

