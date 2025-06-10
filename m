Return-Path: <linux-erofs+bounces-391-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26767AD3FAF
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Jun 2025 18:56:57 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bGw1f4Sk9z3bkg;
	Wed, 11 Jun 2025 02:56:54 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749574614;
	cv=none; b=gay71zIfylDmwr+jpCpgr4eYQq5YU4UrDeln2NautiJpns1E6GO7SQuaO8inXv6AivFaZpFmHT1htOqvyhMPgNmT9AiQzOvi/Fj/Xzlt+/0LosviMXkAXOOkCYCHY4IMyYJAzvN5Au6hGoU+a5n1tWy+PkcmH4ZdUt7InfpAD8eQ0C9VF/jWdtrCJ2Tqx/dFlWOp+tGrpv5wg5idglCbrW6VJKZg8rs1oP6ukJtuiN/5FTmFQvLaGCnFip0aDncn6DwrMZPojZg92fLbSrQ3bvYTL1ZYfFRzkQThJlcd6V0aN2yD9GDfpA8Sk1PxnaTioeRgwAgnsvj6YYx88ZC47g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749574614; c=relaxed/relaxed;
	bh=ES7Jfs15rRMWniHTiUUUk/JS4lPpKAmUYL4i0qHPbEU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FiletWdrvGF9qjz8nMNxzCZJcuLgQwYu6ke6YgXDt8+lkkEXQEvIlyawv3PTlcvRFmZWHpY7L0zNxCE4f5Y3giU+cft/oI6DFHg6v0Mvb/fyrPU5BVpvsd8orEp51FB3Jh7okAjVDhoCZCA1HFX+RbjmZjbE9KeqP2Ch6E7pxY0heeVzbi4S7Y9uFSRnxBmSuA8QoG7SGxA8HDd/i4IiI4mYjHzXN/x2IA2/RlupcpoijBDB5N+hiZGUFSC4Jlxe+13JY7zys3R1ckK9N3yo2LywT7RPoz6gx6HGLML/OW2MXaOFrl5t4kgqjgbpE/bdL4pUceOMhvUL9R9BFufuVw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Sv16T1Lt; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Sv16T1Lt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bGw1c5qMDz3bkT
	for <linux-erofs@lists.ozlabs.org>; Wed, 11 Jun 2025 02:56:50 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1749574607; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ES7Jfs15rRMWniHTiUUUk/JS4lPpKAmUYL4i0qHPbEU=;
	b=Sv16T1Ltq0LyxgBBdxjVnBUG5EDqxAj18OUJpMQz++1da39goyZ0gjL4C0dhRiCSE4o4+L0pnrIBSK0v3QHG+7lQYR+gIvcT3kRa4Y+Svrhh2Ks8CCy9ot2x48T4fciqu7JPuEXiE2b4V8eG/hvAjThJA7LvT1nI3T+WvNAsnBs=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wda.3Iw_1749574600 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 11 Jun 2025 00:56:45 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs-utils: mkfs: introduce `--fsalignblks` option
Date: Wed, 11 Jun 2025 00:56:33 +0800
Message-ID: <20250610165633.3688963-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Sometimes, we'd like the filesystem image aligned with a specific value.

For example, specifying 8 with 512-byte filesystem blocks aligns the
filesystem size to 4096 bytes instead of 512 bytes.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/blobchunk.h |  1 -
 include/erofs/internal.h  |  6 ++--
 lib/blobchunk.c           | 56 ++-----------------------------
 lib/super.c               | 69 ++++++++++++++++++++++++++++++++++++---
 man/mkfs.erofs.1          |  4 +++
 mkfs/main.c               | 30 +++++++++++++----
 6 files changed, 99 insertions(+), 67 deletions(-)

diff --git a/include/erofs/blobchunk.h b/include/erofs/blobchunk.h
index ebe2efe..619155f 100644
--- a/include/erofs/blobchunk.h
+++ b/include/erofs/blobchunk.h
@@ -24,7 +24,6 @@ int tarerofs_write_chunkes(struct erofs_inode *inode, erofs_off_t data_offset);
 int erofs_mkfs_dump_blobs(struct erofs_sb_info *sbi);
 void erofs_blob_exit(void);
 int erofs_blob_init(const char *blobfile_path, erofs_off_t chunksize);
-int erofs_mkfs_init_devices(struct erofs_sb_info *sbi, unsigned int devices);
 
 #ifdef __cplusplus
 }
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index e89a1e4..5e86943 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -144,6 +144,7 @@ struct erofs_sb_info {
 	struct erofs_bufmgr *bmgr;
 	struct z_erofs_mgr *zmgr;
 	struct erofs_packed_inode *packedinode;
+	struct erofs_buffer_head *bh_devt;
 	bool useqpl;
 };
 
