Return-Path: <linux-erofs+bounces-3692-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Un/eF6fSN2rGUQcAu9opvQ
	(envelope-from <linux-erofs+bounces-3692-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sun, 21 Jun 2026 14:01:43 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7719A6AAAC2
	for <lists+linux-erofs@lfdr.de>; Sun, 21 Jun 2026 14:01:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=hIKdzeca;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3692-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3692-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gjqgS1t45z2xWR;
	Sun, 21 Jun 2026 22:01:40 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782043299;
	cv=none; b=bhIhUpHmN8Z5CLGe2fnqMc3ZM56swEsCD+OkUKqJW2LXqFYRhz95DjK0b2cla5lRJ728C302nJ9bHB5QrMEkfo8QH/RSB+D4IFq3Vu4W/B7d1pHVaL6jCtkkliBJAdAFcg+iDZGXvfDU3gSAIaJUJcx7KmF3DEiTHQQoM3b73/2usmnNk7NztPb0loDO8WfLRir1CvQb6dqMIQ5jK6RWdcDlHgtsar9m9JGAiNx+zxZprv2JYCmXoJg3cKPjrPPtqa9YTPY6r0oh0ogZWQ/ZmJopYpwAZ6zovG7/CiwOXRYItkMzM0vTyoSQ3WiqPUDgkreGoXJE/vHM8LTC0bSZbg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782043299; c=relaxed/relaxed;
	bh=FMEW5Cjw+o2Wlc8SDNHgcRQSB29y43o+A85cejag06A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ghpnfteqfD1xveB3bQMrUMLZQhK3tnyy1Z65UrjIW2ReZ/RYixl+x2EDS1eIdYAdoN0ikMlJFJBvMgQWaTZpFj5hgQriAZcD3vsZPDHW0xVHmWCcvhdlEqTPe/jZlBK7hKxGxbJYa1CLW/A3KvOFeyA9ZjM+VgqqcIvlHAjdZmX18YASA7XUY5S4849mf/DhW3NaK0y0oQJemUbXCsAFjvK7G/3wreX+QGzwdLFRiPfF/gmO7YeAxtRk1nx9yldKpkjkXpl38BVuz0xqeXzBQ+pXMJMdlLIZtyj0vEwZUvDMPnAC/WVkbLrN/jDfGEyECfl0oTTe4jOumydoLVIqsg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hIKdzeca; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gjqgQ4wzdz2xPL
	for <linux-erofs@lists.ozlabs.org>; Sun, 21 Jun 2026 22:01:38 +1000 (AEST)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-36b9033d230so1815345a91.1
        for <linux-erofs@lists.ozlabs.org>; Sun, 21 Jun 2026 05:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782043297; x=1782648097; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FMEW5Cjw+o2Wlc8SDNHgcRQSB29y43o+A85cejag06A=;
        b=hIKdzeca+A2l/s6zTCFHfb2vtj6zNiMf52ELa6VmjaRGT/mgw1XHmq5rAxb8sR3IZ+
         9urh+M5guNk1zaJafOthcTvDQeUSNoUrKYRqOZsmHwd+cTscB49lX5TGHjT8pDpoqHQk
         VXZaMCLmCaXHkA1lxLWfcNLPwNKPre2hYCtQRgMvNB6dq3FZ0/vdECC4NBtVBUFlPBkS
         23ten8+OJKQd8sp+gA7H9rYdElBP99UGA9s9TyIo5DyPjvcFljvztg+cGvCpbfVpH+Hp
         /kg5PCG9pf8/TfTJpIoJLVYxyHCDQNZlI9Bnh4idPxiV1dVfyjL1CenQTAE8AWPFp5uD
         hvcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782043297; x=1782648097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FMEW5Cjw+o2Wlc8SDNHgcRQSB29y43o+A85cejag06A=;
        b=I28PyOfmEmPa1owUjbaAHYYj9ztskq86qWrBG4ViMbWn+XgN2T6HEfLhrP0g/rfCUG
         zQh5nHfrCwlTfxzCFVAI7i+yixKEOXOgb6/MG3lno0th6m2rwf2PSMHHWf9nOB5MGc+n
         kKIN72L9HfUX1ELEjOBf3jL8+YyGgp0aocz7mPD9AlOlbF1HgiMdLt0BiFjRRWFKRxqA
         jCJhosSJC0307sd5hF1XIbk3ZPwphWW/ixnXvX63sxyNMRQmUBggtRvyFIEKW2jZsSTY
         7V1L3dsR/0rU79m49GuSdjiFDEdtQWv1EHXloaoDWfBHChoiWSVnbKRvSKcjBVuwrARK
         Z0tQ==
X-Gm-Message-State: AOJu0YzEFRLuuwoLxXq5E0Mj4GJ3TUNho6gj6zssWXJxkLHNtBCQ9wg2
	PYl5L0zm/aNirfghgXBs45/TXpGfOjR7miGVd6TaK+zGgQymOgj3bS3WmczRTQ==
X-Gm-Gg: AfdE7clR3vl+1zf9e1HDlUV4iRLrQDjeMIlHl03APOZrP5ehOXZku2P2l4S0NGxotGs
	T1sKQbrwZqOMCKO4ZFpj02Opyz30/4vHUjPo0dOhHtHpYwUWUtBF/8oLzoIkctrqXcFAn8mBVEm
	066NXGL+G9BWvGWLorMegll0oZs6OqLmCHgz2/aIjIC0VgZc4dFyDs9vb+EV0xbU3hWMA66mBTS
	7BuarqKn5xMqW2NOwqF11NP7Vjmb+VstfwrJvVOoNetbZoR7iahoJJD3MUPzh+W3PSdOHtWIr2M
	qOqbgfD7lvgRm4BBNT15uPvi6gRxsQ0Iqt4wTt8s5dQfUFDX3CKENdXxEybOV5u2tzWLSipKP4Q
	0UflmHqOmzp17OsBQPhLCE1PsKBe600MHcLIWk56R+TZIOcW8wuBjClon+WGO3h5w6AgfRB72IT
	1bmGa4dY4jTNEsdVeftsWLmm73PGK8nZLNzbsY0A2HqAhd
X-Received: by 2002:a17:90b:3c49:b0:37d:a52a:ff12 with SMTP id 98e67ed59e1d1-37da52aff8dmr63834a91.10.1782043296504;
        Sun, 21 Jun 2026 05:01:36 -0700 (PDT)
Received: from localhost.localdomain ([157.15.11.68])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37d4f315842sm4266278a91.17.2026.06.21.05.01.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 21 Jun 2026 05:01:36 -0700 (PDT)
From: Nithurshen <nithurshen.dev@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: hsiangkao@linux.alibaba.com,
	xiang@kernel.org,
	Nithurshen <nithurshen.dev@gmail.com>
Subject: [PATCH 2/2] fsck.erofs: implement concurrent directory traversal
Date: Sun, 21 Jun 2026 17:31:21 +0530
Message-ID: <20260621120121.73114-3-nithurshen.dev@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260621120121.73114-1-nithurshen.dev@gmail.com>
References: <20260621120121.73114-1-nithurshen.dev@gmail.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD,URI_NOVOWEL
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.70 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3692-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.alibaba.com,kernel.org,gmail.com];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	ALIAS_RESOLVED(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dirstack.top:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7719A6AAAC2

Currently, fsck.erofs traverses the filesystem tree and verifies
inodes synchronously on the main thread. While decompression
compute is offloaded, the main thread remains a bottleneck
during the I/O-heavy directory walk.

This patch parallelizes the directory traversal and inode
extraction processes. To achieve this safely, the globally shared
fsckcfg.extract_path and fsckcfg.dirstack states are decoupled
and localized into individual struct erofsfsck_inode_task
payloads, which are deep-copied and handed off to the worker
pool. Global statistics and hardlink tables are secured using
native erofs_mutex_t primitives.

To prevent thread pool exhaustion deadlocks—where workers
processing a deep directory tree occupy all available execution
slots and block on erofs_cond_wait, starving their own spawned
decompression tasks—this patch introduces a dedicated
erofs_traverse_wq. By isolating the producers (traversal and
verification) from the consumers (pcluster decompression), the
pipeline avoids gridlock.

Signed-off-by: Nithurshen <nithurshen.dev@gmail.com>
---
 fsck/main.c | 300 ++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 211 insertions(+), 89 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index ffe7e29..0ed0ddd 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -19,14 +19,45 @@
 #include "../lib/liberofs_compress.h"
 
 extern struct erofs_workqueue erofs_wq;
+struct erofs_workqueue erofs_traverse_wq;
 
-static int erofsfsck_check_inode(erofs_nid_t pnid, erofs_nid_t nid);
+static EROFS_DEFINE_MUTEX(fsck_global_lock);
+static EROFS_DEFINE_MUTEX(fsck_hardlink_lock);
+
+static int fsck_pending_tasks = 0;
+static EROFS_DEFINE_MUTEX(fsck_task_lock);
+static erofs_cond_t fsck_task_cond;
+
+static void fsck_inc_task(void) {
+	erofs_mutex_lock(&fsck_task_lock);
+	fsck_pending_tasks++;
+	erofs_mutex_unlock(&fsck_task_lock);
+}
+
+static void fsck_dec_task(void) {
+	erofs_mutex_lock(&fsck_task_lock);
+	fsck_pending_tasks--;
+	if (fsck_pending_tasks == 0)
+		erofs_cond_signal(&fsck_task_cond);
+	erofs_mutex_unlock(&fsck_task_lock);
+}
+
+static void fsck_wait_tasks(void) {
+	erofs_mutex_lock(&fsck_task_lock);
+	while (fsck_pending_tasks > 0)
+		erofs_cond_wait(&fsck_task_cond, &fsck_task_lock);
+	erofs_mutex_unlock(&fsck_task_lock);
+}
 
 struct erofsfsck_dirstack {
 	erofs_nid_t dirs[PATH_MAX];
 	int top;
 };
 
+static int erofsfsck_check_inode(erofs_nid_t pnid, erofs_nid_t nid, 
+                 char *current_path, size_t pos, 
+                 struct erofsfsck_dirstack *dirstack);
+
 struct erofsfsck_cfg {
 	struct erofsfsck_dirstack dirstack;
 	u64 physical_blocks;
@@ -425,7 +456,7 @@ out:
 	return ret;
 }
 
-static int erofsfsck_dump_xattrs(struct erofs_inode *inode)
+static int erofsfsck_dump_xattrs(struct erofs_inode *inode, const char *current_path)
 {
 	static bool ignore_xattrs = false;
 	char *keylst, *key;
@@ -472,7 +503,7 @@ static int erofsfsck_dump_xattrs(struct erofs_inode *inode)
 			break;
 		}
 		if (fsckcfg.extract_path)
-			ret = erofs_sys_lsetxattr(fsckcfg.extract_path, key,
+			ret = erofs_sys_lsetxattr(current_path, key,
 						  value, size);
 		else
 			ret = 0;
@@ -587,9 +618,11 @@ out:
 	erofs_mutex_unlock(&ctx.lock);
 
 	if (fsckcfg.print_comp_ratio) {
+		erofs_mutex_lock(&fsck_global_lock);
 		if (!erofs_is_packed_inode(inode))
 			fsckcfg.logical_blocks += BLK_ROUND_UP(inode->sbi, inode->i_size);
 		fsckcfg.physical_blocks += BLK_ROUND_UP(inode->sbi, pchunk_len);
+		erofs_mutex_unlock(&fsck_global_lock);
 	}
 
 	if (outfd >= 0 && ret >= 0)
@@ -600,11 +633,11 @@ out:
 	return ret < 0 ? ret : 0;
 }
 
-static inline int erofs_extract_dir(struct erofs_inode *inode)
+static inline int erofs_extract_dir(struct erofs_inode *inode, const char *current_path)
 {
 	int ret;
 
-	erofs_dbg("create directory %s", fsckcfg.extract_path);
+    erofs_dbg("create directory %s", current_path);
 
 	/* verify data chunk layout */
 	ret = erofs_verify_inode_data(inode, -1);
@@ -617,19 +650,19 @@ static inline int erofs_extract_dir(struct erofs_inode *inode)
 	 * write/execute permission.  These are fixed up later in
 	 * erofsfsck_set_attributes().
 	 */
-	if (mkdir(fsckcfg.extract_path, 0700) < 0) {
+	if (mkdir(current_path, 0700) < 0) {
 		struct stat st;
 
 		if (errno != EEXIST) {
 			erofs_err("failed to create directory: %s (%s)",
-				  fsckcfg.extract_path, strerror(errno));
+				  current_path, strerror(errno));
 			return -errno;
 		}
 
-		if (lstat(fsckcfg.extract_path, &st) ||
+		if (lstat(current_path, &st) ||
 		    !S_ISDIR(st.st_mode)) {
 			erofs_err("path is not a directory: %s",
-				  fsckcfg.extract_path);
+				  current_path);
 			return -ENOTDIR;
 		}
 
@@ -637,9 +670,9 @@ static inline int erofs_extract_dir(struct erofs_inode *inode)
 		 * Try to change permissions of existing directory so
 		 * that we can write to it
 		 */
-		if (chmod(fsckcfg.extract_path, 0700) < 0) {
+		if (chmod(current_path, 0700) < 0) {
 			erofs_err("failed to set permissions: %s (%s)",
-				  fsckcfg.extract_path, strerror(errno));
+				  current_path, strerror(errno));
 			return -errno;
 		}
 	}
@@ -651,11 +684,17 @@ static char *erofsfsck_hardlink_find(erofs_nid_t nid)
 	struct list_head *head =
 			&erofsfsck_link_hashtable[nid % NR_HARDLINK_HASHTABLE];
 	struct erofsfsck_hardlink_entry *entry;
+	 char *path = NULL;
 
-	list_for_each_entry(entry, head, list)
-		if (entry->nid == nid)
+	erofs_mutex_lock(&fsck_hardlink_lock);
+	list_for_each_entry(entry, head, list){
+		if (entry->nid == nid){
 			return entry->path;
-	return NULL;
+			break;
+		}
+	}
+	erofs_mutex_unlock(&fsck_hardlink_lock);
+	return path;
 }
 
 static int erofsfsck_hardlink_insert(erofs_nid_t nid, const char *path)
@@ -673,8 +712,10 @@ static int erofsfsck_hardlink_insert(erofs_nid_t nid, const char *path)
 		return -ENOMEM;
 	}
 
