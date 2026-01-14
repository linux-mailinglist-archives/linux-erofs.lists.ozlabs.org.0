Return-Path: <linux-erofs+bounces-1850-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 37507D1CE00
	for <lists+linux-erofs@lfdr.de>; Wed, 14 Jan 2026 08:38:20 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4drdJT3lrjz2xpm;
	Wed, 14 Jan 2026 18:38:17 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.218
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768376297;
	cv=none; b=hsh9wtlScNwNccmnfe2jQAyi+Jc//HtlxfExWMThGkk2PRgwkDLSipXEpwaNLBmrBKqmFIv/ouNIlR8Ia2IBOz2+QHzifpR1xXHsoCEhLSuEzhSS6iKkZU0rPRZDDDY/l+vt4JN+kk8jeE9Oo5U2lwZkvwpsGrFAov7pNZRLNuZO7rDaxZ302jXwO0+l3ZuQRufXNHSuT/FwsjH7B63NtyaxPiM/y1AHvI0hQvl5QgYxEVMmk3oSCp5r/k5DJpxCm4xTJDCUjkW9Sq/+a2Q2IB0KSeSAcnTc2+Fg2b0i30EFkOqF7wpNXjO7JSKmMyvnHrwwY9Nfapi2mXg1r9HtZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768376297; c=relaxed/relaxed;
	bh=baEY6ruWVURF/2VzH/8mbbLS1m9Nxmiurhx4Cw94L80=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BewMPqg63x6Gw+pYkHjHyy11a7DWIM4gYTpoc3ZSLfNZZPw2pws27eu8x/qKk8zTyrhjf6qdRyRZCsXEjqRVOttJWrB+LLveyQuFkN/zO6dejE+haoRagE7NZh/PmcA6RAJnOHWRfSpyM5zMxCW/Va1/zSOuM7yUXRywVfbMmTK8cJ8r3BT237S17wfLFXSjVfqZIubMftlFFn/r0ZkWzhMpkUzKyJoraEP8Dx0J672ZN8ryjLVsli1G6TEMV1bcxoxhDuoKgbLb71rbPLAZvRWiUJ2Z6Ei4ll7VSlbur+9irts3LoATuznsRXIuiSKWILq3fayccswy62u6D8ro6w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=GIRbu6jY; dkim-atps=neutral; spf=pass (client-ip=113.46.200.218; helo=canpmsgout03.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=GIRbu6jY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.218; helo=canpmsgout03.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4drdJQ2QqMz2x9M
	for <linux-erofs@lists.ozlabs.org>; Wed, 14 Jan 2026 18:38:12 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=baEY6ruWVURF/2VzH/8mbbLS1m9Nxmiurhx4Cw94L80=;
	b=GIRbu6jYidFQtUhgvdblj5z29tD7cI+s0qM+T2S8bHncVlr7/7hbC3YEnFBYkKDKaZklKl82m
	4tyYOixfmP23efEVolMTYkF+ofwf3SrRxpUnHdMkp4JXOsOBm4G7Xy2UDHwyMRE5cwNVIQSrC8N
	uTSCghlutgBLiGi7bt3CYiE=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4drdD43tvWzpSvl;
	Wed, 14 Jan 2026 15:34:28 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id E8EB940538;
	Wed, 14 Jan 2026 15:38:01 +0800 (CST)
Received: from huawei.com (10.50.159.234) by kwepemr100010.china.huawei.com
 (7.202.195.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 14 Jan
 2026 15:38:01 +0800
From: Yifan Zhao <zhaoyifan28@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <linux-erofs@lists.ozlabs.org>
CC: <jingrui@huawei.com>, <wayne.ma@huawei.com>, <zhaoyifan28@huawei.com>
Subject: [PATCH v2] erofs-utils: lib: correctly set {u,g}id in erofs_rebuild_make_root()
Date: Wed, 14 Jan 2026 15:38:06 +0800
Message-ID: <20260114073806.3640681-1-zhaoyifan28@huawei.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <7db44e77-9256-469d-9845-d40079ab2a5a@linux.alibaba.com>
References: <7db44e77-9256-469d-9845-d40079ab2a5a@linux.alibaba.com>
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
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemr100010.china.huawei.com (7.202.195.125)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

In rebuild mode, the {u,g}id of the root inode is currently defaulted
to 0 and is not controlled by --force_{u,g}id. This behavior also
causes the {u,g}id of intermediate directories created by
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
 lib/inode.c           | 5 ++++-
 mkfs/main.c           | 2 +-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/erofs/inode.h b/include/erofs/inode.h
index 8b91771..2a7af31 100644
--- a/include/erofs/inode.h
+++ b/include/erofs/inode.h
@@ -48,7 +48,8 @@ int erofs_importer_load_tree(struct erofs_importer *im, bool rebuild,
 struct erofs_inode *erofs_mkfs_build_special_from_fd(struct erofs_importer *im,
 						     int fd, const char *name);
 int erofs_fixup_root_inode(struct erofs_inode *root);
-struct erofs_inode *erofs_rebuild_make_root(struct erofs_sb_info *sbi);
+struct erofs_inode *erofs_rebuild_make_root(struct erofs_importer *im,
+					    struct erofs_sb_info *sbi);
 
 #ifdef __cplusplus
 }
diff --git a/lib/inode.c b/lib/inode.c
index 26fefa2..4f87757 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -2375,7 +2375,8 @@ int erofs_fixup_root_inode(struct erofs_inode *root)
 	return err;
 }
 
-struct erofs_inode *erofs_rebuild_make_root(struct erofs_sb_info *sbi)
+struct erofs_inode *erofs_rebuild_make_root(struct erofs_importer *im,
+					    struct erofs_sb_info *sbi)
 {
 	struct erofs_inode *root;
 
@@ -2384,6 +2385,8 @@ struct erofs_inode *erofs_rebuild_make_root(struct erofs_sb_info *sbi)
 		return root;
 	root->i_srcpath = strdup("/");
 	root->i_mode = S_IFDIR | 0777;
+	root->i_uid = im->params->fixed_uid == -1 ? getuid() : im->params->fixed_uid;
+	root->i_gid = im->params->fixed_gid == -1 ? getgid() : im->params->fixed_gid;
 	root->i_parent = root;
 	root->i_mtime = root->sbi->epoch + root->sbi->build_time;
 	root->i_mtime_nsec = root->sbi->fixed_nsec;
diff --git a/mkfs/main.c b/mkfs/main.c
index f709190..e9ae29a 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1910,7 +1910,7 @@ int main(int argc, char **argv)
 			goto exit;
 		}
 
-		root = erofs_rebuild_make_root(&g_sbi);
+		root = erofs_rebuild_make_root(&importer, &g_sbi);
 		if (IS_ERR(root)) {
 			err = PTR_ERR(root);
 			goto exit;
-- 
2.47.3