@@ -412,9 +413,10 @@ struct erofs_map_dev {
 /* super.c */
 int erofs_read_superblock(struct erofs_sb_info *sbi);
 void erofs_put_super(struct erofs_sb_info *sbi);
-int erofs_writesb(struct erofs_sb_info *sbi, struct erofs_buffer_head *sb_bh,
-		  erofs_blk_t *blocks);
+int erofs_writesb(struct erofs_sb_info *sbi, struct erofs_buffer_head *sb_bh);
 struct erofs_buffer_head *erofs_reserve_sb(struct erofs_bufmgr *bmgr);
+int erofs_mkfs_init_devices(struct erofs_sb_info *sbi, unsigned int devices);
+int erofs_write_device_table(struct erofs_sb_info *sbi);
 int erofs_enable_sb_chksum(struct erofs_sb_info *sbi, u32 *crc);
 
 /* namei.c */
diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index 4fc6c77..8c55277 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -31,8 +31,6 @@ static struct hashmap blob_hashmap;
 static int blobfile = -1;
 static erofs_blk_t remapped_base;
 static erofs_off_t datablob_size;
-static bool multidev;
-static struct erofs_buffer_head *bh_devt;
 struct erofs_blobchunk erofs_holechunk = {
 	.blkaddr = EROFS_NULL_ADDR,
 };
@@ -493,30 +491,8 @@ int erofs_mkfs_dump_blobs(struct erofs_sb_info *sbi)
 			datablob_size = length;
 	}
 
-	if (sbi->extra_devices) {
-		unsigned int i, ret;
-		erofs_blk_t nblocks;
-
-		nblocks = erofs_mapbh(sbi->bmgr, NULL);
-		pos_out = erofs_btell(bh_devt, false);
-		i = 0;
-		do {
-			struct erofs_deviceslot dis = {
-				.mapped_blkaddr = cpu_to_le32(nblocks),
-				.blocks = cpu_to_le32(sbi->devs[i].blocks),
-			};
-
-			memcpy(dis.tag, sbi->devs[i].tag, sizeof(dis.tag));
-			ret = erofs_dev_write(sbi, &dis, pos_out, sizeof(dis));
-			if (ret)
-				return ret;
-			pos_out += sizeof(dis);
-			nblocks += sbi->devs[i].blocks;
-		} while (++i < sbi->extra_devices);
-		bh_devt->op = &erofs_drop_directly_bhops;
-		erofs_bdrop(bh_devt, false);
+	if (sbi->extra_devices)
 		return 0;
-	}
 
 	bh = erofs_balloc(sbi->bmgr, DATA, datablob_size, 0);
 	if (IS_ERR(bh))
@@ -612,40 +588,14 @@ static int erofs_insert_zerochunk(erofs_off_t chunksize)
 
 int erofs_blob_init(const char *blobfile_path, erofs_off_t chunksize)
 {
-	if (!blobfile_path) {
+	if (!blobfile_path)
 		blobfile = erofs_tmpfile();
-		multidev = false;
-	} else {
+	else
 		blobfile = open(blobfile_path, O_WRONLY | O_CREAT |
 						O_TRUNC | O_BINARY, 0666);
-		multidev = true;
-	}
 	if (blobfile < 0)
 		return -errno;
 
 	hashmap_init(&blob_hashmap, erofs_blob_hashmap_cmp, 0);
 	return erofs_insert_zerochunk(chunksize);
 }
-
-int erofs_mkfs_init_devices(struct erofs_sb_info *sbi, unsigned int devices)
-{
-	if (!devices)
-		return 0;
-
-	sbi->devs = calloc(devices, sizeof(sbi->devs[0]));
-	if (!sbi->devs)
-		return -ENOMEM;
-
-	bh_devt = erofs_balloc(sbi->bmgr, DEVT,
-		sizeof(struct erofs_deviceslot) * devices, 0);
-	if (IS_ERR(bh_devt)) {
-		free(sbi->devs);
-		return PTR_ERR(bh_devt);
-	}
-	erofs_mapbh(NULL, bh_devt->block);
-	bh_devt->op = &erofs_skip_write_bhops;
-	sbi->devt_slotoff = erofs_btell(bh_devt, false) / EROFS_DEVT_SLOT_SIZE;
-	sbi->extra_devices = devices;
-	erofs_sb_set_device_table(sbi);
-	return 0;
-}
diff --git a/lib/super.c b/lib/super.c
index 6c8fa52..1541838 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -155,8 +155,7 @@ void erofs_put_super(struct erofs_sb_info *sbi)
 	}
 }
 
