Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F35C93EF05
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Jul 2024 09:50:54 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=xcABuKB5;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WXVsS36l2z3cDT
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Jul 2024 17:50:52 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=xcABuKB5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WXVsD3KbQz3cDT
	for <linux-erofs@lists.ozlabs.org>; Mon, 29 Jul 2024 17:50:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722239433; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=TFI3roDb6br+tkpDLljbJQYinBXG5vlyDrxCsiKeYmU=;
	b=xcABuKB5omL0js8tRrx4N6dGSER/wLp0yIspI5ifQZ/fcBqXOKPQbJyvcf2vBBahVi3gn4gy8uwFCzPnv/2lyL8j+1aJtm71b1XTthbNF6b46PjffmLvatuWSMsh/1DCNEcY0cDm98BZ00xOMJm2VJCadG0ou5O1U71QTDSKRqk=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0WBW8u.E_1722239432;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WBW8u.E_1722239432)
          by smtp.aliyun-inc.com;
          Mon, 29 Jul 2024 15:50:32 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/2] erofs-utils: mkfs: support inline xattr reservation for rootdirs
Date: Mon, 29 Jul 2024 15:50:27 +0800
Message-ID: <20240729075027.712339-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240729075027.712339-1-hsiangkao@linux.alibaba.com>
References: <20240729075027.712339-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Due to the current on-disk limitation (16-bit on-disk root_nid), on-disk
root inodes must be updated in place for now.

If rootdir xattr sizes are expanded during incremental updates, there
may be insufficient space to keep additional extended attributes.

To work around this, let's add a mkfs option `--root-xattr-isize=#` to
specify the minimum inline xattr size of root directories in advance.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/config.h |  1 +
 include/erofs/xattr.h  |  2 +-
 lib/inode.c            |  6 ++++--
 lib/rebuild.c          |  5 +++++
 lib/xattr.c            | 30 ++++++++++++++++++++++++------
 mkfs/main.c            |  9 +++++++++
 6 files changed, 44 insertions(+), 9 deletions(-)

diff --git a/include/erofs/config.h b/include/erofs/config.h
index f8726b5..56650e3 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -87,6 +87,7 @@ struct erofs_configure {
 	u32 c_uid, c_gid;
 	const char *mount_point;
 	long long c_uid_offset, c_gid_offset;
+	u32 c_root_xattr_isize;
 #ifdef WITH_ANDROID
 	char *target_out_path;
 	char *fs_config_file;
diff --git a/include/erofs/xattr.h b/include/erofs/xattr.h
index 0f76037..7643611 100644
--- a/include/erofs/xattr.h
+++ b/include/erofs/xattr.h
@@ -44,7 +44,7 @@ static inline unsigned int xattrblock_offset(struct erofs_inode *vi,
 	sizeof(struct erofs_xattr_entry) + 1; })
 
 int erofs_scan_file_xattrs(struct erofs_inode *inode);
-int erofs_prepare_xattr_ibody(struct erofs_inode *inode);
+int erofs_prepare_xattr_ibody(struct erofs_inode *inode, bool noroom);
 char *erofs_export_xattr_ibody(struct erofs_inode *inode);
 int erofs_build_shared_xattrs_from_path(struct erofs_sb_info *sbi, const char *path);
 
diff --git a/lib/inode.c b/lib/inode.c
index 6aee76c..b3547bf 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -1580,7 +1580,7 @@ static int erofs_mkfs_handle_inode(struct erofs_inode *inode)
 	if (ret < 0)
 		return ret;
 
-	ret = erofs_prepare_xattr_ibody(inode);
+	ret = erofs_prepare_xattr_ibody(inode, false);
 	if (ret < 0)
 		return ret;
 
@@ -1644,7 +1644,7 @@ static int erofs_rebuild_handle_inode(struct erofs_inode *inode,
 	else if (inode->whiteouts)
 		erofs_set_origin_xattr(inode);
 
-	ret = erofs_prepare_xattr_ibody(inode);
+	ret = erofs_prepare_xattr_ibody(inode, incremental && IS_ROOT(inode));
 	if (ret < 0)
 		return ret;
 
@@ -1702,6 +1702,8 @@ static int erofs_mkfs_dump_tree(struct erofs_inode *root, bool rebuild,
 		root->i_ino[1] = sbi->root_nid;
 		list_del(&root->i_hash);
 		erofs_insert_ihash(root);
+	} else if (cfg.c_root_xattr_isize) {
+		root->xattr_isize = cfg.c_root_xattr_isize;
 	}
 
 	err = !rebuild ? erofs_mkfs_handle_inode(root) :
diff --git a/lib/rebuild.c b/lib/rebuild.c
index 9e8bf8f..08c1b86 100644
--- a/lib/rebuild.c
+++ b/lib/rebuild.c
@@ -492,6 +492,11 @@ int erofs_rebuild_load_basedir(struct erofs_inode *dir)
 		erofs_err("failed to read inode @ %llu", fakeinode.nid);
 		return ret;
 	}
