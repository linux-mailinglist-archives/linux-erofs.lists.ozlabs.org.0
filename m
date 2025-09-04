Return-Path: <linux-erofs+bounces-971-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5D6B434E6
	for <lists+linux-erofs@lfdr.de>; Thu,  4 Sep 2025 10:01:59 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cHX4g56mzz2xnM;
	Thu,  4 Sep 2025 18:01:55 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756972915;
	cv=none; b=LCcxO26381ii6GPMI17Z4b4F+Q/js5uykCH/EUhbQtf2zoDrlqlQ2KuNw2PZRhJeO+OhhU+6qqsvQNE5QmB0iqL9/W4ixF9UHIz1kwz/WA1w3aQWD0sGjKFVslCjqzhZ3KT6I+YvB3hpzS/3xSFNrv2jfP85Z452J5ztkh3GDkvCyYrfEqaf9eVXItBo/5cKWLucpQOBihgI5qt9Pxx1VvJAAhbmGd5BqGCyeo6YtQ5ov+kuUtS9Alqax5I0b4tqyHK7H9IVJZJEev/Dzoet/3t6xGl4Y5yp+6OvGCzDplnYGfut81ZzFnP1wcsFBTyHlUFM1KDpX+DlZ7KWs9HEJA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756972915; c=relaxed/relaxed;
	bh=JR64S8O2lZM6CkUs7pyiGPnq1tliCRap0mtIkQwAhpA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QeiwqJOgqL595Dhh1tiOfrilI4jU5E65iNi4IS1FYHdFH/5h4PSmoZ1fg2wjyf3O/EWWpd5owziVplM4e4K6WqKBTuK6bx4TBTRftZOZg0mF2tMycFZX7pm3iu4r26PuBABT8nqRtsV76rtOIklnN55DDc/fwRGmDyTx8V+QG7OvLrJ62R6wTK2rlzDax+0B34IRbSeTJGvvsHr6ww1EfIJ8RH1HHnRWlJCh4b8nm910uBDycpW7Dq/aG4UaXemFvUpj9B5t8AyJWLZOHGSD8+piIZHwEUxYMcCrAlHlOjPAnDCZZDZYphbzLdyB6TB7P6oYjlMrcGE6L6HialidQg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Xog4BuiL; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Xog4BuiL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cHX4f6KpBz2xd6
	for <linux-erofs@lists.ozlabs.org>; Thu,  4 Sep 2025 18:01:54 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756972910; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=JR64S8O2lZM6CkUs7pyiGPnq1tliCRap0mtIkQwAhpA=;
	b=Xog4BuiLknxq4temP2XOicT1uVVMbhyZrtkVWNueXPx5eIlr9inFryF/q8FUL0/De8c6KkP7vnMTlQqgUQpruoCgF6j1ejPm4mNymEsNxcfba6uLwn3dN4qkR5mzPyh+uuOv6AyZMQrD7QS5wNSbIzzOvhuCh/kCz8VDeh0CpaE=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WnF5lK9_1756972908 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 04 Sep 2025 16:01:48 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs-utils: lib: introduce erofs_io_close()
Date: Thu,  4 Sep 2025 16:01:46 +0800
Message-ID: <20250904080146.4031880-1-hsiangkao@linux.alibaba.com>
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

Since virtual files may have their own `.close()`.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/io.h |  3 +++
 lib/io.c           | 11 +++++++++--
 lib/metabox.c      |  2 +-
 lib/tar.c          |  2 +-
 mount/main.c       | 24 ++++++++++++------------
 5 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/include/erofs/io.h b/include/erofs/io.h
index 370765f..a9f6d2e 100644
--- a/include/erofs/io.h
+++ b/include/erofs/io.h
@@ -41,6 +41,7 @@ struct erofs_vfops {
 			    off_t *pos, size_t count);
 	int (*xcopy)(struct erofs_vfile *vout, off_t pos,
 		     struct erofs_vfile *vin, unsigned int len, bool noseek);
+	void (*close)(struct erofs_vfile *vf);
 };
 
 /* don't extend this; instead, use payload for any extra information */
@@ -87,6 +88,8 @@ static inline int erofs_pread(struct erofs_vfile *vf, void *buf,
 	return read != len ? -EIO : 0;
 }
 
+void erofs_io_close(struct erofs_vfile *vf);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/lib/io.c b/lib/io.c
index ff3b794..629af9c 100644
--- a/lib/io.c
+++ b/lib/io.c
@@ -380,8 +380,7 @@ out:
 
 void erofs_dev_close(struct erofs_sb_info *sbi)
 {
-	if (!sbi->bdev.ops)
-		close(sbi->bdev.fd);
+	erofs_io_close(&sbi->bdev);
 	free(sbi->devname);
 	sbi->devname = NULL;
 	sbi->bdev.fd = -1;
@@ -657,3 +656,11 @@ int erofs_io_xcopy(struct erofs_vfile *vout, off_t pos,
 	} while (len);
 	return 0;
 }