+	erofs_mutex_lock(&fsck_hardlink_lock);
 	list_add_tail(&entry->list,
 		      &erofsfsck_link_hashtable[nid % NR_HARDLINK_HASHTABLE]);
+	erofs_mutex_unlock(&fsck_hardlink_lock);
 	return 0;
 }
 
@@ -703,37 +744,37 @@ static void erofsfsck_hardlink_exit(void)
 	}
 }
 
-static inline int erofs_extract_file(struct erofs_inode *inode)
+static inline int erofs_extract_file(struct erofs_inode *inode, const char *current_path)
 {
 	bool tryagain = true;
 	int ret, fd;
 
-	erofs_dbg("extract file to path: %s", fsckcfg.extract_path);
+	erofs_dbg("extract file to path: %s", current_path);
 
 again:
-	fd = open(fsckcfg.extract_path,
+	fd = open(current_path,
 		  O_WRONLY | O_CREAT | O_NOFOLLOW |
 			(fsckcfg.overwrite ? O_TRUNC : O_EXCL), 0700);
 	if (fd < 0) {
 		if (fsckcfg.overwrite && tryagain) {
 			if (errno == EISDIR) {
 				erofs_warn("try to forcely remove directory %s",
-					   fsckcfg.extract_path);
-				if (rmdir(fsckcfg.extract_path) < 0) {
+					   current_path);
+				if (rmdir(current_path) < 0) {
 					erofs_err("failed to remove: %s (%s)",
-						  fsckcfg.extract_path, strerror(errno));
+						  current_path, strerror(errno));
 					return -EISDIR;
 				}
 			} else if (errno == EACCES &&
-				   chmod(fsckcfg.extract_path, 0700) < 0) {
+				   chmod(current_path, 0700) < 0) {
 				erofs_err("failed to set permissions: %s (%s)",
-					  fsckcfg.extract_path, strerror(errno));
+					  current_path, strerror(errno));
 				return -errno;
 			}
 			tryagain = false;
 			goto again;
 		}
-		erofs_err("failed to open: %s (%s)", fsckcfg.extract_path,
+		erofs_err("failed to open: %s (%s)", current_path,
 			  strerror(errno));
 		return -errno;
 	}
@@ -744,14 +785,14 @@ again:
 	return ret;
 }
 