-int erofs_writesb(struct erofs_sb_info *sbi, struct erofs_buffer_head *sb_bh,
-		  erofs_blk_t *blocks)
+int erofs_writesb(struct erofs_sb_info *sbi, struct erofs_buffer_head *sb_bh)
 {
 	struct erofs_super_block sb = {
 		.magic     = cpu_to_le32(EROFS_SUPER_MAGIC_V1),
@@ -180,8 +179,7 @@ int erofs_writesb(struct erofs_sb_info *sbi, struct erofs_buffer_head *sb_bh,
 	char *buf;
 	int ret;
 
-	*blocks         = erofs_mapbh(sbi->bmgr, NULL);
-	sb.blocks       = cpu_to_le32(*blocks);
+	sb.blocks       = cpu_to_le32(sbi->primarydevice_blocks);
 	memcpy(sb.uuid, sbi->uuid, sizeof(sb.uuid));
 	memcpy(sb.volume_name, sbi->volume_name, sizeof(sb.volume_name));
 
@@ -283,3 +281,66 @@ int erofs_enable_sb_chksum(struct erofs_sb_info *sbi, u32 *crc)
 
 	return 0;
 }
+
+int erofs_mkfs_init_devices(struct erofs_sb_info *sbi, unsigned int devices)
+{
+	struct erofs_buffer_head *bh;
+
+	if (!devices)
+		return 0;
+
+	sbi->devs = calloc(devices, sizeof(sbi->devs[0]));
+	if (!sbi->devs)
+		return -ENOMEM;
+
+	bh = erofs_balloc(sbi->bmgr, DEVT,
+			  sizeof(struct erofs_deviceslot) * devices, 0);
+	if (IS_ERR(bh)) {
+		free(sbi->devs);
+		sbi->devs = NULL;
+		return PTR_ERR(bh);
+	}
+	erofs_mapbh(NULL, bh->block);
+	bh->op = &erofs_skip_write_bhops;
+	sbi->bh_devt = bh;
+	sbi->devt_slotoff = erofs_btell(bh, false) / EROFS_DEVT_SLOT_SIZE;
+	sbi->extra_devices = devices;
+	erofs_sb_set_device_table(sbi);
+	return 0;
+}
+
+int erofs_write_device_table(struct erofs_sb_info *sbi)
+{
+	erofs_blk_t nblocks = sbi->primarydevice_blocks;
+	struct erofs_buffer_head *bh = sbi->bh_devt;
+	erofs_off_t pos;
+	unsigned int i, ret;
+
+	if (!sbi->extra_devices)
+		goto out;
+	if (!bh)
+		return -EINVAL;
+
+	pos = erofs_btell(bh, false);
+	i = 0;
+	do {
+		struct erofs_deviceslot dis = {
+			.mapped_blkaddr = cpu_to_le32(nblocks),
+			.blocks = cpu_to_le32(sbi->devs[i].blocks),
+		};
+
+		memcpy(dis.tag, sbi->devs[i].tag, sizeof(dis.tag));
+		ret = erofs_dev_write(sbi, &dis, pos, sizeof(dis));
+		if (ret)
+			return ret;
+		pos += sizeof(dis);
+		nblocks += sbi->devs[i].blocks;
+	} while (++i < sbi->extra_devices);
+
+	bh->op = &erofs_drop_directly_bhops;
+	erofs_bdrop(bh, false);
+	sbi->bh_devt = NULL;
+out:
+	sbi->total_blocks = nblocks;
+	return 0;
+}
diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
index ae8411d..48202b6 100644
--- a/man/mkfs.erofs.1
+++ b/man/mkfs.erofs.1
@@ -192,6 +192,10 @@ Set all file UIDs to \fIUID\fR.
 .BI "\-\-force-gid=" GID
 Set all file GIDs to \fIGID\fR.
 .TP
+.BI "\-\-fsalignblks=" #
+Specify the alignment of the primary device size (usually the filesystem size)
+in blocks.
+.TP
 .BI "\-\-gid-offset=" GIDOFFSET
 Add \fIGIDOFFSET\fR to all file GIDs.
 When this option is used together with
diff --git a/mkfs/main.c b/mkfs/main.c
index 79de7a1..16de894 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -89,6 +89,7 @@ static struct option long_options[] = {
 #ifdef EROFS_MT_ENABLED
 	{"async-queue-limit", required_argument, NULL, 530},
 #endif
+	{"fsalignblks", required_argument, NULL, 531},
 	{0, 0, 0, 0},
 };
 
@@ -180,6 +181,7 @@ static void usage(int argc, char **argv)
 #endif
 		" --force-uid=#         set all file uids to # (# = UID)\n"
 		" --force-gid=#         set all file gids to # (# = GID)\n"
+		" --fsalignblks=#       specify the alignment of the primary device size in blocks\n"
 		" --uid-offset=#        add offset # to all file uids (# = id offset)\n"
 		" --gid-offset=#        add offset # to all file gids (# = id offset)\n"
 		" --hard-dereference    dereference hardlinks, add links as separate inodes\n"
@@ -250,6 +252,7 @@ static LIST_HEAD(rebuild_src_list);
 static u8 fixeduuid[16];
 static bool valid_fixeduuid;
 static unsigned int dsunit;
+static unsigned int fsalignblks = 1;
 
 static int erofs_mkfs_feat_set_legacy_compress(bool en, const char *val,
 					       unsigned int vallen)
@@ -896,6 +899,13 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 			}
 			break;
 #endif
+		case 531:
+			fsalignblks = strtoul(optarg, &endptr, 0);
+			if (*endptr != '\0') {
+				erofs_err("invalid fsalignblks %s", optarg);
+				return -EINVAL;
+			}
+			break;
 		case 'V':
 			version();
 			exit(0);
@@ -1183,7 +1193,7 @@ static int erofs_mkfs_rebuild_load_trees(struct erofs_inode *root)
 	return 0;
 }
 
