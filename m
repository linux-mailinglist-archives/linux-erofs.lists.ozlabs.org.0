Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD6247FD06
	for <lists+linux-erofs@lfdr.de>; Mon, 27 Dec 2021 13:55:47 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JMyMP1bX1z3c65
	for <lists+linux-erofs@lfdr.de>; Mon, 27 Dec 2021 23:55:45 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131;
 helo=out30-131.freemail.mail.aliyun.com;
 envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JMyMG3cNhz30RS
 for <linux-erofs@lists.ozlabs.org>; Mon, 27 Dec 2021 23:55:37 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=12; SR=0; TI=SMTPD_---0V.xJoPB_1640609686; 
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0V.xJoPB_1640609686) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 27 Dec 2021 20:54:47 +0800
From: Jeffle Xu <jefflexu@linux.alibaba.com>
To: dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
Subject: [PATCH v1 02/23] cachefiles: add mode command to distinguish modes
Date: Mon, 27 Dec 2021 20:54:23 +0800
Message-Id: <20211227125444.21187-3-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211227125444.21187-1-jefflexu@linux.alibaba.com>
References: <20211227125444.21187-1-jefflexu@linux.alibaba.com>
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

Add one flag bit to distinguish the new introduced demand-read mode from
the original mode. User daemon could set the specified mode with 'mode'
command. If user daemon doesn't ever explicitly set the mode, then the
behaviour is the same with that prior this patch, i.e. cachefiles serves
as the local cache for remote fs by default.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/cachefiles/daemon.c   | 32 ++++++++++++++++++++++++++++++++
 fs/cachefiles/internal.h |  1 +
 2 files changed, 33 insertions(+)

diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index 871f1e0f423d..892a9bdba53f 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -41,6 +41,7 @@ static int cachefiles_daemon_dir(struct cachefiles_cache *, char *);
 static int cachefiles_daemon_inuse(struct cachefiles_cache *, char *);
 static int cachefiles_daemon_secctx(struct cachefiles_cache *, char *);
 static int cachefiles_daemon_tag(struct cachefiles_cache *, char *);
+static int cachefiles_daemon_mode(struct cachefiles_cache *, char *);
 static int cachefiles_daemon_bind(struct cachefiles_cache *, char *);
 static void cachefiles_daemon_unbind(struct cachefiles_cache *);
 
@@ -83,6 +84,7 @@ static const struct cachefiles_daemon_cmd cachefiles_daemon_cmds[] = {
 	{ "inuse",	cachefiles_daemon_inuse		},
 	{ "secctx",	cachefiles_daemon_secctx	},
 	{ "tag",	cachefiles_daemon_tag		},
+	{ "mode",	cachefiles_daemon_mode		},
 	{ "",		NULL				}
 };
 
@@ -671,6 +673,36 @@ static int cachefiles_daemon_inuse(struct cachefiles_cache *cache, char *args)
 	return -EINVAL;
 }
 
+/*
+ * Set the cache mode
+ * - command: "mode cache|demand"
+ */
+static int cachefiles_daemon_mode(struct cachefiles_cache *cache, char *args)
+{
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
+		clear_bit(CACHEFILES_DEMAND_MODE, &cache->flags);
+	} else if (!strncmp(args, "demand", strlen("demand"))) {
+		set_bit(CACHEFILES_DEMAND_MODE, &cache->flags);
+	} else {
+		pr_err("Invalid mode specified\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 /*
  * Bind a directory as a cache
  */
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index e0ed811d628d..a8e6500889d7 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -98,6 +98,7 @@ struct cachefiles_cache {
 #define CACHEFILES_DEAD			1	/* T if cache dead */
 #define CACHEFILES_CULLING		2	/* T if cull engaged */
 #define CACHEFILES_STATE_CHANGED	3	/* T if state changed (poll trigger) */
+#define CACHEFILES_DEMAND_MODE		4	/* T if works in demand read mode for read-only fs */
 	char				*rootdirname;	/* name of cache root directory */
 	char				*secctx;	/* LSM security context */
 	char				*tag;		/* cache binding tag */
-- 
2.27.0

