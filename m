Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2EF49269D
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Jan 2022 14:12:47 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JdThs3mwRz3bPK
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Jan 2022 00:12:45 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.42;
 helo=out30-42.freemail.mail.aliyun.com;
 envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-42.freemail.mail.aliyun.com
 (out30-42.freemail.mail.aliyun.com [115.124.30.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JdThf2MjMz30KZ
 for <linux-erofs@lists.ozlabs.org>; Wed, 19 Jan 2022 00:12:30 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R541e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=12; SR=0; TI=SMTPD_---0V2CR7xO_1642511541; 
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0V2CR7xO_1642511541) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 18 Jan 2022 21:12:22 +0800
From: Jeffle Xu <jefflexu@linux.alibaba.com>
To: dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 04/20] cachefiles: extract generic daemon write function
Date: Tue, 18 Jan 2022 21:12:00 +0800
Message-Id: <20220118131216.85338-5-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220118131216.85338-1-jefflexu@linux.alibaba.com>
References: <20220118131216.85338-1-jefflexu@linux.alibaba.com>
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
Cc: linux-kernel@vger.kernel.org, joseph.qi@linux.alibaba.com,
 linux-fsdevel@vger.kernel.org, gerry@linux.alibaba.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

... so that the following new devnode can reuse most of the code when
implementing its .write() callback.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/cachefiles/daemon.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index 7ac04ee2c0a0..aa2e5e354afb 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -209,10 +209,11 @@ static ssize_t cachefiles_daemon_read(struct file *file, char __user *_buffer,
 /*
  * Take a command from cachefilesd, parse it and act on it.
  */
-static ssize_t cachefiles_daemon_write(struct file *file,
-				       const char __user *_data,
-				       size_t datalen,
-				       loff_t *pos)
+static ssize_t cachefiles_daemon_do_write(struct file *file,
+					  const char __user *_data,
+					  size_t datalen,
+					  loff_t *pos,
+			const struct cachefiles_daemon_cmd *cmds)
 {
 	const struct cachefiles_daemon_cmd *cmd;
 	struct cachefiles_cache *cache = file->private_data;
@@ -261,7 +262,7 @@ static ssize_t cachefiles_daemon_write(struct file *file,
 	}
 
 	/* run the appropriate command handler */
-	for (cmd = cachefiles_daemon_cmds; cmd->name[0]; cmd++)
+	for (cmd = cmds; cmd->name[0]; cmd++)
 		if (strcmp(cmd->name, data) == 0)
 			goto found_command;
 
@@ -284,6 +285,15 @@ static ssize_t cachefiles_daemon_write(struct file *file,
 	goto error;
 }
 
+static ssize_t cachefiles_daemon_write(struct file *file,
+				       const char __user *_data,
+				       size_t datalen,
+				       loff_t *pos)
+{
+	return cachefiles_daemon_do_write(file, _data, datalen, pos,
+					  cachefiles_daemon_cmds);
+}
+
 /*
  * Poll for culling state
  * - use EPOLLOUT to indicate culling state
-- 
2.27.0

