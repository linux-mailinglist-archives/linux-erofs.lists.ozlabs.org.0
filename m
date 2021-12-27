Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB3F47FD1D
	for <lists+linux-erofs@lfdr.de>; Mon, 27 Dec 2021 13:56:52 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JMyNf3Brvz2yws
	for <lists+linux-erofs@lfdr.de>; Mon, 27 Dec 2021 23:56:50 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.43;
 helo=out30-43.freemail.mail.aliyun.com;
 envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-43.freemail.mail.aliyun.com
 (out30-43.freemail.mail.aliyun.com [115.124.30.43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JMyNZ5WgNz2ynD
 for <linux-erofs@lists.ozlabs.org>; Mon, 27 Dec 2021 23:56:46 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R311e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=12; SR=0; TI=SMTPD_---0V.wXYT2_1640609685; 
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0V.wXYT2_1640609685) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 27 Dec 2021 20:54:46 +0800
From: Jeffle Xu <jefflexu@linux.alibaba.com>
To: dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
Subject: [PATCH v1 01/23] cachefiles: add cachefiles_demand devnode
Date: Mon, 27 Dec 2021 20:54:22 +0800
Message-Id: <20211227125444.21187-2-jefflexu@linux.alibaba.com>
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

fscache/cachefiles used to serve as a local cache for remote fs. The
following patches will introduce a new use case, in which local
read-only fs could implement demand reading with fscache. By then the
user daemon needs to read and poll on the devnode, and thus the original
cachefiles devnode can't be reused in this case.

Thus create a new devnode specifically for the new mode. The following
patches will add more file_operations.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/cachefiles/daemon.c   |  8 ++++++++
 fs/cachefiles/internal.h |  1 +
 fs/cachefiles/main.c     | 12 ++++++++++++
 3 files changed, 21 insertions(+)

diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index 40a792421fc1..871f1e0f423d 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -56,6 +56,14 @@ const struct file_operations cachefiles_daemon_fops = {
 	.llseek		= noop_llseek,
 };
 
+const struct file_operations cachefiles_demand_fops = {
+	.owner		= THIS_MODULE,
+	.open		= cachefiles_daemon_open,
+	.release	= cachefiles_daemon_release,
+	.write		= cachefiles_daemon_write,
+	.llseek		= noop_llseek,
+};
+
 struct cachefiles_daemon_cmd {
 	char name[8];
 	int (*handler)(struct cachefiles_cache *cache, char *args);
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 421423819d63..e0ed811d628d 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -145,6 +145,7 @@ extern int cachefiles_has_space(struct cachefiles_cache *cache,
  * daemon.c
  */
 extern const struct file_operations cachefiles_daemon_fops;
+extern const struct file_operations cachefiles_demand_fops;
 
 /*
  * error_inject.c
diff --git a/fs/cachefiles/main.c b/fs/cachefiles/main.c
index 3f369c6f816d..0a423274d283 100644
--- a/fs/cachefiles/main.c
+++ b/fs/cachefiles/main.c
@@ -39,6 +39,12 @@ static struct miscdevice cachefiles_dev = {
 	.fops	= &cachefiles_daemon_fops,
 };
 
+static struct miscdevice cachefiles_demand_dev = {
+	.minor	= MISC_DYNAMIC_MINOR,
+	.name	= "cachefiles_demand",
+	.fops	= &cachefiles_demand_fops,
+};
+
 /*
  * initialise the fs caching module
  */
@@ -52,6 +58,9 @@ static int __init cachefiles_init(void)
 	ret = misc_register(&cachefiles_dev);
 	if (ret < 0)
 		goto error_dev;
+	ret = misc_register(&cachefiles_demand_dev);
+	if (ret < 0)
+		goto error_demand_dev;
 
 	/* create an object jar */
 	ret = -ENOMEM;
@@ -68,6 +77,8 @@ static int __init cachefiles_init(void)
 	return 0;
 
 error_object_jar:
+	misc_deregister(&cachefiles_demand_dev);
+error_demand_dev:
 	misc_deregister(&cachefiles_dev);
 error_dev:
 	cachefiles_unregister_error_injection();
@@ -86,6 +97,7 @@ static void __exit cachefiles_exit(void)
 	pr_info("Unloading\n");
 
 	kmem_cache_destroy(cachefiles_object_jar);
+	misc_deregister(&cachefiles_demand_dev);
 	misc_deregister(&cachefiles_dev);
 	cachefiles_unregister_error_injection();
 }
-- 
2.27.0

