Return-Path: <linux-erofs+bounces-390-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA0FAD3D3A
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Jun 2025 17:33:05 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bGt8t70d9z3bp7;
	Wed, 11 Jun 2025 01:33:02 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749569582;
	cv=none; b=OJQaGl+DrpokpQWW3Xwk7eSaimjpp2P2aRbTqhVDgIjlnYP+bsjR42RY1qCrBP2MI++N1WuEy5WkfsPKTtXwi0/SLZc2un1i3dnBEytyKQpehJHo8R+lBwKvhPqHqAgZ4MK9hTrFRIr8jpPxbKY/0ZATxi6/j0k3+m18V0b2kF6Ub6s59RPC15u4gWfEFZjVFtSz3UJW/4hK5sKzaEtplLJ+Zp67AvvJ+bRVzE5R1PAsB1FbHaDE3si1UqoQ7q8Fk3x6/9PNohfNiJfsUJEnSnWMZJfep1q4iIXBpL9KgsC+UuphHYAsoaT+iNpNCnWkDRsv8TiGINJdblh34Aa0WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749569582; c=relaxed/relaxed;
	bh=YHw1qK7HpgR1whGD0L85NKvp3Qwry2nsAyY0Jr0ZViE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XvUg3UrOZBCTbu6xn69APjWE2ev4fGi4jFcuhwB2J3pONEf4+nSTE3Dx823M0NiPhbNWDq+YLWNjHpvyLOh0eY+eQkwcM8mjdLbvnsTuCx/VKW18g3uyuqlgLujS20o+6XuwsA1tVOYPeubnbLReM/Jkc7E0WBTA1rHjumyf2X0RRgd1KfzHyzKjmjzckbObUz5OR9lVRQsuia+09CB59/5hMQlJpgVUDmumLpx/x5CmimtdDN14I5hRzFIZPU5SCWYFlMhpn/MtzE/uPl23vZB+LLLCaZC7L2corV5oDe4duA9srTTAB1MWOEC4gfsapYiUGHDstVSBiqIMW0Oecw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=SRr/WxOh; dkim-atps=neutral; spf=pass (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=SRr/WxOh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bGt8r5jprz3blg
	for <linux-erofs@lists.ozlabs.org>; Wed, 11 Jun 2025 01:32:59 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1749569574; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=YHw1qK7HpgR1whGD0L85NKvp3Qwry2nsAyY0Jr0ZViE=;
	b=SRr/WxOhj71/IYEN9pvifHkHc5JujN3Eo39F2QDM3ZGuSYDBLk7HDNXPCln09xjd1g/DVmNumHeDqvMTsl13XUoZRgRAu5JcZYXOTlU5YxwXRvRs5eYrCqjNUWJ572X3s+HQdnaFGIJsT6UttnMxj9di/tVaL9PMRM9scMgn5qk=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WdZswB0_1749569568 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 10 Jun 2025 23:32:52 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs-utils: mkfs: increase the maximum size of the asynchronous queue
Date: Tue, 10 Jun 2025 23:32:47 +0800
Message-ID: <20250610153247.3564980-1-hsiangkao@linux.alibaba.com>
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

The previous limit of 256 was too small, especially when inflight files
are large, causing the job queue to be full while some compression
workers remain idle.

Increase the default to 32768 and add the `--async-queue-limit` option
to manually adjust this value.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/config.h |  9 +++++----
 lib/inode.c            | 46 +++++++++++++++++++++++-------------------
 mkfs/main.c            | 15 ++++++++++++++
 3 files changed, 45 insertions(+), 25 deletions(-)

diff --git a/include/erofs/config.h b/include/erofs/config.h
index eb5cad8..e4d2bb3 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -81,10 +81,6 @@ struct erofs_configure {
 	char c_force_chunkformat;
 	/* < 0, xattr disabled and INT_MAX, always use inline xattrs */
 	int c_inline_xattr_tolerance;
-#ifdef EROFS_MT_ENABLED
-	u64 c_mkfs_segment_size;
-	u32 c_mt_workers;
-#endif
 	u32 c_mkfs_pclustersize_max;
 	u32 c_mkfs_pclustersize_def;
 	u32 c_mkfs_pclustersize_packed;
@@ -94,6 +90,11 @@ struct erofs_configure {
 	const char *mount_point;
 	long long c_uid_offset, c_gid_offset;
 	u32 c_root_xattr_isize;
+#ifdef EROFS_MT_ENABLED
+	u64 c_mkfs_segment_size;
+	u32 c_mt_workers;
+	u32 c_mt_async_queue_limit;
+#endif
 #ifdef WITH_ANDROID
 	char *target_out_path;
 	char *fs_config_file;
diff --git a/lib/inode.c b/lib/inode.c
index 6598650..b53f0b6 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -1301,6 +1301,7 @@ out:
 		inode->i_diskbuf = NULL;
 		inode->datasource = EROFS_INODE_DATA_SOURCE_NONE;
 	} else {
+		DBG_BUGON(ctx->fd < 0);
 		close(ctx->fd);
 	}
 	return ret;
@@ -1360,6 +1361,9 @@ static int erofs_mkfs_jobfn(struct erofs_mkfs_jobitem *item)
 	struct erofs_inode *inode = item->u.inode;
 	int ret;
 
+	if (item->type >= EROFS_MKFS_JOB_MAX)
+		return 1;
+
 	if (item->type == EROFS_MKFS_JOB_NDIR)
 		return erofs_mkfs_handle_nondirectory(&item->u.ndir);
 
@@ -1394,8 +1398,6 @@ struct erofs_mkfs_dfops {
 	bool idle;	/* initialize as false before the dfops worker runs */
 };
 
-#define EROFS_MT_QUEUE_SIZE 256
-
 static void erofs_mkfs_flushjobs(struct erofs_sb_info *sbi)
 {
 	struct erofs_mkfs_dfops *q = sbi->mkfs_dfops;
@@ -1406,7 +1408,7 @@ static void erofs_mkfs_flushjobs(struct erofs_sb_info *sbi)
 	pthread_mutex_unlock(&q->lock);
 }
 
-static void *erofs_mkfs_pop_jobitem(struct erofs_mkfs_dfops *q)
+static void *erofs_mkfs_top_jobitem(struct erofs_mkfs_dfops *q)
 {
 	struct erofs_mkfs_jobitem *item;
 
@@ -1417,31 +1419,34 @@ static void *erofs_mkfs_pop_jobitem(struct erofs_mkfs_dfops *q)
 		pthread_cond_signal(&q->drain);
 		pthread_cond_wait(&q->empty, &q->lock);
 	}
+	item = q->queue + (q->head & (q->entries - 1));
+	pthread_mutex_unlock(&q->lock);
+	return item;
+}
 
-	item = q->queue + q->head;
-	q->head = (q->head + 1) & (q->entries - 1);
-
+static void erofs_mkfs_pop_jobitem(struct erofs_mkfs_dfops *q)
+{
+	pthread_mutex_lock(&q->lock);
+	DBG_BUGON(q->head == q->tail);
+	++q->head;
 	pthread_cond_signal(&q->full);
 	pthread_mutex_unlock(&q->lock);
-	return item;
 }
 
 static void *z_erofs_mt_dfops_worker(void *arg)
 {
 	struct erofs_sb_info *sbi = arg;
-	int ret = 0;
+	struct erofs_mkfs_dfops *dfops = sbi->mkfs_dfops;
+	int ret;
 
-	while (1) {
+	do {
 		struct erofs_mkfs_jobitem *item;
 
-		item = erofs_mkfs_pop_jobitem(sbi->mkfs_dfops);
-		if (item->type >= EROFS_MKFS_JOB_MAX)
-			break;
+		item = erofs_mkfs_top_jobitem(dfops);
 		ret = erofs_mkfs_jobfn(item);
-		if (ret)
-			break;
-	}
-	pthread_exit((void *)(uintptr_t)ret);
+		erofs_mkfs_pop_jobitem(dfops);
+	} while (!ret);
+	pthread_exit((void *)(uintptr_t)(ret < 0 ? ret : 0));
 }
 
 static int erofs_mkfs_go(struct erofs_sb_info *sbi,
@@ -1452,14 +1457,13 @@ static int erofs_mkfs_go(struct erofs_sb_info *sbi,
 
 	pthread_mutex_lock(&q->lock);
 
-	while (((q->tail + 1) & (q->entries - 1)) == q->head)
+	while (q->tail - q->head >= q->entries)
 		pthread_cond_wait(&q->full, &q->lock);
 
-	item = q->queue + q->tail;
+	item = q->queue + (q->tail++ & (q->entries - 1));
 	item->type = type;
 	if (size)
 		memcpy(&item->u, elem, size);
-	q->tail = (q->tail + 1) & (q->entries - 1);
 	q->idle = false;
 
 	pthread_cond_signal(&q->empty);
@@ -1665,7 +1669,7 @@ static int erofs_mkfs_handle_inode(struct erofs_inode *inode)
 		return ret;
 
 	if (!S_ISDIR(inode->i_mode)) {
-		struct erofs_mkfs_job_ndir_ctx ctx = { .inode = inode };
+		struct erofs_mkfs_job_ndir_ctx ctx = { .inode = inode, .fd = -1 };
 
 		if (!S_ISLNK(inode->i_mode) && inode->i_size) {
 			ctx.fd = open(inode->i_srcpath, O_RDONLY | O_BINARY);
@@ -1897,7 +1901,7 @@ static int erofs_mkfs_build_tree(struct erofs_mkfs_buildtree_ctx *ctx)
 	if (!q)
 		return -ENOMEM;
 
-	q->entries = EROFS_MT_QUEUE_SIZE;
+	q->entries = cfg.c_mt_async_queue_limit ?: 32768;
 	q->queue = malloc(q->entries * sizeof(*q->queue));
 	if (!q->queue) {
 		free(q);
diff --git a/mkfs/main.c b/mkfs/main.c
index 8497637..d1b6073 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -86,6 +86,9 @@ static struct option long_options[] = {
 	{"sort", required_argument, NULL, 527},
 	{"hard-dereference", no_argument, NULL, 528},
 	{"dsunit", required_argument, NULL, 529},
+#ifdef EROFS_MT_ENABLED
+	{"async-queue-limit", required_argument, NULL, 530},
+#endif
 	{0, 0, 0, 0},
 };
 
@@ -159,6 +162,9 @@ static void usage(int argc, char **argv)
 		"    --mkfs-time        the timestamp is applied as build time only\n"
 		" -UX                   use a given filesystem UUID\n"
 		" --all-root            make all files owned by root\n"
+#ifdef EROFS_MT_ENABLED
+		" --async-queue-limit=# specify the maximum number of entries in the multi-threaded job queue\n"
+#endif
 		" --blobdev=X           specify an extra device X to store chunked data\n"
 		" --chunksize=#         generate chunk-based files with #-byte chunks\n"
 		" --clean=X             run full clean build (default) or:\n"
@@ -905,6 +911,15 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 				return -EINVAL;
 			}
 			break;
+#ifdef EROFS_MT_ENABLED
+		case 530:
+			cfg.c_mt_async_queue_limit = strtoul(optarg, &endptr, 0);
+			if (*endptr != '\0') {
+				erofs_err("invalid async-queue-limit %s", optarg);
+				return -EINVAL;
+			}
+			break;
+#endif
 		case 'V':
 			version();
 			exit(0);
-- 
2.43.5