-static void erofs_mkfs_showsummaries(erofs_blk_t nblocks)
+static void erofs_mkfs_showsummaries(void)
 {
 	char uuid_str[37] = {};
 	char *incr = incremental_mode ? "new" : "total";
@@ -1194,11 +1204,12 @@ static void erofs_mkfs_showsummaries(erofs_blk_t nblocks)
 	erofs_uuid_unparse_lower(g_sbi.uuid, uuid_str);
 
 	fprintf(stdout, "------\nFilesystem UUID: %s\n"
-		"Filesystem total blocks: %u (of %u-byte blocks)\n"
+		"Filesystem total blocks: %llu (of %u-byte blocks)\n"
 		"Filesystem total inodes: %llu\n"
 		"Filesystem %s metadata blocks: %u\n"
 		"Filesystem %s deduplicated bytes (of source files): %llu\n",
-		uuid_str, nblocks, 1U << g_sbi.blkszbits, g_sbi.inos | 0ULL,
+		uuid_str, g_sbi.total_blocks | 0ULL, 1U << g_sbi.blkszbits,
+		g_sbi.inos | 0ULL,
 		incr, erofs_total_metablocks(g_sbi.bmgr),
 		incr, g_sbi.saved_by_deduplication | 0ULL);
 }
@@ -1208,7 +1219,6 @@ int main(int argc, char **argv)
 	int err = 0;
 	struct erofs_buffer_head *sb_bh;
 	struct erofs_inode *root = NULL;
-	erofs_blk_t nblocks = 0;
 	struct timeval t;
 	FILE *blklst = NULL;
 	u32 crc;
@@ -1478,6 +1488,12 @@ int main(int argc, char **argv)
 			goto exit;
 	}
 
+	g_sbi.primarydevice_blocks =
+		roundup(erofs_mapbh(g_sbi.bmgr, NULL), fsalignblks);
+	err = erofs_write_device_table(&g_sbi);
+	if (err)
+		goto exit;
+
 	/* flush all buffers except for the superblock */
 	err = erofs_bflush(g_sbi.bmgr, NULL);
 	if (err)
@@ -1487,7 +1503,7 @@ int main(int argc, char **argv)
 	erofs_iput(root);
 	root = NULL;
 
-	err = erofs_writesb(&g_sbi, sb_bh, &nblocks);
+	err = erofs_writesb(&g_sbi, sb_bh);
 	if (err)
 		goto exit;
 
@@ -1496,7 +1512,7 @@ int main(int argc, char **argv)
 	if (err)
 		goto exit;
 
-	err = erofs_dev_resize(&g_sbi, nblocks);
+	err = erofs_dev_resize(&g_sbi, g_sbi.primarydevice_blocks);
 
 	if (!err && erofs_sb_has_sb_chksum(&g_sbi)) {
 		err = erofs_enable_sb_chksum(&g_sbi, &crc);
@@ -1534,7 +1550,7 @@ exit:
 		return 1;
 	}
 	erofs_update_progressinfo("Build completed.\n");
-	erofs_mkfs_showsummaries(nblocks);
+	erofs_mkfs_showsummaries();
 	erofs_put_super(&g_sbi);
 	return 0;
 }
-- 
2.43.5


