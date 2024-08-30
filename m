Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 178949655A9
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Aug 2024 05:29:03 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ww3XX3FDcz30PJ
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Aug 2024 13:29:00 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1724988536;
	cv=none; b=AtKGC9uQnHjJlg1yhjsGXzVRfXS58NMhjKAM3MjucMOb62qV2c9NU9GOyP63Xm81WuXVIbqgM/JvQp4XA3C3Avoi6vrEq033+I9u6lqd47BXdwk9rqGZ2OlqOsiFuD07ytGFChQjefNDBiWIxTTCUR5g1TVmj1IC0siOXS9gpofTGw0Qn7meYZ5RuWXavAxibYi2cJar9HCRz4gFiQ4+YEqPiJHrlUH6pbRQJOwa8xLUN6qdh5uip0CfCHsIRJ45JAnbvjBPn0dfHUK3rYWGM28DvPOfTtXe62y9DazJZlcb9kh51fWSih/njp58BXQ6RUih2IBxqDT2s9UDUEx7xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1724988536; c=relaxed/relaxed;
	bh=9FSQd22Dgg+N85ew5ywxiepg9q5qfjCj8vhc7ldBaqA=;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding; b=jM0TcUqRb17icohaCXnRQSvexi3xD2xH+h6CDHzmq4PJ/qktgkV0F2fEuTRF3BHZNIvfpd0EX4BAG+oyEl2saKqchcpBnHg5/tUZB8yt2y3q5be2DTtJHjatpezIe0JpnmSbovWvNyf5BIHKBLrTJjyTWU7B8oxL1CD1weXB+rbSRtTJ7jCDoT9G5IU/mnHOHd3oS+Tkdm1u8IZTY7mkuT7xGJLjuod9VRW/OYOHklCAytJI2NGCTWOA5vcDX6NkmoaI3dWOEjzD/DJxuPckK/QU1b2pa7rkEsMkjfBaGHf1SXTk7wrXWXs0tETLacZ20bIn2OjUMJkxjBgXKJB3KA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=J1FJWNXO; dkim-atps=neutral; spf=pass (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=J1FJWNXO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Ww3XR53Kvz2xdX
	for <linux-erofs@lists.ozlabs.org>; Fri, 30 Aug 2024 13:28:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724988529; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=9FSQd22Dgg+N85ew5ywxiepg9q5qfjCj8vhc7ldBaqA=;
	b=J1FJWNXO+7ioeezijsbHoR9tgddIphi7D5XvaWTgYA2ceEyGTGBi8phU+sm6DKMFBqmZHezJsYTIkGdr7ouW3/4q6MQxV7JdTfHQK3JP1PJCWyXKPVbv86564nGrzswHelDgOwdArG3a0l//h5dbaLQo5MTW3+q9g4iHJRhoeLE=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WDv3lpS_1724988521)
          by smtp.aliyun-inc.com;
          Fri, 30 Aug 2024 11:28:48 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 1/4] erofs: add file-backed mount support
Date: Fri, 30 Aug 2024 11:28:37 +0800
Message-ID: <20240830032840.3783206-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

It actually has been around for years: For containers and other sandbox
use cases, there will be thousands (and even more) of authenticated
(sub)images running on the same host, unlike OS images.

Of course, all scenarios can use the same EROFS on-disk format, but
bdev-backed mounts just work well for OS images since golden data is
dumped into real block devices.  However, it's somewhat hard for
container runtimes to manage and isolate so many unnecessary virtual
block devices safely and efficiently [1]: they just look like a burden
to orchestrators and file-backed mounts are preferred indeed.  There
were already enough attempts such as Incremental FS, the original
ComposeFS and PuzzleFS acting in the same way for immutable fses.  As
for current EROFS users, ComposeFS, containerd and Android APEXs will
be directly benefited from it.

On the other hand, previous experimental feature "erofs over fscache"
was once also intended to provide a similar solution (inspired by
Incremental FS discussion [2]), but the following facts show file-backed
mounts will be a better approach:
 - Fscache infrastructure has recently been moved into new Netfslib
   which is an unexpected dependency to EROFS really, although it
   originally claims "it could be used for caching other things such as
   ISO9660 filesystems too." [3]

 - It takes an unexpectedly long time to upstream Fscache/Cachefiles
   enhancements.  For example, the failover feature took more than
   one year, and the deamonless feature is still far behind now;

 - Ongoing HSM "fanotify pre-content hooks" [4] together with this will
   perfectly supersede "erofs over fscache" in a simpler way since
   developers (mainly containerd folks) could leverage their existing
   caching mechanism entirely in userspace instead of strictly following
   the predefined in-kernel caching tree hierarchy.