-static inline int erofs_extract_symlink(struct erofs_inode *inode)
+static inline int erofs_extract_symlink(struct erofs_inode *inode, const char *current_path)
 {
 	struct erofs_vfile vf;
 	bool tryagain = true;
 	int ret;
 	char *buf = NULL;
 
-	erofs_dbg("extract symlink to path: %s", fsckcfg.extract_path);
+	erofs_dbg("extract symlink to path: %s", current_path);
 
 	/* verify data chunk layout */
 	ret = erofs_verify_inode_data(inode, -1);
@@ -777,13 +818,13 @@ static inline int erofs_extract_symlink(struct erofs_inode *inode)
 
 	buf[inode->i_size] = '\0';
 again:
-	if (symlink(buf, fsckcfg.extract_path) < 0) {
+	if (symlink(buf, current_path) < 0) {
 		if (errno == EEXIST && fsckcfg.overwrite && tryagain) {
 			erofs_warn("try to forcely remove file %s",
-				   fsckcfg.extract_path);
-			if (unlink(fsckcfg.extract_path) < 0) {
+				   current_path);
+			if (unlink(current_path) < 0) {
 				erofs_err("failed to remove: %s",
-					  fsckcfg.extract_path);
+					  current_path);
 				ret = -errno;
 				goto out;
 			}
@@ -791,7 +832,7 @@ again:
 			goto again;
 		}
 		erofs_err("failed to create symlink: %s",
-			  fsckcfg.extract_path);
+			  current_path);
 		ret = -errno;
 	}
 out:
@@ -800,12 +841,12 @@ out:
 	return ret;
 }
 
-static int erofs_extract_special(struct erofs_inode *inode)
+static int erofs_extract_special(struct erofs_inode *inode, const char *current_path)
 {
 	bool tryagain = true;
 	int ret;
 
-	erofs_dbg("extract special to path: %s", fsckcfg.extract_path);
+    erofs_dbg("extract special to path: %s", current_path);
 
 	/* verify data chunk layout */
 	ret = erofs_verify_inode_data(inode, -1);
@@ -813,13 +854,13 @@ static int erofs_extract_special(struct erofs_inode *inode)
 		return ret;
 
 again:
-	if (mknod(fsckcfg.extract_path, inode->i_mode, inode->u.i_rdev) < 0) {
+	if (mknod(current_path, inode->i_mode, inode->u.i_rdev) < 0) {
 		if (errno == EEXIST && fsckcfg.overwrite && tryagain) {
 			erofs_warn("try to forcely remove file %s",
-				   fsckcfg.extract_path);
-			if (unlink(fsckcfg.extract_path) < 0) {
+				   current_path);
+			if (unlink(current_path) < 0) {
 				erofs_err("failed to remove: %s",
-					  fsckcfg.extract_path);
+					  current_path);
 				return -errno;
 			}
 			tryagain = false;
@@ -827,11 +868,11 @@ again:
 		}
 		if (errno == EEXIST || fsckcfg.superuser) {
 			erofs_err("failed to create special file: %s",
-				  fsckcfg.extract_path);
+				  current_path);
 			ret = -errno;
 		} else {
 			erofs_warn("failed to create special file: %s, skipped",
-				   fsckcfg.extract_path);
+				   current_path);
 			ret = -ECANCELED;
 		}
 	}