+
+	/* Inherit the maximum xattr size for the root directory */
+	if (__erofs_unlikely(IS_ROOT(dir)))
+		dir->xattr_isize = fakeinode.xattr_isize;
+
 	ctx = (struct erofs_rebuild_dir_context) {
 		.ctx.dir = &fakeinode,
 		.ctx.cb = erofs_rebuild_basedir_dirent_iter,
diff --git a/lib/xattr.c b/lib/xattr.c
index 563c688..f860f2e 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -659,16 +659,17 @@ static inline unsigned int erofs_next_xattr_align(unsigned int pos,
 			item->len[0] + item->len[1] - item->prefix_len);
 }
 
-int erofs_prepare_xattr_ibody(struct erofs_inode *inode)
+int erofs_prepare_xattr_ibody(struct erofs_inode *inode, bool noroom)
 {
-	int ret;
-	struct inode_xattr_node *node;
+	unsigned int target_xattr_isize = inode->xattr_isize;
 	struct list_head *ixattrs = &inode->i_xattrs;
+	struct inode_xattr_node *node;
 	unsigned int h_shared_count;
+	int ret;
 
 	if (list_empty(ixattrs)) {
-		inode->xattr_isize = 0;
-		return 0;
+		ret = 0;
+		goto out;
 	}
 
 	/* get xattr ibody size */
@@ -684,6 +685,18 @@ int erofs_prepare_xattr_ibody(struct erofs_inode *inode)
 		}
 		ret = erofs_next_xattr_align(ret, item);
 	}
+out:
+	while (ret < target_xattr_isize) {
+		ret += sizeof(struct erofs_xattr_entry);
+		if (ret < target_xattr_isize)
+			ret = EROFS_XATTR_ALIGN(ret +
+				min_t(int, target_xattr_isize - ret, UINT16_MAX));
+	}
+	if (noroom && target_xattr_isize && ret > target_xattr_isize) {
+		erofs_err("no enough space to keep xattrs @ nid %llu",
+			  inode->nid | 0ULL);
+		return -ENOSPC;
+	}
 	inode->xattr_isize = ret;
 	return ret;
 }
@@ -1003,7 +1016,12 @@ char *erofs_export_xattr_ibody(struct erofs_inode *inode)
 		free(node);
 		put_xattritem(item);
 	}
-	DBG_BUGON(p > size);
+	if (p < size) {
+		memset(buf + p, 0, size - p);
+	} else if (__erofs_unlikely(p > size)) {
+		DBG_BUGON(1);
+		return ERR_PTR(-EFAULT);
+	}
 	return buf;
 }
 
diff --git a/mkfs/main.c b/mkfs/main.c
index 20f12fc..f9ac4bd 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -81,6 +81,7 @@ static struct option long_options[] = {
 	{"zfeature-bits", required_argument, NULL, 521},
 	{"clean", optional_argument, NULL, 522},
 	{"incremental", optional_argument, NULL, 523},
+	{"root-xattr-isize", required_argument, NULL, 524},
 	{0, 0, 0, 0},
 };
 
@@ -173,6 +174,7 @@ static void usage(int argc, char **argv)
 		" --mount-point=X       X=prefix of target fs path (default: /)\n"
 		" --preserve-mtime      keep per-file modification time strictly\n"
 		" --offset=#            skip # bytes at the beginning of IMAGE.\n"
+		" --root-xattr-isize=#  ensure the inline xattr size of the root directory is # bytes at least\n"
 		" --aufs                replace aufs special files with overlayfs metadata\n"
 		" --tar=X               generate a full or index-only image from a tarball(-ish) source\n"
 		"                       (X = f|i|headerball; f=full mode, i=index mode,\n"
@@ -820,6 +822,13 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 			}
 			incremental_mode = (opt == 523);
 			break;
+		case 524:
+			cfg.c_root_xattr_isize = strtoull(optarg, &endptr, 0);
+			if (*endptr != '\0') {
+				erofs_err("invalid the minimum inline xattr size %s", optarg);
+				return -EINVAL;
+			}
+			break;
 		case 'V':
 			version();
 			exit(0);
-- 
2.43.5