After "fanotify pre-content hooks" lands upstream to provide the same
functionality, "erofs over fscache" will be removed then (as an EROFS
internal improvement and EROFS will not have to bother with on-demand
fetching and/or caching improvements anymore.)

[1] https://github.com/containers/storage/pull/2039
[2] https://lore.kernel.org/r/CAOQ4uxjbVxnubaPjVaGYiSwoGDTdpWbB=w_AeM6YM=zVixsUfQ@mail.gmail.com
[3] https://docs.kernel.org/filesystems/caching/fscache.html
[4] https://lore.kernel.org/r/cover.1723670362.git.josef@toxicpanda.com

Closes: https://github.com/containers/composefs/issues/144
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
v2:
 - should use kill_anon_super();
 - add O_LARGEFILE to support large files.
 
 fs/erofs/Kconfig    | 17 ++++++++++
 fs/erofs/data.c     | 35 ++++++++++++---------
 fs/erofs/inode.c    |  5 ++-
 fs/erofs/internal.h | 11 +++++--
 fs/erofs/super.c    | 76 +++++++++++++++++++++++++++++----------------
 5 files changed, 100 insertions(+), 44 deletions(-)

diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index 7dcdce660cac..1428d0530e1c 100644
--- a/fs/erofs/Kconfig
+++ b/fs/erofs/Kconfig
@@ -74,6 +74,23 @@ config EROFS_FS_SECURITY
 
 	  If you are not using a security module, say N.
 
+config EROFS_FS_BACKED_BY_FILE
+	bool "File-backed EROFS filesystem support"
+	depends on EROFS_FS
+	default y
+	help
+	  This allows EROFS to use filesystem image files directly, without
+	  the intercession of loopback block devices or likewise. It is
+	  particularly useful for container images with numerous blobs and
+	  other sandboxes, where loop devices behave intricately.  It can also
+	  be used to simplify error-prone lifetime management of unnecessary
+	  virtual block devices.
+
+	  Note that this feature, along with ongoing fanotify pre-content
+	  hooks, will eventually replace "EROFS over fscache."
+
+	  If you don't want to enable this feature, say N.
+
 config EROFS_FS_ZIP
 	bool "EROFS Data Compression Support"
 	depends on EROFS_FS
diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 1b7eba38ba1e..0fb31c588ae0 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -59,8 +59,12 @@ void *erofs_bread(struct erofs_buf *buf, erofs_off_t offset,
 
 void erofs_init_metabuf(struct erofs_buf *buf, struct super_block *sb)
 {
-	if (erofs_is_fscache_mode(sb))
-		buf->mapping = EROFS_SB(sb)->s_fscache->inode->i_mapping;
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
+
+	if (erofs_is_fileio_mode(sbi))
+		buf->mapping = file_inode(sbi->fdev)->i_mapping;
+	else if (erofs_is_fscache_mode(sb))
+		buf->mapping = sbi->s_fscache->inode->i_mapping;
 	else
 		buf->mapping = sb->s_bdev->bd_mapping;
 }
@@ -189,10 +193,22 @@ int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map)
 	return err;
 }
 
+static void erofs_fill_from_devinfo(struct erofs_map_dev *map,
+				    struct erofs_device_info *dif)
+{
+	map->m_bdev = NULL;
+	if (dif->file && S_ISBLK(file_inode(dif->file)->i_mode))
+		map->m_bdev = file_bdev(dif->file);
+	map->m_daxdev = dif->dax_dev;
+	map->m_dax_part_off = dif->dax_part_off;
+	map->m_fscache = dif->fscache;
+}
+
 int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
 {
 	struct erofs_dev_context *devs = EROFS_SB(sb)->devs;
 	struct erofs_device_info *dif;
+	erofs_off_t startoff, length;
 	int id;
 
 	map->m_bdev = sb->s_bdev;
@@ -212,29 +228,20 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
 			up_read(&devs->rwsem);
 			return 0;
 		}
