Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64255588E9B
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Aug 2022 16:23:47 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LyYxq43SHz2yMk
	for <lists+linux-erofs@lfdr.de>; Thu,  4 Aug 2022 00:23:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1659536623;
	bh=PreLvg+OrZYk5ZVWrS+Fkzmt5EjX9TWBB2BGQturXcI=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=bS9AjXIZOKobJpuaz00w3Im7mw+nDoIC2jwWjRABGvJFNv/aluwfphcptJbg9vf3Q
	 Ui2Ku3MwkhbvTk9Zno2f0S+S/EzSb3cJAg4LCs3Or9zntJ/l/eONuexoUUS3IE82lq
	 cdYPlx5Fl4qOjhkEJGVLOQjTcN7l4q7L6N5v3QtwO1F+6HV7dIQV2b2SrIGjY2NUZX
	 w8rRJmbqvnMACFzAPwfFwG7NlLGE7p6X0JlwwPsmwD2ZtYB1XXGs3D/YtUM2fY/IWp
	 /vGXQo+b+mPncL3GhOAlgAIxstKG3LMXeggFvShsVindHT9k4FUrl9znSsyB+L4Ky3
	 pmnAnIIpdnf6g==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.helo=apc01-sg2-obe.outbound.protection.outlook.com (client-ip=40.107.215.64; helo=apc01-sg2-obe.outbound.protection.outlook.com; envelope-from=shengyong@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256 header.s=selector1 header.b=AyqG5Nko;
	dkim-atps=neutral
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2064.outbound.protection.outlook.com [40.107.215.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LyYxb6fbSz2yMk
	for <linux-erofs@lists.ozlabs.org>; Thu,  4 Aug 2022 00:23:31 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KudD5ufpgjAy4SLZWRVWGDPK7TWwmwGPpKeWv9VF2A77bnTITxWAKSwVHtojmkQmSN2b9CxF2sgwOfKigBxn3zHVWNGNwtWPsc+dq0HXJ04see75bzMpWe4f2MDbJVAdIX+g9//ZloaiNqbashNSnSFUlz8rp+87jBdNkwfCpD1DM7C3zJJTiOZBbptz6pbb7IJXyiTfSSd1QCC1KyeV8MhQRbUmqR44TKH83amaCVnpAWH9PhX++1GIfnJra7y/R3iJlaxtBy5mAO8bYaKRo52I1wRE0VTMaGreBoe11i0Blu0P8/0Ar8o/mpM7BqGowxFgeQZ084GM9otdfPWWow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PreLvg+OrZYk5ZVWrS+Fkzmt5EjX9TWBB2BGQturXcI=;
 b=aqjDtBddlnI4mq18ig6snKILCLQV1HvEfH2PfKKSzXuA7d3Is9DQfZNMo2aTe06NxiZv5l6ypdalOz7UznBHMwxxuKOjNs58Wg+R9EqyT4sfe2uRsUePVzdEdMaG3wkoiQ8o0I8jwX2s88b4E/QoeaHeM7REaed7M+sHTiqFxAAZIx7JXvLVUiJQFqbbm+hp/R42FHfd+GEumMJb0MJ+8BjzJhtlCpa0h2Wxt5KVE7f2C12JTDHIFV2ksQ0harD27tDTzUjRY8PBON2tA6NoF4MzjJpanQJgg8yPjNxNX8w1qJS6LFVNmf6FaBvA4Br1mvYraBYnlVYGRI/2PochHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from SI2PR02MB5148.apcprd02.prod.outlook.com (2603:1096:4:153::6) by
 TY2PR02MB4493.apcprd02.prod.outlook.com (2603:1096:404:800d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Wed, 3 Aug
 2022 14:23:10 +0000
Received: from SI2PR02MB5148.apcprd02.prod.outlook.com
 ([fe80::adea:6739:ab8a:9adf]) by SI2PR02MB5148.apcprd02.prod.outlook.com
 ([fe80::adea:6739:ab8a:9adf%3]) with mapi id 15.20.5504.014; Wed, 3 Aug 2022
 14:23:10 +0000
To: xiang@kernel.org,
	bluce.lee@aliyun.com,
	linux-erofs@lists.ozlabs.org,
	chao@kernel.org
Subject: [RFC PATCH 2/3] erofs-utils: fuse: export erofs_xattr_foreach
Date: Wed,  3 Aug 2022 22:22:22 +0800
Message-Id: <20220803142223.3962974-3-shengyong@oppo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220803142223.3962974-1-shengyong@oppo.com>
References: <20220803142223.3962974-1-shengyong@oppo.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: SGXP274CA0017.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::29)
 To SI2PR02MB5148.apcprd02.prod.outlook.com (2603:1096:4:153::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91cabacb-fe58-4a93-eb90-08da755bb123
X-MS-TrafficTypeDiagnostic: TY2PR02MB4493:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	XFO6r7UgRWm3/Dtp46laN7rBgmsSbLzhqbx4GnApGCJlI370LOrbZQoP796eXA8Dud271RdNAhbRUOR/TvmIyXAR4zagAILFzJaXMQ4w49hz5/ijJFkFCmFlCuxj3Bl0Tqko7fPhx+yaWvQddg6gCmTDIxGkcKdyBzFHCKezFoIeTH5g+kZTBiGOfvedh19OAMdVcauxYMcprSa67M4Lm5rm7SeyAYXpB/lywVzx0aHiVkdpAR+QG5Hk3EIIDAXTjWVAcwq7jIhFaIiPvQwu1gfF53XcivZfq9mdWbB4pneZJTcFlgrV7zti+H61zE9dvv4cU70glglTc8uXSdHwBulyDqM5A1GW8uyQTKKjo8Y6zpdhoPUmhwQFeheRrNDK9VV4A6rG6sN9Zk94SpChdbTRpmFusDYkgHEbqpIk8NtVCmVZQTZxqqmyp6qd2RPnMHkHI05dj4JHIyx5l+zF0lWR63uspbavWDJSDVsnAzmnMFDUgSPnJLBfHOd9/UuXBvjC0WY7Ja14I9kJ9WxGzKehWI0ZmAUKL0Jhwvugsc+X0LQ8mEiY008vG/k2H95yDk4J+dvIgYDHDD8Yja6KpU3wdz57PEtwxTAHmrHNbUGPROIYeoSDfzfdu7akw01Ndu1+znWEJqRsBg6DfO1v0eBYcvjhX1itOo+00JHIEIh4IbQPtEG0BRGwrNjGKdlq09ffIFevBnBvfdpV62buc0rQR4TLmitW70sXmNfeIwoOIRRnifyETV4QZ/rgV7ruMh3F7kZPxQW7LIjXuGUkJDg6t8y05B4nFVyJrcBOeCI=
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR02MB5148.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(376002)(366004)(396003)(136003)(8676002)(186003)(66946007)(4326008)(66556008)(6512007)(1076003)(2616005)(86362001)(107886003)(6666004)(66476007)(316002)(41300700001)(6506007)(26005)(6486002)(52116002)(478600001)(36756003)(2906002)(38350700002)(83380400001)(5660300002)(38100700002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?OLJgktAYJy7xgy0ODbXRbxgDdu9Fkb1ojyNVgGY6KrqyCzffIY8QVwLobORx?=
 =?us-ascii?Q?MXw/oUSJljM9r4EQ3ASTPP50p1Ne8UzzI5zjHMOQdamDXUP8hblZJOQBCAOL?=
 =?us-ascii?Q?w15ixFzbmQa6+oBAuJj9K2kL/QkL7X3do5aGIvZjWwVZPsOEJ4QpeBJk5bi7?=
 =?us-ascii?Q?3XhjZDDBWyoM45e5C7oynNBBN32GYsO0h/asLqrn8z7mP2RlyyEjwHj7Lzum?=
 =?us-ascii?Q?0Nz3YQsPtMHkCntryndSQc5dVT0mDfqB4tArF/F8qSLBSpvsHhjrYOIoyGpm?=
 =?us-ascii?Q?atUSEwZHXpozXOsSy40G4fJMxCUCBrF4VLWNvPvrkpqFpmcvvai4/j3J4BVa?=
 =?us-ascii?Q?puMAe4fb8t8i4rWYi+TWdpdGQF7IVLQtyJrEfCLECWrqcYmcESuecolxqYbO?=
 =?us-ascii?Q?xatqxAkC52wyt8kPjapmkMx92cGdGA9ME88hHdLf5dNofM3Uf4FqZCVp36QH?=
 =?us-ascii?Q?jB5nQqdkk62Dl9eMrRflJWtZmUN0Z/dpuDposr78c9fdzgywSocIx3AV5SJ9?=
 =?us-ascii?Q?oy7kHAkJH+To5+U3+2Cua0D4AbZ5I9blLi2dLRuHZM5rKY+bB4ZzKe+msN2b?=
 =?us-ascii?Q?eXxnorNlmWy79KeSX/PzKm6mbv/lJJzisOoHtP1kOda5hLLNp863OGbtnOVD?=
 =?us-ascii?Q?9s226Qpyo4EMs6eZ+wB1PzSMOuM3Q/bpc/8K9/Mfqi5tMev1hibfzApZinvA?=
 =?us-ascii?Q?Gi4ZliOmoaH/1tRgzQ1y8CaN7+hYRymYJuFJskRQIRkz6JEO3mKokebt9xKv?=
 =?us-ascii?Q?jS94u54pD2V/ccmf9wV8ZNwSjctAXiC05XOYTME+PjtLqr6H2w3BLsMcAgsa?=
 =?us-ascii?Q?ZY5RujYVH7/G1SCniblQBPQHnkVzIuzziDC1jzNdhGc8UaX7n002PGmZKN+0?=
 =?us-ascii?Q?ZW+mYwQ45hOLWKqB7x9SLCs5NdWgcKjwB9YBvx+9NHh85nStUpYiBgmiJKMw?=
 =?us-ascii?Q?IoO5JcR3wn3YSmGD7aaf5RTK+QNCjbUg61maDCgym+1L0C8AAWCEbvuS/KAj?=
 =?us-ascii?Q?MbgTlUmwAIDYh0849xvtGvWim/fCLzOeQGt8dvDx+KRqyUyTpnIsfTjhYzy2?=
 =?us-ascii?Q?Gq1jLXouHqCgad9FleAj6waiTjzopc+3bQuZARjEyjPUCNW1pnx6d6C717/f?=
 =?us-ascii?Q?fsFBmFTN7aymhfbNa8oKq0PT80LzTTUwgruKkXKXMYB6EVcooAJwPbfOGSP1?=
 =?us-ascii?Q?0CBQ723ar7nZCEthGo5zkR9maPdcERSArO6cKgrtns0imb7A9bjgvBoqSUKC?=
 =?us-ascii?Q?awNGYS9yLQ/IaBXxYpQCHyXb7KvAODt1YzPs4/LSDOp3v6adjONh8Y5KOtHM?=
 =?us-ascii?Q?2smJTCN/8OSAFUsoXmypZgYfTDvwh7cg0JAEjEFl/R3vwdyNYqcd7ybqTi4W?=
 =?us-ascii?Q?yS1nwh/zmCGYo2p9MTYw2qVM+D1sJvRp67vM0/n4R+Nx5Mlyq2VVeqe2iBq8?=
 =?us-ascii?Q?0Hm6Km8hrffM3WQkzezvLpwPkMQtQoZKrTxcivOcrE+p4CHfzzUWef66Xj++?=
 =?us-ascii?Q?ZHb9dSDeLdwsgwtjjhUWGQoAuiDlFZoNn71RI+QN2sfnQuxigscH89Pt0hFf?=
 =?us-ascii?Q?rKyBL7A99Hjftltx98FTa+WwKlgmpeiv+FIwQtNk?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91cabacb-fe58-4a93-eb90-08da755bb123
X-MS-Exchange-CrossTenant-AuthSource: SI2PR02MB5148.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2022 14:23:10.3084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lhp83EEaaXt6RH29kE7uvgR/kOlBIaoLfptJv1G4PBtKfvDbX/Gqp/dqB6dlOBv84HfVOJtjccKdQ7BgIg0epA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR02MB4493
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
From: Sheng Yong via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Sheng Yong <shengyong@oppo.com>
Cc: shengyong@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This patch exports erofs_xattr_foreach() to iterate all xattrs.
Each xattr entry is handled by operations defined in `struct
xattr_iter_ops'.

Signed-off-by: Sheng Yong <shengyong@oppo.com>
---
 fsck/main.c           |  83 ++++------------------------
 include/erofs/xattr.h |   7 ++-
 lib/xattr.c           | 123 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 139 insertions(+), 74 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index 5a2f659..237ccc1 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -14,6 +14,7 @@
 #include "erofs/compress.h"
 #include "erofs/decompress.h"
 #include "erofs/dir.h"
+#include "erofs/xattr.h"

 static int erofsfsck_check_inode(erofs_nid_t pnid, erofs_nid_t nid);

@@ -283,82 +284,18 @@ static int erofs_check_sb_chksum(void)
        return 0;
 }

-static int erofs_verify_xattr(struct erofs_inode *inode)
+static int erofs_verify_xattr_entry(const struct erofs_xattr_entry *entry)
 {
-       unsigned int xattr_hdr_size =3D sizeof(struct erofs_xattr_ibody_hea=
der);
-       unsigned int xattr_entry_size =3D sizeof(struct erofs_xattr_entry);
-       erofs_off_t addr;
-       unsigned int ofs, xattr_shared_count;
-       struct erofs_xattr_ibody_header *ih;
-       struct erofs_xattr_entry *entry;
-       int i, remaining =3D inode->xattr_isize, ret =3D 0;
-       char buf[EROFS_BLKSIZ];
-
-       if (inode->xattr_isize =3D=3D xattr_hdr_size) {
-               erofs_err("xattr_isize %d of nid %llu is not supported yet"=
,
-                         inode->xattr_isize, inode->nid | 0ULL);
-               ret =3D -EFSCORRUPTED;
-               goto out;
-       } else if (inode->xattr_isize < xattr_hdr_size) {
-               if (inode->xattr_isize) {
-                       erofs_err("bogus xattr ibody @ nid %llu",
-                                 inode->nid | 0ULL);
-                       ret =3D -EFSCORRUPTED;
-                       goto out;
-               }
-       }
-
-       addr =3D iloc(inode->nid) + inode->inode_isize;
-       ret =3D dev_read(0, buf, addr, xattr_hdr_size);
-       if (ret < 0) {
-               erofs_err("failed to read xattr header @ nid %llu: %d",
-                         inode->nid | 0ULL, ret);
-               goto out;
-       }
-       ih =3D (struct erofs_xattr_ibody_header *)buf;
-       xattr_shared_count =3D ih->h_shared_count;
-
-       ofs =3D erofs_blkoff(addr) + xattr_hdr_size;
-       addr +=3D xattr_hdr_size;
-       remaining -=3D xattr_hdr_size;
-       for (i =3D 0; i < xattr_shared_count; ++i) {
-               if (ofs >=3D EROFS_BLKSIZ) {
-                       if (ofs !=3D EROFS_BLKSIZ) {
-                               erofs_err("unaligned xattr entry in xattr s=
hared area @ nid %llu",
-                                         inode->nid | 0ULL);
-                               ret =3D -EFSCORRUPTED;
-                               goto out;
-                       }
-                       ofs =3D 0;
-               }
-               ofs +=3D xattr_entry_size;
-               addr +=3D xattr_entry_size;
-               remaining -=3D xattr_entry_size;
-       }
-
-       while (remaining > 0) {
-               unsigned int entry_sz;
+       return 0;
+}

-               ret =3D dev_read(0, buf, addr, xattr_entry_size);
-               if (ret) {
-                       erofs_err("failed to read xattr entry @ nid %llu: %=
d",
-                                 inode->nid | 0ULL, ret);
-                       goto out;
-               }
+struct xattr_iter_ops erofs_verify_xattr_ops =3D {
+       .verify =3D erofs_verify_xattr_entry,
+};

-               entry =3D (struct erofs_xattr_entry *)buf;
-               entry_sz =3D erofs_xattr_entry_size(entry);
-               if (remaining < entry_sz) {
-                       erofs_err("xattr on-disk corruption: xattr entry be=
yond xattr_isize @ nid %llu",
-                                 inode->nid | 0ULL);
-                       ret =3D -EFSCORRUPTED;
-                       goto out;
-               }
-               addr +=3D entry_sz;
-               remaining -=3D entry_sz;
-       }
-out:
-       return ret;
+static int erofs_verify_xattr(struct erofs_inode *inode)
+{
+       return erofs_xattr_foreach(inode, &erofs_verify_xattr_ops, NULL);
 }

 static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd)
diff --git a/include/erofs/xattr.h b/include/erofs/xattr.h
index 226e984..c592d47 100644
--- a/include/erofs/xattr.h
+++ b/include/erofs/xattr.h
@@ -45,10 +45,15 @@ extern "C"
 #define XATTR_NAME_POSIX_ACL_DEFAULT "system.posix_acl_default"
 #endif

+struct xattr_iter_ops {
+       int (*verify)(const struct erofs_xattr_entry *entry);
+};
+
 int erofs_prepare_xattr_ibody(struct erofs_inode *inode);
 char *erofs_export_xattr_ibody(struct list_head *ixattrs, unsigned int siz=
e);
 int erofs_build_shared_xattrs_from_path(const char *path);
-
+int erofs_xattr_foreach(struct erofs_inode *vi, struct xattr_iter_ops *ops=
,
+                       void *data);
 #ifdef __cplusplus
 }
 #endif
diff --git a/lib/xattr.c b/lib/xattr.c
index c8ce278..92c155d 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -714,3 +714,126 @@ char *erofs_export_xattr_ibody(struct list_head *ixat=
trs, unsigned int size)
        DBG_BUGON(p > size);
        return buf;
 }
+
+static struct erofs_xattr_entry *read_xattr_entry(erofs_blk_t addr,
+                                                 char *buf, size_t size)
+{
+       struct erofs_xattr_entry *entry;
+       size_t entry_sz =3D sizeof(struct erofs_xattr_entry);
+       int ret;
+
+       if (size < entry_sz)
+               return ERR_PTR(-ERANGE);
+
+       ret =3D dev_read(0, buf, addr, entry_sz);
+       if (ret) {
+               erofs_err("failed to read xattr entry at addr %x: %d",
+                         addr, ret);
+               return ERR_PTR(ret);
+       }
+
+       entry =3D (struct erofs_xattr_entry *)buf;
+       entry_sz =3D erofs_xattr_entry_size(entry);
+       if (size < entry_sz)
+               return ERR_PTR(-ERANGE);
+
+       ret =3D dev_read(0, buf, addr, entry_sz);
+       if (ret) {
+               erofs_err("failed to read xattr entry at addr %x: %d",
+                         addr, ret);
+               return ERR_PTR(ret);
+       }
+
+       return entry;
+}
+
+int erofs_xattr_foreach(struct erofs_inode *vi, struct xattr_iter_ops *ops=
,
+                       void *data)
+{
+       unsigned int xattr_hdr_size =3D sizeof(struct erofs_xattr_ibody_hea=
der);
+       unsigned int xattr_entry_size =3D sizeof(struct erofs_xattr_entry);
+       erofs_off_t addr;
+       unsigned int ofs, xattr_shared_count;
+       struct erofs_xattr_ibody_header *ih;
+       struct erofs_xattr_entry *entry;
+       int i, remaining =3D vi->xattr_isize, ret =3D 0;
+       char buf[EROFS_BLKSIZ];
+
+       if (vi->xattr_isize =3D=3D xattr_hdr_size) {
+               erofs_err("xattr_isize %d of nid %llu is not supported yet"=
,
+                         vi->xattr_isize, vi->nid | 0ULL);
+               return -EFSCORRUPTED;
+       } else if (vi->xattr_isize < xattr_hdr_size) {
+               if (vi->xattr_isize) {
+                       erofs_err("bogus xattr ibody @ nid %llu",
+                                 vi->nid | 0ULL);
+                       return -EFSCORRUPTED;
+               }
+       }
+
+       addr =3D iloc(vi->nid) + vi->inode_isize;
+       ret =3D dev_read(0, buf, addr, xattr_hdr_size);
+       if (ret < 0) {
+               erofs_err("failed to read xattr header @ nid %llu: %d",
+                         vi->nid | 0ULL, ret);
+               return ret;
+       }
+       ih =3D (struct erofs_xattr_ibody_header *)buf;
+       xattr_shared_count =3D ih->h_shared_count;
+
+       ofs =3D erofs_blkoff(addr) + xattr_hdr_size;
+       addr +=3D xattr_hdr_size;
+       ret =3D dev_read(0, buf, addr, xattr_entry_size * xattr_shared_coun=
t);
+       remaining -=3D xattr_hdr_size;
+       for (i =3D 0; i < xattr_shared_count; ++i) {
+               unsigned int xattr_id;
+               erofs_blk_t xattr_addr;
+               char tmp[EROFS_BLKSIZ];
+
+               if (ofs >=3D EROFS_BLKSIZ) {
+                       if (ofs !=3D EROFS_BLKSIZ) {
+                               erofs_err("unaligned xattr entry in xattr s=
hared area @ nid %llu",
+                                         vi->nid | 0ULL);
+                               return -EFSCORRUPTED;
+                       }
+                       ofs =3D 0;
+               }
+
+               xattr_id =3D le32_to_cpu(*((__le32 *)buf + i));
+               xattr_addr =3D sbi.xattr_blkaddr * EROFS_BLKSIZ +  4 * xatt=
r_id;
+
+               entry =3D read_xattr_entry(xattr_addr, tmp, EROFS_BLKSIZ);
+               if (IS_ERR(entry))
+                       return PTR_ERR(entry);
+
+               if (ops->verify) {
+                       ret =3D ops->verify(entry);
+                       if (ret < 0)
+                               return ret;
+               }
+
+               ofs +=3D xattr_entry_size;
+               addr +=3D xattr_entry_size;
+               remaining -=3D xattr_entry_size;
+       }
+
+       while (remaining > 0) {
+               unsigned int entry_sz;
+
+               entry =3D read_xattr_entry(addr, buf, EROFS_BLKSIZ);
+               if (IS_ERR(entry))
+                       return PTR_ERR(entry);
+               entry_sz =3D erofs_xattr_entry_size(entry);
+
+               if (ops->verify) {
+                       ret =3D ops->verify(entry);
+                       if (ret < 0)
+                               return ret;
+               }
+               addr +=3D entry_sz;
+               remaining -=3D entry_sz;
+       }
+
+       return ret;
+
+}
--
2.25.1

________________________________
OPPO

=E6=9C=AC=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=
=BB=B6=E5=90=AB=E6=9C=89OPPO=E5=85=AC=E5=8F=B8=E7=9A=84=E4=BF=9D=E5=AF=86=
=E4=BF=A1=E6=81=AF=EF=BC=8C=E4=BB=85=E9=99=90=E4=BA=8E=E9=82=AE=E4=BB=B6=E6=
=8C=87=E6=98=8E=E7=9A=84=E6=94=B6=E4=BB=B6=E4=BA=BA=E4=BD=BF=E7=94=A8=EF=BC=
=88=E5=8C=85=E5=90=AB=E4=B8=AA=E4=BA=BA=E5=8F=8A=E7=BE=A4=E7=BB=84=EF=BC=89=
=E3=80=82=E7=A6=81=E6=AD=A2=E4=BB=BB=E4=BD=95=E4=BA=BA=E5=9C=A8=E6=9C=AA=E7=
=BB=8F=E6=8E=88=E6=9D=83=E7=9A=84=E6=83=85=E5=86=B5=E4=B8=8B=E4=BB=A5=E4=BB=
=BB=E4=BD=95=E5=BD=A2=E5=BC=8F=E4=BD=BF=E7=94=A8=E3=80=82=E5=A6=82=E6=9E=9C=
=E6=82=A8=E9=94=99=E6=94=B6=E4=BA=86=E6=9C=AC=E9=82=AE=E4=BB=B6=EF=BC=8C=E8=
=AF=B7=E7=AB=8B=E5=8D=B3=E4=BB=A5=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E9=80=
=9A=E7=9F=A5=E5=8F=91=E4=BB=B6=E4=BA=BA=E5=B9=B6=E5=88=A0=E9=99=A4=E6=9C=AC=
=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=E3=80=82

This e-mail and its attachments contain confidential information from OPPO,=
 which is intended only for the person or entity whose address is listed ab=
ove. Any use of the information contained herein in any way (including, but=
 not limited to, total or partial disclosure, reproduction, or disseminatio=
n) by persons other than the intended recipient(s) is prohibited. If you re=
ceive this e-mail in error, please notify the sender by phone or email imme=
diately and delete it!
