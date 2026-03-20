Return-Path: <linux-erofs+bounces-2884-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCfvCFxRvWlr8gIAu9opvQ
	(envelope-from <linux-erofs+bounces-2884-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Mar 2026 14:53:32 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D892DB635
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Mar 2026 14:53:31 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fckYN3cGFz2yYY;
	Sat, 21 Mar 2026 00:53:28 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::62f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774014808;
	cv=none; b=SVpcoasp9gcI5oprCbhMIt9bjED+McAvqkKpHYiqsco1/gAVSBwFrZsE6APiIQo+3fHDHxq8cL29PtWoDLCKrcDLdlNWK+e1AHbvIqaLRl02w6qNzQ1pCOyuvg7OpSQUAWRoQa3htA0e51q3yAECVxJjmkf1L3VP+iHNv7J/jlhIVO6MrZywtT9daTtGxwQctvTZLSGBgICLpqVICSy2Z1Kok7ruTQQGIH8gOUNQSRE/gBEyB2Hq6+Xdb60LR5kB4gUoM8xM7mo4oq+sUqngijBMCj/L6L2GoLt5Rj7RfYT/0jv4h0KREODLAwvXidElIcEFEUA8mSbptExmtKDSEA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774014808; c=relaxed/relaxed;
	bh=+Pm+eEQ60JIMUuvkrTDt/cbZSgeK8toOkUpeH6Q+x4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VUHjRIylEbV+/+wL+nsl6YbirE/Hhf3cZur0Pe4Iy1DWzvNJ+XD1k8jnBR2NtnW0GVOqurH4ANU2fiNuLKuI8EUZ7IlrfH/2zpPCJGLz8p5yDKdvvX7O/Q/Tb2U/dSJHC+M8ODZFO7K7wqs9gft54IggtfzOlHFZVjrx7Mu5o3bxczCr8MVK+0hJ4HtITkaMGNfaQeuLl2BdkdWsvFxhi6L9VFo/61cSBXes9snW+ZYZuqY3+DzzljZSvDXaDOivZMCM2shxBiqB6Am76TDjyshcj5ZxP8l8NvQ6nDVTCJEj68bR/BRW8ZNS5NcdyEeQkuYxBPq5kwCl/Hc6WLMTSA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=f09sJ0xM; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::62f; helo=mail-ej1-x62f.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=f09sJ0xM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::62f; helo=mail-ej1-x62f.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fckYL2Cysz2yY1
	for <linux-erofs@lists.ozlabs.org>; Sat, 21 Mar 2026 00:53:25 +1100 (AEDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-b976536806cso309307666b.0
        for <linux-erofs@lists.ozlabs.org>; Fri, 20 Mar 2026 06:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774014797; x=1774619597; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+Pm+eEQ60JIMUuvkrTDt/cbZSgeK8toOkUpeH6Q+x4Q=;
        b=f09sJ0xMpUydEIq/IDew5c88LR2jtRATbTSJmkmK6XE7L8y9Jwp2j8f/fQG08zCH/q
         bzDhTkWbcpMjCw+g8cAmYVPqnQ6knYrpUCYEqlKbKUs0zY/hX0aqIQjnxkjFfOn2T0Y2
         5U38KcUQBlomJJ4J0KcNu/Z+FxhRcZ5bEUqktBYkNT0lpX2lfBXzItck7/FVa8Hhg2Lt
         RbFg9y2YXTX1ozyc1mAQsgsWv+8Kn6hvnVsyFK8mKqtj3PBQrrsVMgr8Ik0OyLyyb6Bn
         nJhZHyS5SLhTV7atRMYPjwp9YiJtKZfYTH1u/LBP5WzVjhKT16DSn248outAh2m8blT1
         VC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774014797; x=1774619597;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Pm+eEQ60JIMUuvkrTDt/cbZSgeK8toOkUpeH6Q+x4Q=;
        b=p2Ooh2x7wDxy4k9UrlnRInsqbXgKVZdyN5wbFNAzOY/j7Kwe9jOduiIRiBTyxPaXDb
         gNs6Ucxzsbz9pCRLa0gYkPJtru44q+uRMO/MYDzH8CIbXbLGV5SYqXCqSy7w3TPmeucO
         JVeBUo1XutVhBRbDihtOc8nTxNTDYX19qgrpS+fc1x0+fL3n3UgPbCWKvdgEcXN0ZjS2
         lHKBr/1ben9RabnRvBUHdXF6cu7BmxlpPqYucTWUKnNlyneU3/ZBQROD1ejrHgbwXdW8
         ien+5b5yyyoNNc9AklL6sDWrD4Rw3a9cdT7GGoHYwLnkDXE/XRmGDJQLZDGCf5LavcpE
         i0vw==
X-Forwarded-Encrypted: i=1; AJvYcCXpDkTkUMHlSelYNZKziks7RxBwO9pxT60csa1Xl9My7Wddjs27p2vpTjjuL8+NRo7zjslp9p93mss/Vg==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyctV2J+5FX5M3LqInHMQAPtMzbXoUFNERdr9nViM5MrmTjOH31
	qjcsy0ExzmVe1t5WB5a+7r9N4m35m+/NuVGxVZqH5VNqy1BdNGzrwjY4
X-Gm-Gg: ATEYQzztVdk7PmIr8XKQGJfShGXllLT6EQ+x4jO5dGCMnijepn7GLnfnG8h/j41z7GP
	2ch8OAE7QUBxA2gwjRNvDx4qYYHcqMJj8Jfws/yCHy5MqtOxQNuIlBgIT4/kKfJ0Hlqfctiucfb
	iTyhMAblxeAZKLFzi8+kKPyD4SJoMoTV4KIaqcsI4unqY4sQQ018rW7gWHXRjSJPNBz/C2z8mVu
	ukXMqQjhgEOkw06DMDVUjmjsp1ChygRpBQOh5S9Ggu7TyEKVbOw82E6+aTMTbfykpNY1L9dz4sr
	bhWMyugw7E8Wkiy/b0iTCAmH5CKuifE5WcFxYI7Ir6S41/Z8YMRROgH2/3zEbcid84F+EnyTv1w
	R66hljcq5N2U9sL0vTsGSu4wnpQO4J4NlGRA+kDuV07TltN8Hbxx5iWkOZBuekR6V50yRY0RJuu
	+XvPu5D4Cv1VzhZxLEzsnPLCZMU9xaVCCq/2dP4ynsYdBm7X0q5i/rPhEWtyjWb+Md5+3NZE2cl
	0AG4mBaNfcZlG5bfAUcl3gGjuqY
X-Received: by 2002:a17:907:c70c:b0:b96:eb7e:bc55 with SMTP id a640c23a62f3a-b982f1edf01mr232203466b.10.1774014796546;
        Fri, 20 Mar 2026 06:53:16 -0700 (PDT)
Received: from localhost (2001-1c00-570d-ee00-e98d-b8f7-8d95-53b2.cable.dynamic.v6.ziggo.nl. [2001:1c00:570d:ee00:e98d:b8f7:8d95:53b2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b983365a159sm158826466b.44.2026.03.20.06.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 06:53:16 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Paul Moore <paul@paul-moore.com>,
	Gao Xiang <xiang@kernel.org>,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: [PATCH v7] backing_file: store an internal O_PATH user_path_file
Date: Fri, 20 Mar 2026 14:53:15 +0100
Message-ID: <20260320135315.1731572-1-amir73il@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2884-lists,linux-erofs=lfdr.de];
	FORGED_SENDER(0.00)[amir73il@gmail.com,linux-erofs@lists.ozlabs.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:brauner@kernel.org,m:viro@zeniv.linux.org.uk,m:miklos@szeredi.hu,m:paul@paul-moore.com,m:xiang@kernel.org,m:linux-security-module@vger.kernel.org,m:selinux@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-fsdevel@vger.kernel.org,m:linux-unionfs@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 28D892DB635
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Instead of storing the user_path, store an internal O_PATH file,
embedded in the backing_file struct for the user_path with a copy of
the original user file creds and with an independent a security context.

This internal O_PATH file is going to be used by LSM mprotect hooks
to check the permissions to mprotect against a copy of the original
mmaped file credentials.

The internal user_path_file is only exported as a const pointer and
its refcnt is initialized to FILE_REF_DEAD, because it is not an actual
refcounted object.  The file_ref_init() helper was changed to accept
the FILE_REF_ constant instead of the fake +1 integer count.

The internal O_PATH file is opened using a new kernel helper
kernel_path_file_open(), which skips all the generic code in
do_dentry_open() and does only the essentials, so that the internal
O_PATH file could be opened with a negative dentry.

This is needed for backing_tmpfile_open() to open a backing O_PATH
tmpfile before instantiating the dentry.
The callers of backing_tmpfile_open() are responsible for calling
backing_tmpfile_finish() after making the path positive.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Christian,

7th time is a charm (?).

Here is another try to introduce backing_file_user_path_file(),
after dealing with the the syzbot report [1] v6 [2] introduces.

Thanks,
Amir.

Changes since v6:
- Create helper for internal O_PATH open with negative path
- Create backing_tmpfile_finish() API to fixup the negative path

[1] https://syzkaller.appspot.com/bug?extid=f34aab278bf5d664e2be
[2] https://lore.kernel.org/linux-fsdevel/20260318131258.1457101-1-amir73il@gmail.com/

 fs/backing-file.c            | 32 +++++++++++-------
 fs/erofs/ishare.c            | 13 ++++++--
 fs/file_table.c              | 63 +++++++++++++++++++++++++++++-------
 fs/fuse/passthrough.c        |  3 +-
 fs/internal.h                | 12 +++++--
 fs/open.c                    | 34 ++++++++++++++++---
 fs/overlayfs/dir.c           |  5 ++-
 fs/overlayfs/file.c          |  1 +
 include/linux/backing-file.h | 30 +++++++++++++++--
 include/linux/file_ref.h     |  4 +--
 10 files changed, 159 insertions(+), 38 deletions(-)

diff --git a/fs/backing-file.c b/fs/backing-file.c
index 45da8600d5644..77935c93333ab 100644
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
@@ -75,6 +79,12 @@ struct file *backing_tmpfile_open(const struct path *user_path, int flags,
 }
 EXPORT_SYMBOL(backing_tmpfile_open);
 
+void backing_tmpfile_finish(struct file *file)
+{
+	backing_file_set_user_path_inode(file);
+}
+EXPORT_SYMBOL_GPL(backing_tmpfile_finish);
+
 struct backing_aio {
 	struct kiocb iocb;
 	refcount_t ref;
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
index aaa5faaace1e9..a4d1064d50896 100644
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
@@ -56,24 +57,54 @@ struct backing_file {
 
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
+	if (WARN_ON(!(f->f_mode & FMODE_BACKING)))
+		return -EIO;
+	kernel_path_file_open(&backing_file(f)->user_path_file, path);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(backing_file_open_user_path);
+
+void backing_file_set_user_path_inode(struct file *f)
+{
+	if (WARN_ON(!(f->f_mode & FMODE_BACKING)))
+		return;
+	file_set_d_inode(&backing_file(f)->user_path_file);
+}
+EXPORT_SYMBOL_GPL(backing_file_set_user_path_inode);
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
@@ -201,7 +232,7 @@ static int init_file(struct file *f, int flags, const struct cred *cred)
 	 * fget-rcu pattern users need to be able to handle spurious
 	 * refcount bumps we should reinitialize the reused file first.
 	 */
-	file_ref_init(&f->f_ref, 1);
+	file_ref_init(&f->f_ref, FILE_REF_ONEREF);
 	return 0;
 }
 
@@ -290,7 +321,8 @@ struct file *alloc_empty_file_noaccount(int flags, const struct cred *cred)
  * This is only for kernel internal use, and the allocate file must not be
  * installed into file tables or such.
  */
-struct file *alloc_empty_backing_file(int flags, const struct cred *cred)
+struct file *alloc_empty_backing_file(int flags, const struct cred *cred,
+				      const struct cred *user_cred)
 {
 	struct backing_file *ff;
 	int error;
@@ -305,6 +337,15 @@ struct file *alloc_empty_backing_file(int flags, const struct cred *cred)
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
index cbc384a1aa096..4a9e5e00678d9 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -106,8 +106,16 @@ extern void chroot_fs_refs(const struct path *, const struct path *);
  */
 struct file *alloc_empty_file(int flags, const struct cred *cred);
 struct file *alloc_empty_file_noaccount(int flags, const struct cred *cred);
-struct file *alloc_empty_backing_file(int flags, const struct cred *cred);
-void backing_file_set_user_path(struct file *f, const struct path *path);
+struct file *alloc_empty_backing_file(int flags, const struct cred *cred,
+				      const struct cred *user_cred);
+int backing_file_open_user_path(struct file *f, const struct path *path);
+void backing_file_set_user_path_inode(struct file *f);
+void kernel_path_file_open(struct file *f, const struct path *path);
+
+static inline void file_set_d_inode(struct file *f)
+{
+	f->f_inode = d_inode(f->f_path.dentry);
+}
 
 static inline void file_put_write_access(struct file *file)
 {
diff --git a/fs/open.c b/fs/open.c
index 91f1139591abe..a7b3b04cd9ae7 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -884,10 +884,38 @@ static inline int file_get_write_access(struct file *f)
 	return error;
 }
 
+static const struct file_operations empty_fops = {};
+
+static void do_path_file_open(struct file *f)
+{
+	f->f_mode = FMODE_PATH | FMODE_OPENED;
+	file_set_fsnotify_mode(f, FMODE_NONOTIFY);
+	f->f_op = &empty_fops;
+}
+
+/**
+ * kernel_path_file_open - open an O_PATH file for kernel internal use
+ * @f:		pre-allocated file with f_flags and f_cred initialized
+ * @path:	path to reference (may have a negative dentry)
+ *
+ * Open a minimal O_PATH file that only references a path.
+ * Unlike vfs_open(), this does not require a positive dentry and does not
+ * set up f_mapping and other fields not needed for O_PATH.
+ * If path is negative at the time of this call, the caller is responsible for
+ * callingn backing_file_set_user_path_inode() after making the path positive.
+
+ */
+void kernel_path_file_open(struct file *f, const struct path *path)
+{
+	f->__f_path = *path;
+	path_get(&f->f_path);
+	file_set_d_inode(f);
+	do_path_file_open(f);
+}
+
 static int do_dentry_open(struct file *f,
 			  int (*open)(struct inode *, struct file *))
 {
-	static const struct file_operations empty_fops = {};
 	struct inode *inode = f->f_path.dentry->d_inode;
 	int error;
 
@@ -898,9 +926,7 @@ static int do_dentry_open(struct file *f,
 	f->f_sb_err = file_sample_sb_err(f);
 
 	if (unlikely(f->f_flags & O_PATH)) {
-		f->f_mode = FMODE_PATH | FMODE_OPENED;
-		file_set_fsnotify_mode(f, FMODE_NONOTIFY);
-		f->f_op = &empty_fops;
+		do_path_file_open(f);
 		return 0;
 	}
 
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index ff3dbd1ca61f2..24e961f165a78 100644
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
@@ -1392,6 +1393,8 @@ static int ovl_create_tmpfile(struct file *file, struct dentry *dentry,
 			err = ovl_instantiate(dentry, inode, newdentry, false, file);
 			if (!err) {
 				file->private_data = of;
+				/* user_path_file was opened with a negative path */
+				backing_tmpfile_finish(realfile);
 			} else {
 				dput(newdentry);
 				ovl_file_free(of);
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
index 1476a6ed1bfd7..52ac51ada6ff9 100644
--- a/include/linux/backing-file.h
+++ b/include/linux/backing-file.h
@@ -9,21 +9,45 @@
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
+void backing_tmpfile_finish(struct file *file);
 ssize_t backing_file_read_iter(struct file *file, struct iov_iter *iter,
 			       struct kiocb *iocb, int flags,
 			       struct backing_file_ctx *ctx);
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


