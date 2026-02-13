Return-Path: <linux-erofs+bounces-2315-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKGkNxTXjmmhFQEAu9opvQ
	(envelope-from <linux-erofs+bounces-2315-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 13 Feb 2026 08:47:32 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 673E2133B2E
	for <lists+linux-erofs@lfdr.de>; Fri, 13 Feb 2026 08:47:31 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fC45F1Jtxz2yL8;
	Fri, 13 Feb 2026 18:47:29 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.219
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770968849;
	cv=none; b=MlHcYv+foQPGJtSBu79V5Lt53Kb7aT/exryVHWhNBf71La3W12yC6LBzhnls/5tslVbxGetLcFPP8In1C/l+CMVQvuHWvD0hGvjL3ACjJa2xbxp+ftu/pDkVH1YXdgOb2h3N8wrkHZiCskLQVP36hq1JNhhYpSzIObB5ff8bI0tbTKFOtioBZQzRsTN7wUhN0/YnfxonAWHAcVcWNQ/ietfgJTFUjTyGRJYjsb3cqIGJgnSJBxQkkHpwjAb7KmpjMHLVFMhId70QGBsdEJ6mGRR/KeQPF+fsZzlGsi34HZsk+4AOIhDDCsLMsJQmaX+c2ZepQ4kfDjoQuqutfYQrcw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770968849; c=relaxed/relaxed;
	bh=3XNdty5a43OTAqhwjQ0kXNuw1GyPUDUGoKJlC3miOrY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L0JfJR4KITnsqV6M8bZA72sMC0dPhqYukyhexX4sLcOXXaFRaR9XiiOgGYHgbmG33jrVDMWoAlrJ167UrCK0PwXFPlRf4G0heQKC2wx8ko/eHnTERdg5DgGkLzZjxvDBnk92p101zJGirbtGNB6uKABMTnqU1V5Q/nvOX/uv6v6EzC4lSVl12XkCI9jma2cLStl9fCJgoA6yX4CtkgYkWL2u/DTE+zXI8Gm7ktnz7ibmZLqZLqywIA5YSw5B/k+svFkDSKE+mGWRiA7z5i4qZDsMfKjx3UglO7JV7hd6bhbeB6gKjMT79tNZNokOux2D31f0zLyagBA+JOt2QacR8Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=dfSVEQwZ; dkim-atps=neutral; spf=pass (client-ip=113.46.200.219; helo=canpmsgout04.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=dfSVEQwZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.219; helo=canpmsgout04.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fC45B6kQ6z2xdY
	for <linux-erofs@lists.ozlabs.org>; Fri, 13 Feb 2026 18:47:25 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=3XNdty5a43OTAqhwjQ0kXNuw1GyPUDUGoKJlC3miOrY=;
	b=dfSVEQwZa7ra/7xwGhKB78g0MENPkd/KEg7mjq92Fku/DR6C74UQm8Dd5aQzx7WfbXiUhM7mB
	12VOcS4OhDk73PB04SlsGDDTVhOmj2UBQL30fO7lkU9v65/kHLzvtVg7Cg+PsqXqnSwtHgL8fvX
	gnANS/0Dph64dukM1lpk4x4=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4fC3zd4Tq1z1prMF;
	Fri, 13 Feb 2026 15:42:37 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 97C964036C;
	Fri, 13 Feb 2026 15:47:19 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 13 Feb
 2026 15:47:19 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>
CC: <xiang@kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <lihongbo22@huawei.com>
Subject: [PATCH] erofs: allow sharing page cache with the same aops only
Date: Fri, 13 Feb 2026 07:33:45 +0000
Message-ID: <20260213073345.768320-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.67.174.162]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemr500015.china.huawei.com (7.202.195.162)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.70 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2315-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:chao@kernel.org,m:xiang@kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:lihongbo22@huawei.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lihongbo22@huawei.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[lihongbo22@huawei.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	HAS_XOIP(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,huawei.com:mid,huawei.com:dkim,huawei.com:email]
X-Rspamd-Queue-Id: 673E2133B2E
X-Rspamd-Action: no action

Inode with identical data but different @aops cannot be mixed
because the page cache is managed by different subsystems (e.g.,
@aops for compressed on-disk inodes cannot handle plain on-disk
inodes).

In this patch, we never allow inodes to share the page cache
among plain, compressed, and fileio cases. When a shared inode
is created, we initialize @aops that is the same as the initial
real inode, and subsequent inodes cannot share the page cache
if the inferred @aops differ from the corresponding shared inode.

This is reasonable as a first step because, in typical use cases,
if an inode is compressible, it will fall into compressed
inodes across different filesystem images unless users use plain
filesystems. However, in that cases, users will use plain
filesystems all the time.

Fixes: 5ef3208e3be5 ("erofs: introduce the page cache share feature")
Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/erofs/inode.c    |  3 ++-
 fs/erofs/internal.h | 20 +++++++++-----------
 fs/erofs/ishare.c   | 14 +++++++++-----
 3 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 4f86169c23f1..5b05272fd9c4 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -254,7 +254,8 @@ static int erofs_fill_inode(struct inode *inode)
 	}
 
 	mapping_set_large_folios(inode->i_mapping);
-	return erofs_inode_set_aops(inode, inode, false);
+	inode->i_mapping->a_ops = erofs_get_aops(inode, false);
+	return IS_ERR(inode->i_mapping->a_ops) ? PTR_ERR(inode->i_mapping->a_ops) : 0;
 }
 
 /*
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index d1634455e389..764e81b3bc08 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -471,26 +471,24 @@ static inline void *erofs_vm_map_ram(struct page **pages, unsigned int count)
 	return NULL;
 }
 
-static inline int erofs_inode_set_aops(struct inode *inode,
-				       struct inode *realinode, bool no_fscache)
+static inline const struct address_space_operations *
+erofs_get_aops(struct inode *realinode, bool no_fscache)
 {
 	if (erofs_inode_is_data_compressed(EROFS_I(realinode)->datalayout)) {
 		if (!IS_ENABLED(CONFIG_EROFS_FS_ZIP))
-			return -EOPNOTSUPP;
+			return ERR_PTR(-EOPNOTSUPP);
 		DO_ONCE_LITE_IF(realinode->i_blkbits != PAGE_SHIFT,
 			  erofs_info, realinode->i_sb,
 			  "EXPERIMENTAL EROFS subpage compressed block support in use. Use at your own risk!");
-		inode->i_mapping->a_ops = &z_erofs_aops;
-		return 0;
+		return &z_erofs_aops;
 	}
-	inode->i_mapping->a_ops = &erofs_aops;
-	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && !no_fscache &&
-	    erofs_is_fscache_mode(realinode->i_sb))
-		inode->i_mapping->a_ops = &erofs_fscache_access_aops;
 	if (IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) &&
 	    erofs_is_fileio_mode(EROFS_SB(realinode->i_sb)))
-		inode->i_mapping->a_ops = &erofs_fileio_aops;
-	return 0;
+		return &erofs_fileio_aops;
+	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && !no_fscache &&
+	    erofs_is_fscache_mode(realinode->i_sb))
+		return &erofs_fscache_access_aops;
+	return &erofs_aops;
 }
 
 int erofs_register_sysfs(struct super_block *sb);
diff --git a/fs/erofs/ishare.c b/fs/erofs/ishare.c
index ce980320a8b9..829d50d5c717 100644
--- a/fs/erofs/ishare.c
+++ b/fs/erofs/ishare.c
@@ -40,10 +40,14 @@ bool erofs_ishare_fill_inode(struct inode *inode)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(inode->i_sb);
 	struct erofs_inode *vi = EROFS_I(inode);
+	const struct address_space_operations *aops;
 	struct erofs_inode_fingerprint fp;
 	struct inode *sharedinode;
 	unsigned long hash;
 
+	aops = erofs_get_aops(inode, true);
+	if (IS_ERR(aops))
+		return false;
 	if (erofs_xattr_fill_inode_fingerprint(&fp, inode, sbi->domain_id))
 		return false;
 	hash = xxh32(fp.opaque, fp.size, 0);
@@ -56,15 +60,15 @@ bool erofs_ishare_fill_inode(struct inode *inode)
 	}
 
 	if (inode_state_read_once(sharedinode) & I_NEW) {
-		if (erofs_inode_set_aops(sharedinode, inode, true)) {
-			iget_failed(sharedinode);
-			kfree(fp.opaque);
-			return false;
-		}
+		sharedinode->i_mapping->a_ops = aops;
 		sharedinode->i_size = vi->vfs_inode.i_size;
 		unlock_new_inode(sharedinode);
 	} else {
 		kfree(fp.opaque);
+		if (aops != sharedinode->i_mapping->a_ops) {
+			iput(sharedinode);
+			return false;
+		}
 		if (sharedinode->i_size != vi->vfs_inode.i_size) {
 			_erofs_printk(inode->i_sb, KERN_WARNING
 				"size(%lld:%lld) not matches for the same fingerprint\n",
-- 
2.22.0