-		map->m_bdev = dif->bdev_file ? file_bdev(dif->bdev_file) : NULL;
-		map->m_daxdev = dif->dax_dev;
-		map->m_dax_part_off = dif->dax_part_off;
-		map->m_fscache = dif->fscache;
+		erofs_fill_from_devinfo(map, dif);
 		up_read(&devs->rwsem);
 	} else if (devs->extra_devices && !devs->flatdev) {
 		down_read(&devs->rwsem);
 		idr_for_each_entry(&devs->tree, dif, id) {
-			erofs_off_t startoff, length;
-
 			if (!dif->mapped_blkaddr)
 				continue;
+
 			startoff = erofs_pos(sb, dif->mapped_blkaddr);
 			length = erofs_pos(sb, dif->blocks);
-
 			if (map->m_pa >= startoff &&
 			    map->m_pa < startoff + length) {
 				map->m_pa -= startoff;
-				map->m_bdev = dif->bdev_file ?
-					      file_bdev(dif->bdev_file) : NULL;
-				map->m_daxdev = dif->dax_dev;
-				map->m_dax_part_off = dif->dax_part_off;
-				map->m_fscache = dif->fscache;
+				erofs_fill_from_devinfo(map, dif);
 				break;
 			}
 		}
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 419432be3223..d05b9e59f122 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -258,7 +258,10 @@ static int erofs_fill_inode(struct inode *inode)
 	}
 
 	mapping_set_large_folios(inode->i_mapping);