@@ -854,47 +895,82 @@ static int erofsfsck_get_parent_cb(struct erofs_dir_context *ctx)
 	return 0;
 }
 
+struct erofsfsck_inode_task {
+    struct erofs_work work;
+    erofs_nid_t pnid;
+    erofs_nid_t nid;
+    char *path;
+    size_t path_pos;
+    struct erofsfsck_dirstack dirstack;
+};
+
+static void erofsfsck_check_inode_worker(struct erofs_work *work, void *tlsp);
+
+struct erofsfsck_dir_iter_ctx {
+    struct erofs_dir_context ctx;
+    char *base_path;
+    size_t base_pos;
+    struct erofsfsck_dirstack *dirstack;
+};
+
 static int erofsfsck_dirent_iter(struct erofs_dir_context *ctx)
 {
-	int ret;
-	size_t prev_pos, curr_pos;
+    struct erofsfsck_dir_iter_ctx *ictx = (void *)ctx;
+    size_t curr_pos = ictx->base_pos;
+    char *new_path = NULL;
 
 	if (ctx->dot_dotdot)
 		return 0;
 
-	prev_pos = fsckcfg.extract_pos;
-	curr_pos = prev_pos;
-
-	if (prev_pos + ctx->de_namelen >= PATH_MAX) {
-		erofs_err("unable to fsck since the path is too long (%llu)",
-			  (curr_pos + ctx->de_namelen) | 0ULL);
-		return -EOPNOTSUPP;
-	}
+    if (curr_pos + ctx->de_namelen >= PATH_MAX) {
+        erofs_err("unable to fsck since the path is too long");
+        return -EOPNOTSUPP;
+    }
 
 	if (fsckcfg.extract_path) {
-		fsckcfg.extract_path[curr_pos++] = '/';
-		strncpy(fsckcfg.extract_path + curr_pos, ctx->dname,
-			ctx->de_namelen);
+		new_path = malloc(PATH_MAX);
+		if (!new_path) return -ENOMEM;
+		
+		if (ictx->base_path)
+			memcpy(new_path, ictx->base_path, curr_pos);
+			
+		new_path[curr_pos++] = '/';
+		strncpy(new_path + curr_pos, ctx->dname, ctx->de_namelen);
 		curr_pos += ctx->de_namelen;
-		fsckcfg.extract_path[curr_pos] = '\0';
+		new_path[curr_pos] = '\0';
 	} else {
 		curr_pos += ctx->de_namelen;
 	}
-	fsckcfg.extract_pos = curr_pos;
-	ret = erofsfsck_check_inode(ctx->dir->nid, ctx->de_nid);
 
-	if (fsckcfg.extract_path)
-		fsckcfg.extract_path[prev_pos] = '\0';
-	fsckcfg.extract_pos = prev_pos;
-	return ret;
+	struct erofsfsck_inode_task *task = malloc(sizeof(*task));
+	if (!task) {
+		free(new_path);
+		return -ENOMEM;
+	}
+
+	task->work.fn = erofsfsck_check_inode_worker;
+	task->work.next = NULL;
+	task->pnid = ctx->dir->nid;
+	task->nid = ctx->de_nid;
+	task->path = new_path;
+	task->path_pos = curr_pos;
+	task->dirstack = *(ictx->dirstack);
+
+	fsck_inc_task();
+#ifdef EROFS_MT_ENABLED
+	erofs_queue_work(&erofs_traverse_wq, &task->work);
+#else
+	task->work.fn(&task->work, NULL);
+#endif
+	return 0;
 }
 
