Return-Path: <linux-erofs+bounces-2831-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KNGFeukummaaAIAu9opvQ
	(envelope-from <linux-erofs+bounces-2831-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Mar 2026 14:13:15 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E322BC01A
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Mar 2026 14:13:13 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fbTln0xTRz2yjV;
	Thu, 19 Mar 2026 00:13:09 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::635"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773839589;
	cv=none; b=AyDJBmCBybqJ/bQ8AcOqKE7c7CuqnB5mu7OXHG2BckChHCuwCaReHHpwV4gjOEw/mGmnY9H9h1viQ47a0KQFGNkbhL15N3xeFfJTQDbGV14qbw5z8Ma+23/12CgqqN6KlP88oVffkLwaQiaGPwS3YV4elvT7TPRCm4XF2eCy8mjW9o3Z9Yj1JWlsbl3Y4hDDHS7BEfNs9DavDlenmDqf3BjHO1KHzz4yEQslr5wMDwDFXArlomhNkz6591b0Kp/isXIgqBrnE0zhba1H/oM7ePNTdbMxzBiCtgpWFN5l4S2T7OSEO0A35twEb/4if5TtHarmiCS7mC4qla0njM2TUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773839589; c=relaxed/relaxed;
	bh=b/7hSXXq5I5tQDMuUzkqP7+YK2PRj0uGUtwNTKJSrfA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mk+TuUfXZ/RseCsucCuKs1PEQrJ7fpamL68NDEcb6hZsmjeAfij8/nU+FZ3NfF0Af73ScElDL40J62m1ZuG8enoU1uBs14yKNEp27q+NdmHx1MXXyyk0b4TDv7k5xxom3iRbHC1CuaU0pE9n3KNMQyefxDMCXiJqbqjqDDjudYOTxqdIe4+X/t+mWAWVM7pFBhTbFzvl50Z+knG5lgAMM2IKvy7Mm9h22U+cP4jikq920Eb0tN5/8rPkH/bWo9ZENiVYhpyuN+8ZRXiKE594TNLOTbAec1BeUnVEDcfmwlxphcrQnHo4fzpPMr3tzDaiMRCY+3zhQogt/dw0cYjqDw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=gnbxiuCy; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::635; helo=mail-ej1-x635.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=gnbxiuCy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::635; helo=mail-ej1-x635.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fbTll1FSVz2yTH
	for <linux-erofs@lists.ozlabs.org>; Thu, 19 Mar 2026 00:13:05 +1100 (AEDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-b980785a0bfso63305466b.3
        for <linux-erofs@lists.ozlabs.org>; Wed, 18 Mar 2026 06:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773839581; x=1774444381; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b/7hSXXq5I5tQDMuUzkqP7+YK2PRj0uGUtwNTKJSrfA=;
        b=gnbxiuCy+355qan73IXp2HYkTgku2I3m04mISdJxkt+ZEkLaPLUej7kWQ3mCSzkxS9
         EnaFZF2YKluEBiPNib7t/xS8vf6L0LGMIJzoDVc8xsh9gC5ulrw3HDzvqNEr+bGUuqIi
         yOV1Y4h4MCX5KkUKzvwjM3N9YedKiRsOLXrYP36GMwiiucpHMOJ7IqqC196GwXXbOC2l
         u+YqAayY+PX9RuRG4sa9bNpts8Qb9gc92sir593e3RCiuC51SIy5kUR+eZyzAK/ABM/J
         EfOCuXmCMOjqzn7tacfE+VUKdQTFmHjfELemuvXu6zeh1eKkU97AiZK82Fa4grNb1Z5X
         hE9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773839581; x=1774444381;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b/7hSXXq5I5tQDMuUzkqP7+YK2PRj0uGUtwNTKJSrfA=;
        b=tEyQsr3cfvVkTcagap3bkb5UREx6i9w4OMEzk1RFPvx92uXqdIsNkNpFZpvzFvWJHg
         U4/EoJxMQ+1420X+3pOH8GUAodvVPXSSkavtltSHB/0yq7VnXXL+dn8qUQ4YbrYVSqzy
         6QAJmGn3hDUxVAdeVYH8OpU4NzxUdtsjwtrhWOlv02yHUjbXOwceTlxhovcMgNCDhMpT
         fRSp+oNcNwVunY4IuQKcbApWskdS7WNomnvhnVq6h1sf5gIcbA5K99SSsbZcfeds65Vo
         +14OT3bKCOFYmPug2nBY5VKrJzovispmeufWfIvZI9Jx6xgBebzL6rlP1kS6G9pjhQgN
         aYOg==
X-Forwarded-Encrypted: i=1; AJvYcCXbyTgEGrm8D7Y6SQ3bTXEjU9wb5g+tflsFy7xi3R/JlutYS48BekSp3dnCvHe9vturD1mrXV9km+VMKQ==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz1xfFs73RBUA6tEAeOIioufP30Gm+GWdt1Ar6vxLYTErCEq0C9
	HICD8R3/RXXMazJ8JjMopYouqqckv74vJfjCS5JlPVlKiT1BXKUC+0nj
X-Gm-Gg: ATEYQzzggJSL0lfc6FsFR7NpSsi3+/tSqR9NeVMnecagUGK9jnyPIo2JsW0nVscMAlF
	RjAOmembbn5hB8IaCK5zUb7TIEvh8JAtwd5Ay/P+SFUdU8XeYGGgzBhDNJ1Ba/nRmdtTQ0ivPOE
	Ex3/U2mj0KmCjEVopcPRlldfo9XdPOKQR+Osg9aB4+Yv+n2tjGa7CiyLaKFhU26k1IPbGlHGQgU
	8Q2F75ipmuowUI0hPdFfoBCqJ8FfxUKBFWvAaoXi4HtAi2wv+ixefdRsoSl1H1lv34gVtyLYmDX
	vdQSoq9PVnuNjz9E93gI3EiNup0LFbITplZTSDmhJHmfKngC+6TH5SzcuuaOTm3/ZSsVgGNNJD8
	lFFIFmesF4GWRf8SyzxMldaxjFnomGvsrFGk8hH1bZEUTC25AP4T3FDMWrtZkHappgH703ivohd
	pbdUu5D3i/ejDORNYkOA43/JoYpFUnZmjHrscUHKcDRRV3YirklJwjPqLgkaq18u78KNP+QSIay
	VlR4MaCHNtkD8cJIVFhXQg2C7M=
X-Received: by 2002:a17:907:3d52:b0:b97:698d:1e with SMTP id a640c23a62f3a-b97f4971d9dmr181381766b.35.1773839580063;
        Wed, 18 Mar 2026 06:13:00 -0700 (PDT)
Received: from localhost (2001-1c00-570d-ee00-0520-bd43-ec36-d135.cable.dynamic.v6.ziggo.nl. [2001:1c00:570d:ee00:520:bd43:ec36:d135])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b97f16d3380sm216163566b.42.2026.03.18.06.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 06:12:59 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Paul Moore <paul@paul-moore.com>,
	Gao Xiang <xiang@kernel.org>,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: [PATCH v6] backing_file: store user_path_file
Date: Wed, 18 Mar 2026 14:12:58 +0100
Message-ID: <20260318131258.1457101-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.53.0
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
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.70 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2831-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:brauner@kernel.org,m:miklos@szeredi.hu,m:paul@paul-moore.com,m:xiang@kernel.org,m:linux-security-module@vger.kernel.org,m:selinux@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-fsdevel@vger.kernel.org,m:linux-unionfs@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[amir73il@gmail.com,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 98E322BC01A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Instead of storing the user_path, store an O_PATH file for the
user_path with the original user file creds and a security context.

The user_path_file is only exported as a const pointer and its refcnt
is initialized to FILE_REF_DEAD, because it is not a refcounted object.

The file_ref_init() helper was changed to accept the FILE_REF_ constant
instead of the fake +1 integer count.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Christian,

My v5 patch was sent by Paul along with his LSM/selinux pataches [1].
Here are the changes you requested.

I removed the ACKs and Tested-by because of the changes.

Thanks,
Amir.

Changes since v5:
- Restore file_ref_init() helper without refcnt -1 offset
- Future proofing errors from backing_file_open_user_path()

[1] https://lore.kernel.org/r/20260316213606.374109-6-paul@paul-moore.com/

 fs/backing-file.c            | 26 ++++++++++--------
 fs/erofs/ishare.c            | 13 +++++++--
 fs/file_table.c              | 53 ++++++++++++++++++++++++++++--------
 fs/fuse/passthrough.c        |  3 +-
 fs/internal.h                |  5 ++--
 fs/overlayfs/dir.c           |  3 +-
 fs/overlayfs/file.c          |  1 +
 include/linux/backing-file.h | 29 ++++++++++++++++++--
 include/linux/file_ref.h     |  4 +--
 9 files changed, 103 insertions(+), 34 deletions(-)

diff --git a/fs/backing-file.c b/fs/backing-file.c
index 45da8600d5644..271ff27521063 100644
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
@@ -29,20 +31,21 @@
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
-	error = vfs_open(real_path, f);
+	error = backing_file_open_user_path(f, user_path);
+	if (!error)
+		error = vfs_open(real_path, f);
 	if (error) {
 		fput(f);
 		f = ERR_PTR(error);
@@ -52,7 +55,8 @@ struct file *backing_file_open(const struct path *user_path, int flags,
 }
 EXPORT_SYMBOL_GPL(backing_file_open);
 
-struct file *backing_tmpfile_open(const struct path *user_path, int flags,
+struct file *backing_tmpfile_open(const struct path *user_path,
+				  const struct cred *user_cred, int flags,
 				  const struct path *real_parentpath,
 				  umode_t mode, const struct cred *cred)
 {
@@ -60,13 +64,13 @@ struct file *backing_tmpfile_open(const struct path *user_path, int flags,
 	struct file *f;
 	int error;
 
-	f = alloc_empty_backing_file(flags, cred);
+	f = alloc_empty_backing_file(flags, cred, user_cred);
 	if (IS_ERR(f))
 		return f;
 
-	path_get(user_path);
-	backing_file_set_user_path(f, user_path);
-	error = vfs_tmpfile(real_idmap, real_parentpath, f, mode);
+	error = backing_file_open_user_path(f, user_path);
+	if (!error)
+		error = vfs_tmpfile(real_idmap, real_parentpath, f, mode);
 	if (error) {
 		fput(f);
 		f = ERR_PTR(error);
diff --git a/fs/erofs/ishare.c b/fs/erofs/ishare.c
index 829d50d5c717d..f3a5fb0bffaf0 100644
--- a/fs/erofs/ishare.c
+++ b/fs/erofs/ishare.c
@@ -103,18 +103,25 @@ static int erofs_ishare_file_open(struct inode *inode, struct file *file)
 {
 	struct inode *sharedinode = EROFS_I(inode)->sharedinode;
 	struct file *realfile;
+	int err;
 
 	if (file->f_flags & O_DIRECT)
 		return -EINVAL;
-	realfile = alloc_empty_backing_file(O_RDONLY|O_NOATIME, current_cred());
+	realfile = alloc_empty_backing_file(O_RDONLY|O_NOATIME, current_cred(),
+					    file->f_cred);
 	if (IS_ERR(realfile))
 		return PTR_ERR(realfile);
+
+	err = backing_file_open_user_path(realfile, &file->f_path);
+	if (err) {
+		fput(realfile);
+		return err;
+	}
+
 	ihold(sharedinode);
 	realfile->f_op = &erofs_file_fops;
 	realfile->f_inode = sharedinode;
 	realfile->f_mapping = sharedinode->i_mapping;
-	path_get(&file->f_path);
-	backing_file_set_user_path(realfile, &file->f_path);
 
 	file_ra_state_init(&realfile->f_ra, file->f_mapping);
 	realfile->private_data = EROFS_I(inode);
diff --git a/fs/file_table.c b/fs/file_table.c
index aaa5faaace1e9..e8b4eb2bbff85 100644
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
 }
-EXPORT_SYMBOL_GPL(backing_file_set_user_path);
+EXPORT_SYMBOL_GPL(backing_file_user_path_file);
 
-static inline void file_free(struct file *f)
+int backing_file_open_user_path(struct file *f, const struct path *path)
+{
+	/* open an O_PATH file to reference the user path - should not fail */
+	return WARN_ON(vfs_open(path, &backing_file(f)->user_path_file));
+}
+EXPORT_SYMBOL_GPL(backing_file_open_user_path);
+
+static void destroy_file(struct file *f)
 {
 	security_file_free(f);
+	put_cred(f->f_cred);
+}
+
+static inline void file_free(struct file *f)
+{
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
+	file_ref_init(&f->f_ref, FILE_REF_ONEREF);
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
+	file_ref_init(&ff->user_path_file.f_ref, FILE_REF_DEAD);
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
index 72de97c03d0ee..60018c6359342 100644
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
index cbc384a1aa096..7c44a58627ba3 100644
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
+int backing_file_open_user_path(struct file *f, const struct path *path);
 
 static inline void file_put_write_access(struct file *file)
 {
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 8c0a3d876fef1..5fd32ccc134d2 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -1389,7 +1389,8 @@ static int ovl_create_tmpfile(struct file *file, struct dentry *dentry,
 				return PTR_ERR(cred);
 
 			ovl_path_upper(dentry->d_parent, &realparentpath);
-			realfile = backing_tmpfile_open(&file->f_path, flags, &realparentpath,
+			realfile = backing_tmpfile_open(&file->f_path, file->f_cred,
+							flags, &realparentpath,
 							mode, current_cred());
 			err = PTR_ERR_OR_ZERO(realfile);
 			pr_debug("tmpfile/open(%pd2, 0%o) = %i\n", realparentpath.dentry, mode, err);
diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 97bed2286030d..767c128407fcc 100644
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
index 1476a6ed1bfd7..8afba93f3ce07 100644
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
index 31551e4cb8f34..c7512ce70f9c4 100644
--- a/include/linux/file_ref.h
+++ b/include/linux/file_ref.h
@@ -54,11 +54,11 @@ typedef struct {
 /**
  * file_ref_init - Initialize a file reference count
  * @ref: Pointer to the reference count
- * @cnt: The initial reference count typically '1'
+ * @cnt: The initial reference count typically FILE_REF_ONEREF
  */
 static inline void file_ref_init(file_ref_t *ref, unsigned long cnt)
 {
-	atomic_long_set(&ref->refcnt, cnt - 1);
+	atomic_long_set(&ref->refcnt, cnt);
 }
 
 bool __file_ref_put(file_ref_t *ref, unsigned long cnt);
-- 
2.53.0


