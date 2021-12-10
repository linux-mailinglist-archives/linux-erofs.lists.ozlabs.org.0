Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8208D46FBEE
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Dec 2021 08:41:49 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4J9NBz0rcVz3bjD
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Dec 2021 18:41:47 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.57;
 helo=out30-57.freemail.mail.aliyun.com;
 envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
X-Greylist: delayed 307 seconds by postgrey-1.36 at boromir;
 Fri, 10 Dec 2021 18:41:43 AEDT
Received: from out30-57.freemail.mail.aliyun.com
 (out30-57.freemail.mail.aliyun.com [115.124.30.57])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4J9NBv20T3z2yng
 for <linux-erofs@lists.ozlabs.org>; Fri, 10 Dec 2021 18:41:42 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R181e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=alimailimapcm10staff010182156082;
 MF=jefflexu@linux.alibaba.com; NM=1; PH=DS; RN=12; SR=0;
 TI=SMTPD_---0V-8E0Od_1639121780; 
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0V-8E0Od_1639121780) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 10 Dec 2021 15:36:21 +0800
From: Jeffle Xu <jefflexu@linux.alibaba.com>
To: dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
Subject: [RFC 01/19] cachefiles: add mode command
Date: Fri, 10 Dec 2021 15:36:01 +0800
Message-Id: <20211210073619.21667-2-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211210073619.21667-1-jefflexu@linux.alibaba.com>
References: <20211210073619.21667-1-jefflexu@linux.alibaba.com>
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
Cc: tao.peng@linux.alibaba.com, linux-kernel@vger.kernel.org,
 joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
 linux-fsdevel@vger.kernel.org, eguan@linux.alibaba.com,
 gerry@linux.alibaba.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

fscache/cachefiles used to serve as a local cache for remote fs.
This patch set introduces a new use case, in which local read-only
fs could implement demand read with fscache.

Thus 'mode' field is used to distinguish which mode cachefiles works in.
User daemon could set the specified mode with 'mode' command. If user
daemon doesn't ever explicitly set the mode, then cachefiles serves as
the local cache for remote fs by default.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/cachefiles/daemon.c   | 35 +++++++++++++++++++++++++++++++++++
 fs/cachefiles/internal.h |  6 ++++++
 2 files changed, 41 insertions(+)

diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index 40a792421fc1..951963e72b44 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -41,6 +41,7 @@ static int cachefiles_daemon_dir(struct cachefiles_cache *, char *);
 static int cachefiles_daemon_inuse(struct cachefiles_cache *, char *);
 static int cachefiles_daemon_secctx(struct cachefiles_cache *, char *);
 static int cachefiles_daemon_tag(struct cachefiles_cache *, char *);
+static int cachefiles_daemon_mode(struct cachefiles_cache *, char *);
 static int cachefiles_daemon_bind(struct cachefiles_cache *, char *);
 static void cachefiles_daemon_unbind(struct cachefiles_cache *);
 
@@ -75,6 +76,7 @@ static const struct cachefiles_daemon_cmd cachefiles_daemon_cmds[] = {
 	{ "inuse",	cachefiles_daemon_inuse		},
 	{ "secctx",	cachefiles_daemon_secctx	},
 	{ "tag",	cachefiles_daemon_tag		},
+	{ "mode",	cachefiles_daemon_mode		},
 	{ "",		NULL				}
 };
 
@@ -663,6 +665,39 @@ static int cachefiles_daemon_inuse(struct cachefiles_cache *cache, char *args)
 	return -EINVAL;
 }
 
+/*
+ * Set the cache mode
+ * - command: "mode cache|demand"
+ */
+static int cachefiles_daemon_mode(struct cachefiles_cache *cache, char *args)
+{
+	enum cachefiles_mode mode;
+
+	_enter(",%s", args);
+
+	if (test_bit(CACHEFILES_READY, &cache->flags)) {
+		pr_err("Cache already started\n");
+		return -EINVAL;
+	}
+
+	if (!*args) {
+		pr_err("Empty mode specified\n");
+		return -EINVAL;
+	}
+
+	if (!strncmp(args, "cache", strlen("cache"))) {
+		mode = CACHEFILES_MODE_CACHE;
+	} else if (!strncmp(args, "demand", strlen("demand"))) {
+		mode = CACHEFILES_MODE_DEMAND;
+	} else {
+		pr_err("Invalid mode specified\n");
+		return -EINVAL;
+	}
+
+	cache->mode = mode;
+	return 0;
+}
+
 /*
  * Bind a directory as a cache
  */
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index f42021b3a0be..1366e4319b4e 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -60,6 +60,11 @@ struct cachefiles_object {
 #define CACHEFILES_OBJECT_USING_TMPFILE	0		/* Have an unlinked tmpfile */
 };
 
+enum cachefiles_mode {
+	CACHEFILES_MODE_CACHE,	/* local cache for netfs (Default) */
+	CACHEFILES_MODE_DEMAND,	/* demand read for read-only fs */
+};
+
 /*
  * Cache files cache definition
  */
@@ -93,6 +98,7 @@ struct cachefiles_cache {
 	sector_t			brun;		/* when to stop culling */
 	sector_t			bcull;		/* when to start culling */
 	sector_t			bstop;		/* when to stop allocating */
+	enum cachefiles_mode		mode;
 	unsigned long			flags;
 #define CACHEFILES_READY		0	/* T if cache prepared */
 #define CACHEFILES_DEAD			1	/* T if cache dead */
-- 
2.27.0