+
+void erofs_io_close(struct erofs_vfile *vf)
+{
+	if (vf->ops)
+		return vf->ops->close(vf);
+	close(vf->fd);
+	vf->fd = -1;
+}
diff --git a/lib/metabox.c b/lib/metabox.c
index fdc46eb..abde5e6 100644
--- a/lib/metabox.c
+++ b/lib/metabox.c
@@ -21,7 +21,7 @@ void erofs_metabox_exit(struct erofs_sb_info *sbi)
 		return;
 	DBG_BUGON(!m2gr->bmgr);
 	erofs_buffer_exit(m2gr->bmgr);
-	close(m2gr->vf.fd);
+	erofs_io_close(&m2gr->vf);
 	free(m2gr);
 }
 
diff --git a/lib/tar.c b/lib/tar.c
index fe801e2..c8fd48e 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -65,7 +65,7 @@ void erofs_iostream_close(struct erofs_iostream *ios)
 #endif
 		return;
 	}
-	close(ios->vf.fd);
+	erofs_io_close(&ios->vf);
 }
 
 int erofs_iostream_open(struct erofs_iostream *ios, int fd, int decoder)
diff --git a/mount/main.c b/mount/main.c
index a270f0a..149bb53 100644
--- a/mount/main.c
+++ b/mount/main.c
@@ -267,8 +267,8 @@ static void *erofsmount_nbd_loopfn(void *arg)
 			break;
 		}
 	}
-	close(ctx->vd.fd);
-	close(ctx->sk.fd);
+	erofs_io_close(&ctx->vd);
+	erofs_io_close(&ctx->sk);
 	return (void *)(uintptr_t)err;
 }
 
@@ -288,15 +288,15 @@ static int erofsmount_startnbd(int nbdfd, const char *source)
 
 	err = erofs_nbd_connect(nbdfd, 9, INT64_MAX >> 9);
 	if (err < 0) {
-		close(ctx.vd.fd);
+		erofs_io_close(&ctx.vd);
 		goto out_closefd;
 	}
 	ctx.sk.fd = err;
 
 	err = -pthread_create(&th, NULL, erofsmount_nbd_loopfn, &ctx);
 	if (err) {
-		close(ctx.vd.fd);
-		close(ctx.sk.fd);
+		erofs_io_close(&ctx.vd);
+		erofs_io_close(&ctx.sk);
 		goto out_closefd;
 	}
 
@@ -392,7 +392,7 @@ static int erofsmount_startnbd_nl(pid_t *pid, const char *source)
 	err = pipe(pipefd);
 	if (err < 0) {
 		err = -errno;
-		close(ctx.vd.fd);
+		erofs_io_close(&ctx.vd);
 		return err;
 	}
 	if ((*pid = fork()) == 0) {
@@ -400,12 +400,12 @@ static int erofsmount_startnbd_nl(pid_t *pid, const char *source)
 
 		/* Otherwise, NBD disconnect sends SIGPIPE, skipping cleanup */
 		if (signal(SIGPIPE, SIG_IGN) == SIG_ERR) {
-			close(ctx.vd.fd);
+			erofs_io_close(&ctx.vd);
 			exit(EXIT_FAILURE);
 		}
 		recp = erofsmount_write_recovery_info(source);
 		if (IS_ERR(recp)) {
-			close(ctx.vd.fd);
+			erofs_io_close(&ctx.vd);
 			exit(EXIT_FAILURE);
 		}
 		num = -1;
@@ -414,7 +414,7 @@ static int erofsmount_startnbd_nl(pid_t *pid, const char *source)
 			ctx.sk.fd = err;
 			err = erofsmount_nbd_fix_backend_linkage(num, &recp);
 			if (err) {
-				close(ctx.sk.fd);
+				erofs_io_close(&ctx.sk);
 			} else {
 				err = write(pipefd[1], &num, sizeof(int));
 				if (err < 0)
@@ -427,7 +427,7 @@ static int erofsmount_startnbd_nl(pid_t *pid, const char *source)
 				}
 			}
 		}
-		close(ctx.vd.fd);
+		erofs_io_close(&ctx.vd);
 out_fork:
 		(void)unlink(recp);
 		free(recp);
@@ -529,10 +529,10 @@ static int erofsmount_reattach(const char *target)
 				return EXIT_FAILURE;
 			return EXIT_SUCCESS;
 		}
-		close(ctx.sk.fd);
+		erofs_io_close(&ctx.sk);
 		err = 0;
 	}
-	close(ctx.vd.fd);
+	erofs_io_close(&ctx.vd);
 err_line:
 	free(line);
 err_identifier:
-- 
2.43.5