-	if (erofs_inode_is_data_compressed(vi->datalayout)) {
+	if (erofs_is_fileio_mode(EROFS_SB(inode->i_sb))) {
+		/* XXX: data I/Os will be implemented in the following patches */
+		err = -EOPNOTSUPP;
+	} else if (erofs_inode_is_data_compressed(vi->datalayout)) {
 #ifdef CONFIG_EROFS_FS_ZIP
 		DO_ONCE_LITE_IF(inode->i_blkbits != PAGE_SHIFT,
 			  erofs_info, inode->i_sb,
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 45dc15ebd870..9bf4fb1cfa09 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -49,7 +49,7 @@ typedef u32 erofs_blk_t;
 struct erofs_device_info {
 	char *path;
 	struct erofs_fscache *fscache;
-	struct file *bdev_file;
+	struct file *file;
 	struct dax_device *dax_dev;
 	u64 dax_part_off;
 
@@ -130,6 +130,7 @@ struct erofs_sb_info {
 
 	struct erofs_sb_lz4_info lz4;
 #endif	/* CONFIG_EROFS_FS_ZIP */
+	struct file *fdev;
 	struct inode *packed_inode;
 	struct erofs_dev_context *devs;
 	struct dax_device *dax_dev;
@@ -190,9 +191,15 @@ struct erofs_sb_info {
 #define set_opt(opt, option)	((opt)->mount_opt |= EROFS_MOUNT_##option)
 #define test_opt(opt, option)	((opt)->mount_opt & EROFS_MOUNT_##option)
 
+static inline bool erofs_is_fileio_mode(struct erofs_sb_info *sbi)
+{
+	return IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) && sbi->fdev;
+}
+
 static inline bool erofs_is_fscache_mode(struct super_block *sb)
 {
-	return IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && !sb->s_bdev;
+	return IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) &&
+			!erofs_is_fileio_mode(EROFS_SB(sb)) && !sb->s_bdev;
 }
 
 enum {
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index aae3fd15899a..9a7e67eceed4 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -10,6 +10,7 @@
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
 #include <linux/exportfs.h>
+#include <linux/backing-dev.h>
 #include "xattr.h"
 
 #define CREATE_TRACE_POINTS
@@ -161,7 +162,7 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 	struct erofs_fscache *fscache;
 	struct erofs_deviceslot *dis;
-	struct file *bdev_file;
+	struct file *file;
 
 	dis = erofs_read_metabuf(buf, sb, *pos, EROFS_KMAP);
 	if (IS_ERR(dis))
@@ -183,13 +184,17 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
 			return PTR_ERR(fscache);
 		dif->fscache = fscache;
 	} else if (!sbi->devs->flatdev) {
-		bdev_file = bdev_file_open_by_path(dif->path, BLK_OPEN_READ,
-						sb->s_type, NULL);
-		if (IS_ERR(bdev_file))
-			return PTR_ERR(bdev_file);
-		dif->bdev_file = bdev_file;
-		dif->dax_dev = fs_dax_get_by_bdev(file_bdev(bdev_file),
-				&dif->dax_part_off, NULL, NULL);
+		file = erofs_is_fileio_mode(sbi) ?
+				filp_open(dif->path, O_RDONLY | O_LARGEFILE, 0) :
+				bdev_file_open_by_path(dif->path,
+						BLK_OPEN_READ, sb->s_type, NULL);
+		if (IS_ERR(file))
+			return PTR_ERR(file);
+
+		dif->file = file;
+		if (!erofs_is_fileio_mode(sbi))
+			dif->dax_dev = fs_dax_get_by_bdev(file_bdev(file),
+					&dif->dax_part_off, NULL, NULL);
 	}
 
 	dif->blocks = le32_to_cpu(dis->blocks);
@@ -566,15 +571,16 @@ static void erofs_set_sysfs_name(struct super_block *sb)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 
-	if (erofs_is_fscache_mode(sb)) {
-		if (sbi->domain_id)
-			super_set_sysfs_name_generic(sb, "%s,%s",sbi->domain_id,
-						     sbi->fsid);
-		else
-			super_set_sysfs_name_generic(sb, "%s", sbi->fsid);
-		return;
-	}
-	super_set_sysfs_name_id(sb);
+	if (sbi->domain_id)
+		super_set_sysfs_name_generic(sb, "%s,%s", sbi->domain_id,
+					     sbi->fsid);
+	else if (sbi->fsid)
+		super_set_sysfs_name_generic(sb, "%s", sbi->fsid);
+	else if (erofs_is_fileio_mode(sbi))
+		super_set_sysfs_name_generic(sb, "%s",
+					     bdi_dev_name(sb->s_bdi));
+	else
+		super_set_sysfs_name_id(sb);
 }
 
 static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
@@ -589,14 +595,15 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_op = &erofs_sops;
 
 	sbi->blkszbits = PAGE_SHIFT;
-	if (erofs_is_fscache_mode(sb)) {
+	if (!sb->s_bdev) {
 		sb->s_blocksize = PAGE_SIZE;
 		sb->s_blocksize_bits = PAGE_SHIFT;
 
-		err = erofs_fscache_register_fs(sb);
-		if (err)
-			return err;
-
+		if (erofs_is_fscache_mode(sb)) {
+			err = erofs_fscache_register_fs(sb);
+			if (err)
+				return err;
+		}
 		err = super_setup_bdi(sb);
 		if (err)
 			return err;
@@ -693,11 +700,24 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 static int erofs_fc_get_tree(struct fs_context *fc)
 {
 	struct erofs_sb_info *sbi = fc->s_fs_info;
+	int ret;
 
 	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && sbi->fsid)
 		return get_tree_nodev(fc, erofs_fc_fill_super);
 
-	return get_tree_bdev(fc, erofs_fc_fill_super);
+	ret = get_tree_bdev(fc, erofs_fc_fill_super);
+#ifdef CONFIG_EROFS_FS_BACKED_BY_FILE
+	if (ret == -ENOTBLK) {
+		if (!fc->source)
+			return invalf(fc, "No source specified");
+		sbi->fdev = filp_open(fc->source, O_RDONLY | O_LARGEFILE, 0);
+		if (IS_ERR(sbi->fdev))
+			return PTR_ERR(sbi->fdev);
+
+		return get_tree_nodev(fc, erofs_fc_fill_super);
+	}
+#endif
+	return ret;
 }
 
 static int erofs_fc_reconfigure(struct fs_context *fc)
@@ -727,8 +747,8 @@ static int erofs_release_device_info(int id, void *ptr, void *data)
 	struct erofs_device_info *dif = ptr;
 
 	fs_put_dax(dif->dax_dev, NULL);
-	if (dif->bdev_file)
-		fput(dif->bdev_file);
+	if (dif->file)
+		fput(dif->file);
 	erofs_fscache_unregister_cookie(dif->fscache);
 	dif->fscache = NULL;
 	kfree(dif->path);
@@ -791,7 +811,7 @@ static void erofs_kill_sb(struct super_block *sb)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 
-	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && sbi->fsid)
+	if ((IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && sbi->fsid) || sbi->fdev)
 		kill_anon_super(sb);
 	else
 		kill_block_super(sb);
@@ -801,6 +821,8 @@ static void erofs_kill_sb(struct super_block *sb)
 	erofs_fscache_unregister_fs(sb);
 	kfree(sbi->fsid);
 	kfree(sbi->domain_id);
+	if (sbi->fdev)
+		fput(sbi->fdev);
 	kfree(sbi);
 	sb->s_fs_info = NULL;
 }
@@ -903,7 +925,7 @@ static int erofs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	buf->f_namelen = EROFS_NAME_LEN;
 
 	if (uuid_is_null(&sb->s_uuid))
-		buf->f_fsid = u64_to_fsid(erofs_is_fscache_mode(sb) ? 0 :
+		buf->f_fsid = u64_to_fsid(!sb->s_bdev ? 0 :
 				huge_encode_dev(sb->s_bdev->bd_dev));
 	else
 		buf->f_fsid = uuid_to_fsid(sb->s_uuid.b);
-- 
2.43.5