-static int erofsfsck_extract_inode(struct erofs_inode *inode)
+static int erofsfsck_extract_inode(struct erofs_inode *inode, const char *current_path)
 {
 	int ret;
 	char *oldpath;
 
-	if (!fsckcfg.extract_path || erofs_is_packed_inode(inode)) {
+    if (!current_path || erofs_is_packed_inode(inode)) {
 verify:
 		/* verify data chunk layout */
 		return erofs_verify_inode_data(inode, -1);
@@ -902,9 +978,9 @@ verify:
 
 	oldpath = erofsfsck_hardlink_find(inode->nid);
 	if (oldpath) {
-		if (link(oldpath, fsckcfg.extract_path) == -1) {
+		if (link(oldpath, current_path) == -1) {
 			erofs_err("failed to extract hard link: %s (%s)",
-				  fsckcfg.extract_path, strerror(errno));
+				  current_path, strerror(errno));
 			return -errno;
 		}
 		return 0;
@@ -912,19 +988,19 @@ verify:
 
 	switch (inode->i_mode & S_IFMT) {
 	case S_IFDIR:
-		ret = erofs_extract_dir(inode);
+		ret = erofs_extract_dir(inode, current_path);
 		break;
 	case S_IFREG:
-		ret = erofs_extract_file(inode);
+		ret = erofs_extract_file(inode, current_path);
 		break;
 	case S_IFLNK:
-		ret = erofs_extract_symlink(inode);
+		ret = erofs_extract_symlink(inode, current_path);
 		break;
 	case S_IFCHR:
 	case S_IFBLK:
 	case S_IFIFO:
 	case S_IFSOCK:
-		ret = erofs_extract_special(inode);
+		ret = erofs_extract_special(inode, current_path);
 		break;
 	default:
 		/* TODO */
@@ -936,11 +1012,13 @@ verify:
 	/* record nid and old path for hardlink */
 	if (inode->i_nlink > 1 && !S_ISDIR(inode->i_mode))
 		ret = erofsfsck_hardlink_insert(inode->nid,
-						fsckcfg.extract_path);
+						current_path);
 	return ret;
 }
 
-static int erofsfsck_check_inode(erofs_nid_t pnid, erofs_nid_t nid)
+static int erofsfsck_check_inode(erofs_nid_t pnid, erofs_nid_t nid, 
+                 char *current_path, size_t pos, 
+                 struct erofsfsck_dirstack *dirstack)
 {
 	int ret, i;
 	struct erofs_inode inode = {.sbi = &g_sbi, .nid = nid};
@@ -961,44 +1039,63 @@ static int erofsfsck_check_inode(erofs_nid_t pnid, erofs_nid_t nid)
 			goto out;
 	}
 
-	ret = erofsfsck_extract_inode(&inode);
+	ret = erofsfsck_extract_inode(&inode, current_path);
 	if (ret && ret != -ECANCELED)
 		goto out;
 
 	if (fsckcfg.check_decomp && fsckcfg.dump_xattrs) {
-		ret = erofsfsck_dump_xattrs(&inode);
+		ret = erofsfsck_dump_xattrs(&inode, current_path);
 		if (ret)
 			return ret;
 	}
 
 	if (S_ISDIR(inode.i_mode)) {
-		struct erofs_dir_context ctx = {
-			.flags = EROFS_READDIR_VALID_PNID,
-			.pnid = pnid,
-			.dir = &inode,
-			.cb = erofsfsck_dirent_iter,
+		struct erofsfsck_dir_iter_ctx ctx = {
+			.ctx.flags = EROFS_READDIR_VALID_PNID,
+			.ctx.pnid = pnid,
+			.ctx.dir = &inode,
+			.ctx.cb = erofsfsck_dirent_iter,
+			.base_path = current_path,
+			.base_pos = pos,
+			.dirstack = dirstack
 		};
 
-		/* XXX: support the deeper cases later */
-		if (fsckcfg.dirstack.top >= ARRAY_SIZE(fsckcfg.dirstack.dirs))
+		if (dirstack->top >= ARRAY_SIZE(dirstack->dirs))
 			return -ENAMETOOLONG;
-		for (i = 0; i < fsckcfg.dirstack.top; ++i)
-			if (inode.nid == fsckcfg.dirstack.dirs[i])
+		for (i = 0; i < dirstack->top; ++i)
+			if (inode.nid == dirstack->dirs[i])
 				return -ELOOP;
-		fsckcfg.dirstack.dirs[fsckcfg.dirstack.top++] = pnid;
-		ret = erofs_iterate_dir(&ctx, true);
-		--fsckcfg.dirstack.top;
+		
+		dirstack->dirs[dirstack->top++] = pnid;
+		ret = erofs_iterate_dir(&ctx.ctx, true);
+		--dirstack->top;
 	}
 
-	if (!ret && !erofs_is_packed_inode(&inode))
-		erofsfsck_set_attributes(&inode, fsckcfg.extract_path);
+	if (!ret && !erofs_is_packed_inode(&inode) && current_path)
+		erofsfsck_set_attributes(&inode, current_path);
 
 	if (ret == -ECANCELED)
 		ret = 0;
 out:
-	if (ret && ret != -EIO)
-		fsckcfg.corrupted = true;
-	return ret;
+    if (ret && ret != -EIO) {
+        erofs_mutex_lock(&fsck_global_lock);
+        fsckcfg.corrupted = true;
+        erofs_mutex_unlock(&fsck_global_lock);
+    }
+    return ret;
+}
+
+static void erofsfsck_check_inode_worker(struct erofs_work *work, void *tlsp)
+{
+    struct erofsfsck_inode_task *task = (struct erofsfsck_inode_task *)work;
+    
+    erofsfsck_check_inode(task->pnid, task->nid, task->path, 
+                  task->path_pos, &task->dirstack);
+    
+    if (task->path)
+        free(task->path);
+    free(task);
+    fsck_dec_task();
 }
 
 #ifdef FUZZING
@@ -1020,6 +1117,7 @@ int main(int argc, char *argv[])
 	if (workers < 1) 
 		workers = 1;
 	erofs_alloc_workqueue(&erofs_wq, workers, 256, NULL, NULL);
+	erofs_alloc_workqueue(&erofs_traverse_wq, workers, 256, NULL, NULL);
 #endif
 
 	fsckcfg.physical_blocks = 0;
@@ -1086,6 +1184,8 @@ int main(int argc, char *argv[])
 		fsckcfg.nid = g_sbi.root_nid;
 	}
 
+	erofs_cond_init(&fsck_task_cond);
+
 	if (!fsckcfg.inode_path && fsckcfg.nid == g_sbi.root_nid) {
 		if (erofs_sb_has_fragments(&g_sbi) && g_sbi.packed_nid > 0) {
 			err = erofs_packedfile_init(&g_sbi, false);
@@ -1095,7 +1195,7 @@ int main(int argc, char *argv[])
 				goto exit_hardlink;
 			}
 
-			err = erofsfsck_check_inode(g_sbi.packed_nid, g_sbi.packed_nid);
+			err = erofsfsck_check_inode(g_sbi.packed_nid, g_sbi.packed_nid, NULL, 0, &fsckcfg.dirstack);
 			if (err) {
 				erofs_err("failed to verify packed file");
 				goto exit_packedinode;
@@ -1120,7 +1220,26 @@ int main(int argc, char *argv[])
 					pnid = ctx.pnid;
 			}
 		}
-		err = erofsfsck_check_inode(pnid, fsckcfg.nid);
+		
+		fsck_inc_task();
+		struct erofsfsck_inode_task *root_task = calloc(1, sizeof(*root_task));
+		root_task->work.fn = erofsfsck_check_inode_worker;
+		root_task->pnid = pnid;
+		root_task->nid = fsckcfg.nid;
+		
+		if (fsckcfg.extract_path)
+			root_task->path = strdup(fsckcfg.extract_path);
+			
+		root_task->path_pos = fsckcfg.extract_pos;
+		root_task->dirstack = fsckcfg.dirstack;
+
+#ifdef EROFS_MT_ENABLED
+		erofs_queue_work(&erofs_traverse_wq, &root_task->work);
+#else
+		root_task->work.fn(&root_task->work, NULL);
+#endif
+
+		fsck_wait_tasks();
 	}
 
 	if (fsckcfg.corrupted) {
@@ -1144,6 +1263,8 @@ int main(int argc, char *argv[])
 		}
 	}
 
+    erofs_cond_destroy(&fsck_task_cond);
+
 exit_packedinode:
 	erofs_packedfile_exit(&g_sbi);
 exit_hardlink:
@@ -1158,6 +1279,7 @@ exit:
 	erofs_exit_configure();
 #ifdef EROFS_MT_ENABLED
 	erofs_destroy_workqueue(&erofs_wq);
+	erofs_destroy_workqueue(&erofs_traverse_wq);
 #endif
 	return err ? 1 : 0;
 }
-- 
2.52.0


