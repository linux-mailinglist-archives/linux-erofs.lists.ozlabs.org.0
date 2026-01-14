Return-Path: <linux-erofs+bounces-1855-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDA0D1D23F
	for <lists+linux-erofs@lfdr.de>; Wed, 14 Jan 2026 09:35:44 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4drfZk24kqz2xPB;
	Wed, 14 Jan 2026 19:35:42 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.219
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768379742;
	cv=none; b=mgjNd8XEAXm58D36FYf4FXCRhkoMZrUKcrDqLe1yDM74eLvcuPtF/OUMFAZtRkxGeP8Mw75iAiWyYxMXjgI5ojfxPURiRMXRvDBJNJpVQFDN1RDJ4ObpN3h66TVfisD/uCfGfGREOntS+CX6H34uCD2T42QvS+fKDetykMgDf5QuP7AKOpKiv8IOqyEfIdpcZfwdd7Bye3kfe0DjbuEqzx0I8qWwq43Z0lBXEMtoC5bAwo/KRcAoqsktuXGMSJ/MTV8gRiHLjEqoj/nj0/VhZNSgqVTZ3tKq9eXMhwmupf8/N/AVR70sNOLw3gm6Kqf6j9nof9WgHWWZNDwR3/5RCg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768379742; c=relaxed/relaxed;
	bh=bXODzpSu1BKPKU0XvLc0HoZ59Vts4yuAy3ZYsnQRtg4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xr6ygOZmvtAU7cDzIPMQW3L90pVprrGZ95oMXWNyddzzBUfggWu++m9cnsg8OY3CXQMhbej+qaF1NYTWDZPmfY5FHeKRr8FFwmlLR7w8v2oM68A/GulYKEJXu8yxy2XfU5Qjfe4hnAa/m4ir/iHTS3E8f1LxU7WGbsjDojGEm5LVYQUuFbQuUV0jmpkt0gB+PMUPd8yp+9NOqrV8+XNXzEsnV6qtO4aPQcpzIAvd5NlO+xioP9uJX7IDVnpLoLCGPAQRcyVftd2SUovX4g9GTecIqd10s0RETprdZl6XF34XdLMaWn0i1Oka38u37tgITbV/QacmvuBBQbhFyB17Fw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=wLOchcA9; dkim-atps=neutral; spf=pass (client-ip=113.46.200.219; helo=canpmsgout04.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=wLOchcA9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.219; helo=canpmsgout04.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4drfZg1c0gz2xFn
	for <linux-erofs@lists.ozlabs.org>; Wed, 14 Jan 2026 19:35:37 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=bXODzpSu1BKPKU0XvLc0HoZ59Vts4yuAy3ZYsnQRtg4=;
	b=wLOchcA9MLl8A5vwI09Ay9iNH3Gv02W4mt3C3oscgTBTwoBXp1ABjwG3hpfdu9t2kIJ/unRuo
	/eAJ5QkIAOyrkYqssGKB3soNy+w4XeHg661CORDPifsJMeICffWzCpa+jmOcdn9BCuskABvdSgr
	XhCht4LKbx4WwThNFkYMn9M=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4drfVg0BlNz1prLT;
	Wed, 14 Jan 2026 16:32:11 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id 8AB674056A;
	Wed, 14 Jan 2026 16:35:32 +0800 (CST)
Received: from huawei.com (10.50.159.234) by kwepemr100010.china.huawei.com
 (7.202.195.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 14 Jan
 2026 16:35:32 +0800
From: Yifan Zhao <zhaoyifan28@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <linux-erofs@lists.ozlabs.org>
CC: <jingrui@huawei.com>, <wayne.ma@huawei.com>, <zhaoyifan28@huawei.com>
Subject: [PATCH v3] erofs-utils: lib: correctly set {u,g}id in erofs_make_empty_root_inode()
Date: Wed, 14 Jan 2026 16:35:37 +0800
Message-ID: <20260114083537.3645314-1-zhaoyifan28@huawei.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <8cda58e0-e917-4e9c-ae68-d34336deb446@linux.alibaba.com>
References: <8cda58e0-e917-4e9c-ae68-d34336deb446@linux.alibaba.com>
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
X-Originating-IP: [10.50.159.234]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemr100010.china.huawei.com (7.202.195.125)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

In rebuild mode, the {u,g}id of the root inode is currently defaulted
to 0 and is not controlled by --force_{u,g}id. This behavior also causes
the {u,g}id of intermediate dir inodes created by
`erofs_rebuild_mkdir()` to be set to 0.

This patch fixes the behavior by explicitly setting permissions for the
root inode:

- If --force-{u,g}id is not specified, it now defaults to the current
   user's {u,g}id.
- If --force-{u,g}id is specified, it correctly updates the ownership
   for all files and directories.

Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
---
 include/erofs/inode.h | 3 ++-
 lib/inode.c           | 8 +++++++-
 mkfs/main.c           | 2 +-
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/erofs/inode.h b/include/erofs/inode.h
index 8b91771..89bd16a 100644
--- a/include/erofs/inode.h
+++ b/include/erofs/inode.h
@@ -48,7 +48,8 @@ int erofs_importer_load_tree(struct erofs_importer *im, bool rebuild,
 struct erofs_inode *erofs_mkfs_build_special_from_fd(struct erofs_importer *im,
 						     int fd, const char *name);
 int erofs_fixup_root_inode(struct erofs_inode *root);
-struct erofs_inode *erofs_rebuild_make_root(struct erofs_sb_info *sbi);
+struct erofs_inode *erofs_make_empty_root_inode(struct erofs_importer *im,
+						struct erofs_sb_info *sbi);
 
 #ifdef __cplusplus
 }
diff --git a/lib/inode.c b/lib/inode.c
index 26fefa2..e44e03c 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -2375,8 +2375,10 @@ int erofs_fixup_root_inode(struct erofs_inode *root)
 	return err;
 }
 
-struct erofs_inode *erofs_rebuild_make_root(struct erofs_sb_info *sbi)
+struct erofs_inode *erofs_make_empty_root_inode(struct erofs_importer *im,
+						struct erofs_sb_info *sbi)
 {
+	struct erofs_importer_params *params = im ? im->params : NULL;
 	struct erofs_inode *root;
 
 	root = erofs_new_inode(sbi);
@@ -2384,6 +2386,10 @@ struct erofs_inode *erofs_rebuild_make_root(struct erofs_sb_info *sbi)
 		return root;
 	root->i_srcpath = strdup("/");
 	root->i_mode = S_IFDIR | 0777;
+	root->i_uid = (!params || params->fixed_uid == -1) ? getuid() :
+							     params->fixed_uid;
+	root->i_gid = (!params || params->fixed_gid == -1) ? getgid() :
+							     params->fixed_gid;
 	root->i_parent = root;
 	root->i_mtime = root->sbi->epoch + root->sbi->build_time;
 	root->i_mtime_nsec = root->sbi->fixed_nsec;
diff --git a/mkfs/main.c b/mkfs/main.c
index f709190..620b1ed 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1910,7 +1910,7 @@ int main(int argc, char **argv)
 			goto exit;
 		}
 
-		root = erofs_rebuild_make_root(&g_sbi);
+		root = erofs_make_empty_root_inode(&importer, &g_sbi);
 		if (IS_ERR(root)) {
 			err = PTR_ERR(root);
 			goto exit;
-- 
2.47.3


