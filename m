Return-Path: <linux-erofs+bounces-2767-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HYbE953uGn5dgEAu9opvQ
	(envelope-from <linux-erofs+bounces-2767-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 22:36:30 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6336C2A106B
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 22:36:29 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZT1Q5DkCz2xlM;
	Tue, 17 Mar 2026 08:36:26 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::835"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773696986;
	cv=none; b=ChhyCgAfDU3Q991Iaxsy+AgVel8ScWrux8T65fqMO7txPEHv0104/fCK2hTHIjy4j7Z2HCohEnUOBlp1mR3d7FL6wao4SCNDLbMmaS6xIsbSCWnD5WvBZu8d8seqhpdsig0a9PDNguoeNZ1TRC3N1/KwBI9vyjRoinWoqE8lKdKlJ6E5YXom9PpoMLzNVzJMcqDLpMHjhjqelTwZkI3ghifjzhpyoF6g8kNPsT7fuSR/TbwINcymFQdCRANMnPHSCyy1qhRRUEx329fyEv1a101AbaXW1bJkrLHjFImPznRK5YNgjd/IbKjl+SLeFhmqfHhBioen/4b1vXGe+Zuv6g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773696986; c=relaxed/relaxed;
	bh=yZTER0ejJMHI8vN1WrhfquHMJBWsRpf8IPY3C8XWv6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oi1AykgkFsVJx7lmA5UEVMsPaRbaddsL/kcaVatDqbW88iSd04r7jjhh0t9bcQWIpagQc29VEuZPBOSAzjXqwJh9SDvjtat4jTIKxHsOy6ku4/USrtZcdXhbt+WmtMwtskfu/+lHWC2CsWM5AjRhTAg0FSjGuleqHIQXyatSRzvPK4BXCS8Q+yUGs4ICEhs0VyG7N9efV+T2MDzmp0gPoaGB5McD4/5zzH5P9tpTM6KEeqPhUza2ZU1iHBOYvDa6EG+utduqKZn4y9PfrbrZZflYk/DthzLClTuJlV4CgsFUDK5sZZ0hSe83+1GWdIjO1ZoEZkaRynEevpoPqcOprA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=YsIxW6Pw; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::835; helo=mail-qt1-x835.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org) smtp.mailfrom=paul-moore.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=YsIxW6Pw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=paul-moore.com (client-ip=2607:f8b0:4864:20::835; helo=mail-qt1-x835.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZT1P4VQMz2xb3
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Mar 2026 08:36:25 +1100 (AEDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-509006c070eso44767821cf.0
        for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 14:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1773696983; x=1774301783; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yZTER0ejJMHI8vN1WrhfquHMJBWsRpf8IPY3C8XWv6w=;
        b=YsIxW6Pwz8tNuf0Ufnc00kEvkTSHaAG0zMbWW//ow86YjiYclpy6JeTv5DxlApnqL0
         SojmllnWCzEKpHB9KhVWwrzdEsg9fxOJ2fKLMR86bHwKKhjiDM0TPPuFtDJUwofbGItL
         qncmQ7OcOy8reetnzY+Sd9hQgQd0XAJZfi2znhATMPwNOII+Lhoi8c/IXQz2XxjCmmMm
         HMfsCGGuTzxCdNCcFVrHlXNxS3DBZCu2gx7wTk3NOt2UU/4Mqr36bueALdqKPSEFcwWV
         wq8NFiaXhgt9hYIiPnlmJcUu+vQCG0JVzEMgg3PQrIxQ+9P1IKKh6wAKhguwEA/vYUGM
         VLrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773696983; x=1774301783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yZTER0ejJMHI8vN1WrhfquHMJBWsRpf8IPY3C8XWv6w=;
        b=Wov6Fp8TAcMe7jSEk/zlPuct6GNQ4SChdKol/idzxEvr18M0xsLxo/EBSaK/ifbI+6
         KyWsUB+AEbsqzbT/rKWoXT0wYT5IDI98CNByjhonenQ2J7+lxNfYv7rZ8u7hdwoei00p
         Ir14MmSh0NqhFu3Xa4WHN2kRv8Z/EAaw+CRHOkCcjXzFCFD39OugnBpXBeVF1Vm+ksVC
         nnuw7PrNS3Vr2jtprWOZtJECO6wlUNWmqgDO6EZ2zM5+4goY+txnnXeiDxi9KNtT289/
         P6ZKrBm94zdLtzUIu3qFrbkhmHYd7cxfz53h9BYeuv8eCHrpLLX/1Imx8OL0BFPrzNEs
         c1eA==
X-Forwarded-Encrypted: i=1; AJvYcCV8PMwOsUw2B3FVOY0Pi1MSggROYeQSigFtnXs3rMldHs3u826+5pf0ovL1KcPipkIg1cQ64lN6xSvAcQ==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzpqhvrhPQ2HkXvkiqxkgACDGcUrNh2tpBcu9yc4+t383KXqhyC
	UsrCEaL8vONXqjS++rND/B/3GC+ip4WYWQx29PXWDKiJzR6MCQv0e6ZDuWyf34C7ZQ==
X-Gm-Gg: ATEYQzy3daf0CSRG/fEP3T0xk5DhjctN4DiCAMwNnvriknyylbpKlkNBfBMtfiRZWa9
	KrO/8qqwOvETp5igMDtjPYMJt1pXhiCoGZqSLWd8FefdmK7DEODpEALxiZFsruwBrqbjB1L0jBg
	Vm86IgFcN8Gv80L9rrL+QX+pjoaB/CrCWGjR501+JryiOqMElDtLlNKatASAe7PIXqy4C5DM6vl
	w6CMoM2zrWnx2cPsnCovU9RpAGapd073f4pt+eatK2bXC6x4iDK8JYIXa7d1K6UYoYyhh0r86nz
	nELk5k13WNJfKNaQKScwweItZmbq8bdYG76Nvj3lfqE/w00LQgMVORcsMASVEZ+vW/ZS2NgMZ7h
	LJbA5Lw0T2nygfvCifrcYMYdKL9KILF0jdc4soHWxR3yWhx1PsOvlljzZfzKCiJ4k8lB7BtM8Zf
	VNg0uQRvQPEDB3AiBVSiAlUN2q+ZOmEr0vnplnj/2Mop2VetjBk37BDKYx4QomvwOQ0QK57v7J1
	ED4+oM=
X-Received: by 2002:a05:622a:1346:b0:509:348f:bc0e with SMTP id d75a77b69052e-50957e5d6d8mr198612561cf.69.1773696982805;
        Mon, 16 Mar 2026 14:36:22 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50939ec63d6sm150988431cf.12.2026.03.16.14.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 14:36:21 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-erofs@lists.ozlabs.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	Gao Xiang <xiang@kernel.org>
Subject: [PATCH 1/3] backing_file: store user_path_file
Date: Mon, 16 Mar 2026 17:35:56 -0400
Message-ID: <20260316213606.374109-6-paul@paul-moore.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316213606.374109-5-paul@paul-moore.com>
References: <20260316213606.374109-5-paul@paul-moore.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=13336; i=paul@paul-moore.com; h=from:subject; bh=NGdpwf6jjNG1m9nIOap17SBd8DdIeebZ7C6CkE/q3I4=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBpuHfGxXiwIgWzzGyed0c2IzlCCSu6jvx75gPuG 28x0EzIk2mJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCabh3xgAKCRDqIPLalzeJ c2/sD/9vhv7kQW6uHbgaYmRVbFNSaPBfuDtecqWCJ/vuXkb/0O0kCgsOdyca+hLmtUiaNr5tgfh ydgYtFzhZcIQmd63SzGkZgKT9pJqoMdxXtMmbwKur8Ax50SNSDMWyVzYspnn6dlROlgrUcZKWEY zt1RX29uhgODLKO5q6GjhcWqnWu1NYhODhgJzBjtXLPb4vNNX33qvavhhdaS0BbcQEhptS/GfbZ cC1I+x+d7s807xfO8k5IGgacZKZ46Fm5lksTvCc2YQgG6f0HinuRZ3AF7YI934+FFUrf30uEedn Fmav+QtdZPB2ch7xPo7CVq/0Vd5dZB4Erl15f5DoAve+7TsysVkpAD/HJPvnqof3i9xGVub5ge7 fm0I3XS8RH5b2oOwh/bBAbq6Y6Odl2gmo2O+qp2kWRQrQSshsA49GwECzkMnzYnvdTOB4cG0tud fBAtFwQUhJtkYDz9gJYcPUFCIQejmesSjqC+O/Y4R+BYsOV3L4SuD8Ox9t5w3+ZFb5QoVytbco0 1/LkK6kseVZ+hzT80mWdiI2tk+xUD5V2UyKhR+TZ4XYoDd0t5QEKQ1lAlCsN02i5ehJjmYys1px yZX6kAQLa8/ZkxQ5B8AFZIMUMcqK5RJIGShA9ee6SN3Xf+MFV2ingztRHHy5/dSnQ24+i5ba3TS B7/xt2WprlNyrsQ==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.70 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2767-lists,linux-erofs=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[paul@paul-moore.com,linux-erofs@lists.ozlabs.org];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS(0.00)[m:linux-security-module@vger.kernel.org,m:selinux@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-unionfs@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:amir73il@gmail.com,m:xiang@kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 6336C2A106B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Amir Goldstein <amir73il@gmail.com>

Instead of storing the user_path, store an O_PATH file for the
user_path with the original user file creds and a security context.

The user_path_file is only exported as a const pointer and its refcnt
is initialized to FILE_REF_DEAD, because it is not a refcounted object.

The only caller of file_ref_init() is now open coded, so the helper
is removed.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Tested-by: Paul Moore <paul@paul-moore.com> (SELinux)
Acked-by: Gao Xiang <hsiangkao@linux.alibaba.com> (EROFS)
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 fs/backing-file.c            | 20 ++++++++------
 fs/erofs/ishare.c            |  6 ++--
 fs/file_table.c              | 53 ++++++++++++++++++++++++++++--------
 fs/fuse/passthrough.c        |  3 +-
 fs/internal.h                |  5 ++--
 fs/overlayfs/dir.c           |  3 +-
 fs/overlayfs/file.c          |  1 +
 include/linux/backing-file.h | 29 ++++++++++++++++++--
 include/linux/file_ref.h     | 10 -------
 9 files changed, 90 insertions(+), 40 deletions(-)

diff --git a/fs/backing-file.c b/fs/backing-file.c
index 45da8600d564..acabeea7efff 100644
--- a/fs/backing-file.c
+++ b/fs/backing-file.c
@@ -11,6 +11,7 @@
 #include <linux/fs.h>
 #include <linux/backing-file.h>
 #include <linux/splice.h>
+#include <linux/uio.h>
 #include <linux/mm.h>
 
 #include "internal.h"
@@ -18,9 +19,10 @@
 /**
  * backing_file_open - open a backing file for kernel internal use
  * @user_path:	path that the user reuqested to open
+ * @user_cred:	credentials that the user used for open
  * @flags:	open flags
  * @real_path:	path of the backing file
- * @cred:	credentials for open
+ * @cred:	credentials for open of the backing file
  *
  * Open a backing file for a stackable filesystem (e.g., overlayfs).
  * @user_path may be on the stackable filesystem and @real_path on the
@@ -29,19 +31,19 @@
  * returned file into a container structure that also stores the stacked
  * file's path, which can be retrieved using backing_file_user_path().
  */
-struct file *backing_file_open(const struct path *user_path, int flags,
+struct file *backing_file_open(const struct path *user_path,
+			       const struct cred *user_cred, int flags,
 			       const struct path *real_path,
 			       const struct cred *cred)
 {
 	struct file *f;
 	int error;
 
-	f = alloc_empty_backing_file(flags, cred);
+	f = alloc_empty_backing_file(flags, cred, user_cred);
 	if (IS_ERR(f))
 		return f;
 
-	path_get(user_path);
-	backing_file_set_user_path(f, user_path);
+	backing_file_open_user_path(f, user_path);
 	error = vfs_open(real_path, f);
 	if (error) {
 		fput(f);
@@ -52,7 +54,8 @@ struct file *backing_file_open(const struct path *user_path, int flags,
 }
 EXPORT_SYMBOL_GPL(backing_file_open);
 
-struct file *backing_tmpfile_open(const struct path *user_path, int flags,
+struct file *backing_tmpfile_open(const struct path *user_path,
+				  const struct cred *user_cred, int flags,
 				  const struct path *real_parentpath,
 				  umode_t mode, const struct cred *cred)
 {
@@ -60,12 +63,11 @@ struct file *backing_tmpfile_open(const struct path *user_path, int flags,
 	struct file *f;
 	int error;
 
-	f = alloc_empty_backing_file(flags, cred);
+	f = alloc_empty_backing_file(flags, cred, user_cred);
 	if (IS_ERR(f))
 		return f;
 
-	path_get(user_path);
-	backing_file_set_user_path(f, user_path);
+	backing_file_open_user_path(f, user_path);
 	error = vfs_tmpfile(real_idmap, real_parentpath, f, mode);
 	if (error) {
 		fput(f);
diff --git a/fs/erofs/ishare.c b/fs/erofs/ishare.c
index 829d50d5c717..17a4941d4518 100644
--- a/fs/erofs/ishare.c
+++ b/fs/erofs/ishare.c
@@ -106,15 +106,15 @@ static int erofs_ishare_file_open(struct inode *inode, struct file *file)
 
 	if (file->f_flags & O_DIRECT)
 		return -EINVAL;
-	realfile = alloc_empty_backing_file(O_RDONLY|O_NOATIME, current_cred());
+	realfile = alloc_empty_backing_file(O_RDONLY|O_NOATIME, current_cred(),
+					    file->f_cred);
 	if (IS_ERR(realfile))
 		return PTR_ERR(realfile);
 	ihold(sharedinode);
 	realfile->f_op = &erofs_file_fops;
 	realfile->f_inode = sharedinode;
 	realfile->f_mapping = sharedinode->i_mapping;
-	path_get(&file->f_path);
-	backing_file_set_user_path(realfile, &file->f_path);
+	backing_file_open_user_path(realfile, &file->f_path);
 
 	file_ra_state_init(&realfile->f_ra, file->f_mapping);
 	realfile->private_data = EROFS_I(inode);
diff --git a/fs/file_table.c b/fs/file_table.c
index aaa5faaace1e..b7dc94656c44 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -27,6 +27,7 @@
 #include <linux/task_work.h>
 #include <linux/swap.h>
 #include <linux/kmemleak.h>
+#include <linux/backing-file.h>
 
 #include <linux/atomic.h>
 
@@ -43,11 +44,11 @@ static struct kmem_cache *bfilp_cachep __ro_after_init;
 
 static struct percpu_counter nr_files __cacheline_aligned_in_smp;
 
-/* Container for backing file with optional user path */
+/* Container for backing file with optional user path file */
 struct backing_file {
 	struct file file;
 	union {
-		struct path user_path;
+		struct file user_path_file;
 		freeptr_t bf_freeptr;
 	};
 };
@@ -56,24 +57,44 @@ struct backing_file {
 
 const struct path *backing_file_user_path(const struct file *f)
 {
-	return &backing_file(f)->user_path;
+	return &backing_file(f)->user_path_file.f_path;
 }
 EXPORT_SYMBOL_GPL(backing_file_user_path);
 
-void backing_file_set_user_path(struct file *f, const struct path *path)
+const struct file *backing_file_user_path_file(const struct file *f)
 {
-	backing_file(f)->user_path = *path;
+	return &backing_file(f)->user_path_file;
+}
+EXPORT_SYMBOL_GPL(backing_file_user_path_file);
+
+void backing_file_open_user_path(struct file *f, const struct path *path)
+{
+	/* open an O_PATH file to reference the user path - cannot fail */
+	WARN_ON(vfs_open(path, &backing_file(f)->user_path_file));
+}
+EXPORT_SYMBOL_GPL(backing_file_open_user_path);
+
+static void destroy_file(struct file *f)
+{
+	security_file_free(f);
+	put_cred(f->f_cred);
 }
-EXPORT_SYMBOL_GPL(backing_file_set_user_path);
 
 static inline void file_free(struct file *f)
 {
-	security_file_free(f);
+	destroy_file(f);
 	if (likely(!(f->f_mode & FMODE_NOACCOUNT)))
 		percpu_counter_dec(&nr_files);
-	put_cred(f->f_cred);
 	if (unlikely(f->f_mode & FMODE_BACKING)) {
-		path_put(backing_file_user_path(f));
+		struct file *user_path_file = &backing_file(f)->user_path_file;
+
+		/*
+		 * no refcount on the user_path_file - they die together,
+		 * so __fput() is not called for user_path_file. path_put()
+		 * is the only relevant cleanup from __fput().
+		 */
+		destroy_file(user_path_file);
+		path_put(&user_path_file->__f_path);
 		kmem_cache_free(bfilp_cachep, backing_file(f));
 	} else {
 		kmem_cache_free(filp_cachep, f);
@@ -201,7 +222,7 @@ static int init_file(struct file *f, int flags, const struct cred *cred)
 	 * fget-rcu pattern users need to be able to handle spurious
 	 * refcount bumps we should reinitialize the reused file first.
 	 */
-	file_ref_init(&f->f_ref, 1);
+	atomic_long_set(&f->f_ref.refcnt, FILE_REF_ONEREF);
 	return 0;
 }
 
@@ -290,7 +311,8 @@ struct file *alloc_empty_file_noaccount(int flags, const struct cred *cred)
  * This is only for kernel internal use, and the allocate file must not be
  * installed into file tables or such.
  */
-struct file *alloc_empty_backing_file(int flags, const struct cred *cred)
+struct file *alloc_empty_backing_file(int flags, const struct cred *cred,
+				      const struct cred *user_cred)
 {
 	struct backing_file *ff;
 	int error;
@@ -305,6 +327,15 @@ struct file *alloc_empty_backing_file(int flags, const struct cred *cred)
 		return ERR_PTR(error);
 	}
 
+	error = init_file(&ff->user_path_file, O_PATH, user_cred);
+	/* user_path_file is not refcounterd - it dies with the backing file */
+	atomic_long_set(&ff->user_path_file.f_ref.refcnt, FILE_REF_DEAD);
+	if (unlikely(error)) {
+		destroy_file(&ff->file);
+		kmem_cache_free(bfilp_cachep, ff);
+		return ERR_PTR(error);
+	}
+
 	ff->file.f_mode |= FMODE_BACKING | FMODE_NOACCOUNT;
 	return &ff->file;
 }
diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
index 72de97c03d0e..60018c635934 100644
--- a/fs/fuse/passthrough.c
+++ b/fs/fuse/passthrough.c
@@ -10,6 +10,7 @@
 #include <linux/file.h>
 #include <linux/backing-file.h>
 #include <linux/splice.h>
+#include <linux/uio.h>
 
 static void fuse_file_accessed(struct file *file)
 {
@@ -167,7 +168,7 @@ struct fuse_backing *fuse_passthrough_open(struct file *file, int backing_id)
 		goto out;
 
 	/* Allocate backing file per fuse file to store fuse path */
-	backing_file = backing_file_open(&file->f_path, file->f_flags,
+	backing_file = backing_file_open(&file->f_path, file->f_cred, file->f_flags,
 					 &fb->file->f_path, fb->cred);
 	err = PTR_ERR(backing_file);
 	if (IS_ERR(backing_file)) {
diff --git a/fs/internal.h b/fs/internal.h
index cbc384a1aa09..cc6f1e251f5a 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -106,8 +106,9 @@ extern void chroot_fs_refs(const struct path *, const struct path *);
  */
 struct file *alloc_empty_file(int flags, const struct cred *cred);
 struct file *alloc_empty_file_noaccount(int flags, const struct cred *cred);
-struct file *alloc_empty_backing_file(int flags, const struct cred *cred);
-void backing_file_set_user_path(struct file *f, const struct path *path);
+struct file *alloc_empty_backing_file(int flags, const struct cred *cred,
+				      const struct cred *user_cred);
+void backing_file_open_user_path(struct file *f, const struct path *path);
 
 static inline void file_put_write_access(struct file *file)
 {
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index ff3dbd1ca61f..5914b5cf25e3 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -1374,7 +1374,8 @@ static int ovl_create_tmpfile(struct file *file, struct dentry *dentry,
 				return PTR_ERR(cred);
 
 			ovl_path_upper(dentry->d_parent, &realparentpath);
-			realfile = backing_tmpfile_open(&file->f_path, flags, &realparentpath,
+			realfile = backing_tmpfile_open(&file->f_path, file->f_cred,
+							flags, &realparentpath,
 							mode, current_cred());
 			err = PTR_ERR_OR_ZERO(realfile);
 			pr_debug("tmpfile/open(%pd2, 0%o) = %i\n", realparentpath.dentry, mode, err);
diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 97bed2286030..767c128407fc 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -49,6 +49,7 @@ static struct file *ovl_open_realfile(const struct file *file,
 				flags &= ~O_NOATIME;
 
 			realfile = backing_file_open(file_user_path(file),
+						     file_user_cred(file),
 						     flags, realpath, current_cred());
 		}
 	}
diff --git a/include/linux/backing-file.h b/include/linux/backing-file.h
index 1476a6ed1bfd..8afba93f3ce0 100644
--- a/include/linux/backing-file.h
+++ b/include/linux/backing-file.h
@@ -9,19 +9,42 @@
 #define _LINUX_BACKING_FILE_H
 
 #include <linux/file.h>
-#include <linux/uio.h>
 #include <linux/fs.h>
 
+/*
+ * When mmapping a file on a stackable filesystem (e.g., overlayfs), the file
+ * stored in ->vm_file is a backing file whose f_inode is on the underlying
+ * filesystem.
+ *
+ * LSM can use file_user_path_file() to store context related to the user path
+ * that was opened and mmaped.
+ */
+const struct file *backing_file_user_path_file(const struct file *f);
+
+static inline const struct file *file_user_path_file(const struct file *f)
+{
+	if (f && unlikely(f->f_mode & FMODE_BACKING))
+		return backing_file_user_path_file(f);
+	return f;
+}
+
+static inline const struct cred *file_user_cred(const struct file *f)
+{
+	return file_user_path_file(f)->f_cred;
+}
+
 struct backing_file_ctx {
 	const struct cred *cred;
 	void (*accessed)(struct file *file);
 	void (*end_write)(struct kiocb *iocb, ssize_t);
 };
 
-struct file *backing_file_open(const struct path *user_path, int flags,
+struct file *backing_file_open(const struct path *user_path,
+			       const struct cred *user_cred, int flags,
 			       const struct path *real_path,
 			       const struct cred *cred);
-struct file *backing_tmpfile_open(const struct path *user_path, int flags,
+struct file *backing_tmpfile_open(const struct path *user_path,
+				  const struct cred *user_cred, int flags,
 				  const struct path *real_parentpath,
 				  umode_t mode, const struct cred *cred);
 ssize_t backing_file_read_iter(struct file *file, struct iov_iter *iter,
diff --git a/include/linux/file_ref.h b/include/linux/file_ref.h
index 31551e4cb8f3..fdaacbcbdb5b 100644
--- a/include/linux/file_ref.h
+++ b/include/linux/file_ref.h
@@ -51,16 +51,6 @@ typedef struct {
 #endif
 } file_ref_t;
 
-/**
- * file_ref_init - Initialize a file reference count
- * @ref: Pointer to the reference count
- * @cnt: The initial reference count typically '1'
- */
-static inline void file_ref_init(file_ref_t *ref, unsigned long cnt)
-{
-	atomic_long_set(&ref->refcnt, cnt - 1);
-}
-
 bool __file_ref_put(file_ref_t *ref, unsigned long cnt);
 
 /**
-- 
2.53.0


