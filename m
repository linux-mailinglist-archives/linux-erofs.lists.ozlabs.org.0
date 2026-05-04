Return-Path: <linux-erofs+bounces-3373-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uA6PMcqm+GnQxQIAu9opvQ
	(envelope-from <linux-erofs+bounces-3373-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 04 May 2026 16:01:46 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 583E64BE5A1
	for <lists+linux-erofs@lfdr.de>; Mon, 04 May 2026 16:01:35 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g8Nbw4zKhz2yZ3;
	Tue, 05 May 2026 00:01:32 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777903292;
	cv=none; b=fNQSTZWjQVscexjQOLlbD5OZIW5dyW47ogHgI0oAjfdG0f1ywBudq1ZOEsYYOPg5m8xg6djZ5pAvqbhYKgsrITxtrpaZOZNi92anr7ctJiNk/sviOEGbwIWzyXouLspe6EkwqQejKc0FrDl7//DqpyaZK2sShwEeP32GOGO/vDkCHiK/e5BU8lbm1BjvrRpwjEMUqhczouprI1yNMtXnVSO1fvAuoFcAHhEC4DhKqy7MEaESe0ds6h8QnEEsVJpNaL7Tp3mcJfhBhWa4cBUSsLBv1I3B+FXkvRCuZ5sUdCVaK+FQ8/LJf0FPO8XgR9/CfYF7xOnkJ+Idv1EZPLrXEw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777903292; c=relaxed/relaxed;
	bh=d+h7OA/35bUsK2db47hn6DHCUBQGVpuM7DRdF8seTIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dRBA8sao4an9w18eBj2zpP2f1WIBJrc21h1cOWknXAMPhED7MZWqX8obqi/y/DrlM59bHGGXI6ovlMtMK/U3Cv/jKepxkzsLsDzWyT+nZXhBkAawLmu59lm+i6Gic9crFSt/W/o55sm+MwCZCApMdOBAiBghpmw5izgM3NI3JfyQLyTDVZI9Gf7chyYU7Tmb8mLOcm5vgr+Ly1fjFA5nTPGdtGzob30iJFZTKCQHbRCnvKBlPBQ7qkL3x5RF233bzUhaevl/j+m90rk3dWxjI5tJaldWRMA33IaP82VGi3JpClW5lFWkKwuHd8QvgrkN/2z2CeM6HyoXNLt5h34vuQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=oGvbo4GI; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=oGvbo4GI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g8Nbt6mVhz2xS2
	for <linux-erofs@lists.ozlabs.org>; Tue, 05 May 2026 00:01:30 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id B6143408D2;
	Mon,  4 May 2026 14:01:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ADB4C2BCB8;
	Mon,  4 May 2026 14:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777903288;
	bh=o2Y+vSjaGbdKBXMg25ZKL3lww2liVQ9DbWgCCInv6bg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oGvbo4GIBQJKCfp1xia27IyV+knXe605HVcE3FLWcetRC6GlnBvjiahkunHSalrTY
	 bupyXtxy28/a1Sn4C4NwOHTEu1PXgQ4bNLvd7r/GQSg0YzKKfyZ60IQCQ/GJcZr4yN
	 ThVjWum5E+TOPzWD7wD+aBNoPyHYOFv2QEWexfgY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-erofs@lists.ozlabs.org,
	Amir Goldstein <amir73il@gmail.com>,
	Serge Hallyn <serge@hallyn.com>,
	Christian Brauner <brauner@kernel.org>,
	Paul Moore <paul@paul-moore.com>
Subject: [PATCH 7.0 169/307] lsm: add backing_file LSM hooks
Date: Mon,  4 May 2026 15:50:54 +0200
Message-ID: <20260504135149.223269107@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.814938198@linuxfoundation.org>
References: <20260504135142.814938198@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
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
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 583E64BE5A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.70 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,vger.kernel.org,lists.ozlabs.org,gmail.com,hallyn.com,kernel.org,paul-moore.com];
	TAGGED_FROM(0.00)[bounces-3373-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:linux-fsdevel@vger.kernel.org,m:linux-unionfs@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:amir73il@gmail.com,m:serge@hallyn.com,m:brauner@kernel.org,m:paul@paul-moore.com,s:lists@lfdr.de];
	RSPAMD_URIBL_FAIL(0.00)[ozlabs.org:query timed out,hallyn.com:query timed out,linuxfoundation.org:query timed out];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RSPAMD_EMAILBL_FAIL(0.00)[linux-erofs.lists.ozlabs.org:query timed out,brauner.kernel.org:query timed out,amir73il.gmail.com:query timed out,linux-unionfs.vger.kernel.org:query timed out,paul.paul-moore.com:query timed out,linux-fsdevel.vger.kernel.org:query timed out];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,ozlabs.org:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,hallyn.com:email]

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Moore <paul@paul-moore.com>

commit 6af36aeb147a06dea47c49859cd6ca5659aeb987 upstream.

Stacked filesystems such as overlayfs do not currently provide the
necessary mechanisms for LSMs to properly enforce access controls on the
mmap() and mprotect() operations.  In order to resolve this gap, a LSM
security blob is being added to the backing_file struct and the following
new LSM hooks are being created:

 security_backing_file_alloc()
 security_backing_file_free()
 security_mmap_backing_file()

The first two hooks are to manage the lifecycle of the LSM security blob
in the backing_file struct, while the third provides a new mmap() access
control point for the underlying backing file.  It is also expected that
LSMs will likely want to update their security_file_mprotect() callback
to address issues with their mprotect() controls, but that does not
require a change to the security_file_mprotect() LSM hook.

There are a three other small changes to support these new LSM hooks:
* Pass the user file associated with a backing file down to
alloc_empty_backing_file() so it can be included in the
security_backing_file_alloc() hook.
* Add getter and setter functions for the backing_file struct LSM blob
as the backing_file struct remains private to fs/file_table.c.
* Constify the file struct field in the LSM common_audit_data struct to
better support LSMs that need to pass a const file struct pointer into
the common LSM audit code.

Thanks to Arnd Bergmann for identifying the missing EXPORT_SYMBOL_GPL()
and supplying a fixup.

Cc: stable@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-unionfs@vger.kernel.org
Cc: linux-erofs@lists.ozlabs.org
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Serge Hallyn <serge@hallyn.com>
Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/backing-file.c             |   18 +++++--
 fs/erofs/ishare.c             |   10 +++-
 fs/file_table.c               |   27 +++++++++--
 fs/fuse/passthrough.c         |    2 
 fs/internal.h                 |    3 -
 fs/overlayfs/dir.c            |    2 
 fs/overlayfs/file.c           |    2 
 include/linux/backing-file.h  |    4 -
 include/linux/fs.h            |   13 +++++
 include/linux/lsm_audit.h     |    2 
 include/linux/lsm_hook_defs.h |    5 ++
 include/linux/lsm_hooks.h     |    1 
 include/linux/security.h      |   22 +++++++++
 security/lsm.h                |    1 
 security/lsm_init.c           |    9 +++
 security/security.c           |  102 ++++++++++++++++++++++++++++++++++++++++++
 16 files changed, 206 insertions(+), 17 deletions(-)

--- a/fs/backing-file.c
+++ b/fs/backing-file.c
@@ -12,6 +12,7 @@
 #include <linux/backing-file.h>
 #include <linux/splice.h>
 #include <linux/mm.h>
+#include <linux/security.h>
 
 #include "internal.h"
 
@@ -29,14 +30,15 @@
  * returned file into a container structure that also stores the stacked
  * file's path, which can be retrieved using backing_file_user_path().
  */
-struct file *backing_file_open(const struct path *user_path, int flags,
+struct file *backing_file_open(const struct file *user_file, int flags,
 			       const struct path *real_path,
 			       const struct cred *cred)
 {
+	const struct path *user_path = &user_file->f_path;
 	struct file *f;
 	int error;
 
-	f = alloc_empty_backing_file(flags, cred);
+	f = alloc_empty_backing_file(flags, cred, user_file);
 	if (IS_ERR(f))
 		return f;
 
@@ -52,15 +54,16 @@ struct file *backing_file_open(const str
 }
 EXPORT_SYMBOL_GPL(backing_file_open);
 
-struct file *backing_tmpfile_open(const struct path *user_path, int flags,
+struct file *backing_tmpfile_open(const struct file *user_file, int flags,
 				  const struct path *real_parentpath,
 				  umode_t mode, const struct cred *cred)
 {
 	struct mnt_idmap *real_idmap = mnt_idmap(real_parentpath->mnt);
+	const struct path *user_path = &user_file->f_path;
 	struct file *f;
 	int error;
 
-	f = alloc_empty_backing_file(flags, cred);
+	f = alloc_empty_backing_file(flags, cred, user_file);
 	if (IS_ERR(f))
 		return f;
 
@@ -336,8 +339,13 @@ int backing_file_mmap(struct file *file,
 
 	vma_set_file(vma, file);
 
-	scoped_with_creds(ctx->cred)
+	scoped_with_creds(ctx->cred) {
+		ret = security_mmap_backing_file(vma, file, user_file);
+		if (ret)
+			return ret;
+
 		ret = vfs_mmap(vma->vm_file, vma);
+	}
 
 	if (ctx->accessed)
 		ctx->accessed(user_file);
--- a/fs/erofs/ishare.c
+++ b/fs/erofs/ishare.c
@@ -4,6 +4,7 @@
  */
 #include <linux/xxhash.h>
 #include <linux/mount.h>
+#include <linux/security.h>
 #include "internal.h"
 #include "xattr.h"
 
@@ -106,7 +107,8 @@ static int erofs_ishare_file_open(struct
 
 	if (file->f_flags & O_DIRECT)
 		return -EINVAL;
-	realfile = alloc_empty_backing_file(O_RDONLY|O_NOATIME, current_cred());
+	realfile = alloc_empty_backing_file(O_RDONLY|O_NOATIME, current_cred(),
+					    file);
 	if (IS_ERR(realfile))
 		return PTR_ERR(realfile);
 	ihold(sharedinode);
@@ -150,8 +152,14 @@ static ssize_t erofs_ishare_file_read_it
 static int erofs_ishare_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct file *realfile = file->private_data;
+	int err;
 
 	vma_set_file(vma, realfile);
+
+	err = security_mmap_backing_file(vma, realfile, file);
+	if (err)
+		return err;
+
 	return generic_file_readonly_mmap(file, vma);
 }
 
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -50,6 +50,9 @@ struct backing_file {
 		struct path user_path;
 		freeptr_t bf_freeptr;
 	};
+#ifdef CONFIG_SECURITY
+	void *security;
+#endif
 };
 
 #define backing_file(f) container_of(f, struct backing_file, file)
@@ -66,8 +69,21 @@ void backing_file_set_user_path(struct f
 }
 EXPORT_SYMBOL_GPL(backing_file_set_user_path);
 
+#ifdef CONFIG_SECURITY
+void *backing_file_security(const struct file *f)
+{
+	return backing_file(f)->security;
+}
+
+void backing_file_set_security(struct file *f, void *security)
+{
+	backing_file(f)->security = security;
+}
+#endif /* CONFIG_SECURITY */
+
 static inline void backing_file_free(struct backing_file *ff)
 {
+	security_backing_file_free(&ff->file);
 	path_put(&ff->user_path);
 	kmem_cache_free(bfilp_cachep, ff);
 }
@@ -288,10 +304,12 @@ struct file *alloc_empty_file_noaccount(
 	return f;
 }
 
-static int init_backing_file(struct backing_file *ff)
+static int init_backing_file(struct backing_file *ff,
+			     const struct file *user_file)
 {
 	memset(&ff->user_path, 0, sizeof(ff->user_path));
-	return 0;
+	backing_file_set_security(&ff->file, NULL);
+	return security_backing_file_alloc(&ff->file, user_file);
 }
 
 /*
@@ -301,7 +319,8 @@ static int init_backing_file(struct back
  * This is only for kernel internal use, and the allocate file must not be
  * installed into file tables or such.
  */
-struct file *alloc_empty_backing_file(int flags, const struct cred *cred)
+struct file *alloc_empty_backing_file(int flags, const struct cred *cred,
+				      const struct file *user_file)
 {
 	struct backing_file *ff;
 	int error;
@@ -318,7 +337,7 @@ struct file *alloc_empty_backing_file(in
 
 	/* The f_mode flags must be set before fput(). */
 	ff->file.f_mode |= FMODE_BACKING | FMODE_NOACCOUNT;
-	error = init_backing_file(ff);
+	error = init_backing_file(ff, user_file);
 	if (unlikely(error)) {
 		fput(&ff->file);
 		return ERR_PTR(error);
--- a/fs/fuse/passthrough.c
+++ b/fs/fuse/passthrough.c
@@ -167,7 +167,7 @@ struct fuse_backing *fuse_passthrough_op
 		goto out;
 
 	/* Allocate backing file per fuse file to store fuse path */
-	backing_file = backing_file_open(&file->f_path, file->f_flags,
+	backing_file = backing_file_open(file, file->f_flags,
 					 &fb->file->f_path, fb->cred);
 	err = PTR_ERR(backing_file);
 	if (IS_ERR(backing_file)) {
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -106,7 +106,8 @@ extern void chroot_fs_refs(const struct
  */
 struct file *alloc_empty_file(int flags, const struct cred *cred);
 struct file *alloc_empty_file_noaccount(int flags, const struct cred *cred);
-struct file *alloc_empty_backing_file(int flags, const struct cred *cred);
+struct file *alloc_empty_backing_file(int flags, const struct cred *cred,
+				      const struct file *user_file);
 void backing_file_set_user_path(struct file *f, const struct path *path);
 
 static inline void file_put_write_access(struct file *file)
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -1374,7 +1374,7 @@ static int ovl_create_tmpfile(struct fil
 				return PTR_ERR(cred);
 
 			ovl_path_upper(dentry->d_parent, &realparentpath);
-			realfile = backing_tmpfile_open(&file->f_path, flags, &realparentpath,
+			realfile = backing_tmpfile_open(file, flags, &realparentpath,
 							mode, current_cred());
 			err = PTR_ERR_OR_ZERO(realfile);
 			pr_debug("tmpfile/open(%pd2, 0%o) = %i\n", realparentpath.dentry, mode, err);
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -48,7 +48,7 @@ static struct file *ovl_open_realfile(co
 			if (!inode_owner_or_capable(real_idmap, realinode))
 				flags &= ~O_NOATIME;
 
-			realfile = backing_file_open(file_user_path(file),
+			realfile = backing_file_open(file,
 						     flags, realpath, current_cred());
 		}
 	}
--- a/include/linux/backing-file.h
+++ b/include/linux/backing-file.h
@@ -18,10 +18,10 @@ struct backing_file_ctx {
 	void (*end_write)(struct kiocb *iocb, ssize_t);
 };
 
-struct file *backing_file_open(const struct path *user_path, int flags,
+struct file *backing_file_open(const struct file *user_file, int flags,
 			       const struct path *real_path,
 			       const struct cred *cred);
-struct file *backing_tmpfile_open(const struct path *user_path, int flags,
+struct file *backing_tmpfile_open(const struct file *user_file, int flags,
 				  const struct path *real_parentpath,
 				  umode_t mode, const struct cred *cred);
 ssize_t backing_file_read_iter(struct file *file, struct iov_iter *iter,
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2475,6 +2475,19 @@ struct file *dentry_create(struct path *
 			   const struct cred *cred);
 const struct path *backing_file_user_path(const struct file *f);
 
+#ifdef CONFIG_SECURITY
+void *backing_file_security(const struct file *f);
+void backing_file_set_security(struct file *f, void *security);
+#else
+static inline void *backing_file_security(const struct file *f)
+{
+	return NULL;
+}
+static inline void backing_file_set_security(struct file *f, void *security)
+{
+}
+#endif /* CONFIG_SECURITY */
+
 /*
  * When mmapping a file on a stackable filesystem (e.g., overlayfs), the file
  * stored in ->vm_file is a backing file whose f_inode is on the underlying
--- a/include/linux/lsm_audit.h
+++ b/include/linux/lsm_audit.h
@@ -94,7 +94,7 @@ struct common_audit_data {
 #endif
 		char *kmod_name;
 		struct lsm_ioctlop_audit *op;
-		struct file *file;
+		const struct file *file;
 		struct lsm_ibpkey_audit *ibpkey;
 		struct lsm_ibendport_audit *ibendport;
 		int reason;
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -191,6 +191,9 @@ LSM_HOOK(int, 0, file_permission, struct
 LSM_HOOK(int, 0, file_alloc_security, struct file *file)
 LSM_HOOK(void, LSM_RET_VOID, file_release, struct file *file)
 LSM_HOOK(void, LSM_RET_VOID, file_free_security, struct file *file)
+LSM_HOOK(int, 0, backing_file_alloc, struct file *backing_file,
+	 const struct file *user_file)
+LSM_HOOK(void, LSM_RET_VOID, backing_file_free, struct file *backing_file)
 LSM_HOOK(int, 0, file_ioctl, struct file *file, unsigned int cmd,
 	 unsigned long arg)
 LSM_HOOK(int, 0, file_ioctl_compat, struct file *file, unsigned int cmd,
@@ -198,6 +201,8 @@ LSM_HOOK(int, 0, file_ioctl_compat, stru
 LSM_HOOK(int, 0, mmap_addr, unsigned long addr)
 LSM_HOOK(int, 0, mmap_file, struct file *file, unsigned long reqprot,
 	 unsigned long prot, unsigned long flags)
+LSM_HOOK(int, 0, mmap_backing_file, struct vm_area_struct *vma,
+	 struct file *backing_file, struct file *user_file)
 LSM_HOOK(int, 0, file_mprotect, struct vm_area_struct *vma,
 	 unsigned long reqprot, unsigned long prot)
 LSM_HOOK(int, 0, file_lock, struct file *file, unsigned int cmd)
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -104,6 +104,7 @@ struct security_hook_list {
 struct lsm_blob_sizes {
 	unsigned int lbs_cred;
 	unsigned int lbs_file;
+	unsigned int lbs_backing_file;
 	unsigned int lbs_ib;
 	unsigned int lbs_inode;
 	unsigned int lbs_sock;
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -472,11 +472,17 @@ int security_file_permission(struct file
 int security_file_alloc(struct file *file);
 void security_file_release(struct file *file);
 void security_file_free(struct file *file);
+int security_backing_file_alloc(struct file *backing_file,
+				const struct file *user_file);
+void security_backing_file_free(struct file *backing_file);
 int security_file_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
 int security_file_ioctl_compat(struct file *file, unsigned int cmd,
 			       unsigned long arg);
 int security_mmap_file(struct file *file, unsigned long prot,
 			unsigned long flags);
+int security_mmap_backing_file(struct vm_area_struct *vma,
+			       struct file *backing_file,
+			       struct file *user_file);
 int security_mmap_addr(unsigned long addr);
 int security_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
 			   unsigned long prot);
@@ -1141,6 +1147,15 @@ static inline void security_file_release
 static inline void security_file_free(struct file *file)
 { }
 
+static inline int security_backing_file_alloc(struct file *backing_file,
+					      const struct file *user_file)
+{
+	return 0;
+}
+
+static inline void security_backing_file_free(struct file *backing_file)
+{ }
+
 static inline int security_file_ioctl(struct file *file, unsigned int cmd,
 				      unsigned long arg)
 {
@@ -1159,6 +1174,13 @@ static inline int security_mmap_file(str
 {
 	return 0;
 }
+
+static inline int security_mmap_backing_file(struct vm_area_struct *vma,
+					     struct file *backing_file,
+					     struct file *user_file)
+{
+	return 0;
+}
 
 static inline int security_mmap_addr(unsigned long addr)
 {
--- a/security/lsm.h
+++ b/security/lsm.h
@@ -29,6 +29,7 @@ extern struct lsm_blob_sizes blob_sizes;
 
 /* LSM blob caches */
 extern struct kmem_cache *lsm_file_cache;
+extern struct kmem_cache *lsm_backing_file_cache;
 extern struct kmem_cache *lsm_inode_cache;
 
 /* LSM blob allocators */
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -293,6 +293,8 @@ static void __init lsm_prepare(struct ls
 	blobs = lsm->blobs;
 	lsm_blob_size_update(&blobs->lbs_cred, &blob_sizes.lbs_cred);
 	lsm_blob_size_update(&blobs->lbs_file, &blob_sizes.lbs_file);
+	lsm_blob_size_update(&blobs->lbs_backing_file,
+			     &blob_sizes.lbs_backing_file);
 	lsm_blob_size_update(&blobs->lbs_ib, &blob_sizes.lbs_ib);
 	/* inode blob gets an rcu_head in addition to LSM blobs. */
 	if (blobs->lbs_inode && blob_sizes.lbs_inode == 0)
@@ -441,6 +443,8 @@ int __init security_init(void)
 	if (lsm_debug) {
 		lsm_pr("blob(cred) size %d\n", blob_sizes.lbs_cred);
 		lsm_pr("blob(file) size %d\n", blob_sizes.lbs_file);
+		lsm_pr("blob(backing_file) size %d\n",
+		       blob_sizes.lbs_backing_file);
 		lsm_pr("blob(ib) size %d\n", blob_sizes.lbs_ib);
 		lsm_pr("blob(inode) size %d\n", blob_sizes.lbs_inode);
 		lsm_pr("blob(ipc) size %d\n", blob_sizes.lbs_ipc);
@@ -462,6 +466,11 @@ int __init security_init(void)
 		lsm_file_cache = kmem_cache_create("lsm_file_cache",
 						   blob_sizes.lbs_file, 0,
 						   SLAB_PANIC, NULL);
+	if (blob_sizes.lbs_backing_file)
+		lsm_backing_file_cache = kmem_cache_create(
+						   "lsm_backing_file_cache",
+						   blob_sizes.lbs_backing_file,
+						   0, SLAB_PANIC, NULL);
 	if (blob_sizes.lbs_inode)
 		lsm_inode_cache = kmem_cache_create("lsm_inode_cache",
 						    blob_sizes.lbs_inode, 0,
--- a/security/security.c
+++ b/security/security.c
@@ -82,6 +82,7 @@ const struct lsm_id *lsm_idlist[MAX_LSM_
 struct lsm_blob_sizes blob_sizes;
 
 struct kmem_cache *lsm_file_cache;
+struct kmem_cache *lsm_backing_file_cache;
 struct kmem_cache *lsm_inode_cache;
 
 #define SECURITY_HOOK_ACTIVE_KEY(HOOK, IDX) security_hook_active_##HOOK##_##IDX
@@ -174,6 +175,30 @@ static int lsm_file_alloc(struct file *f
 }
 
 /**
+ * lsm_backing_file_alloc - allocate a composite backing file blob
+ * @backing_file: the backing file
+ *
+ * Allocate the backing file blob for all the modules.
+ *
+ * Returns 0, or -ENOMEM if memory can't be allocated.
+ */
+static int lsm_backing_file_alloc(struct file *backing_file)
+{
+	void *blob;
+
+	if (!lsm_backing_file_cache) {
+		backing_file_set_security(backing_file, NULL);
+		return 0;
+	}
+
+	blob = kmem_cache_zalloc(lsm_backing_file_cache, GFP_KERNEL);
+	backing_file_set_security(backing_file, blob);
+	if (!blob)
+		return -ENOMEM;
+	return 0;
+}
+
+/**
  * lsm_blob_alloc - allocate a composite blob
  * @dest: the destination for the blob
  * @size: the size of the blob
@@ -2419,6 +2444,57 @@ void security_file_free(struct file *fil
 }
 
 /**
+ * security_backing_file_alloc() - Allocate and setup a backing file blob
+ * @backing_file: the backing file
+ * @user_file: the associated user visible file
+ *
+ * Allocate a backing file LSM blob and perform any necessary initialization of
+ * the LSM blob.  There will be some operations where the LSM will not have
+ * access to @user_file after this point, so any important state associated
+ * with @user_file that is important to the LSM should be captured in the
+ * backing file's LSM blob.
+ *
+ * LSM's should avoid taking a reference to @user_file in this hook as it will
+ * result in problems later when the system attempts to drop/put the file
+ * references due to a circular dependency.
+ *
+ * Return: Return 0 if the hook is successful, negative values otherwise.
+ */
+int security_backing_file_alloc(struct file *backing_file,
+				const struct file *user_file)
+{
+	int rc;
+
+	rc = lsm_backing_file_alloc(backing_file);
+	if (rc)
+		return rc;
+	rc = call_int_hook(backing_file_alloc, backing_file, user_file);
+	if (unlikely(rc))
+		security_backing_file_free(backing_file);
+
+	return rc;
+}
+
+/**
+ * security_backing_file_free() - Free a backing file blob
+ * @backing_file: the backing file
+ *
+ * Free any LSM state associate with a backing file's LSM blob, including the
+ * blob itself.
+ */
+void security_backing_file_free(struct file *backing_file)
+{
+	void *blob = backing_file_security(backing_file);
+
+	call_void_hook(backing_file_free, backing_file);
+
+	if (blob) {
+		backing_file_set_security(backing_file, NULL);
+		kmem_cache_free(lsm_backing_file_cache, blob);
+	}
+}
+
+/**
  * security_file_ioctl() - Check if an ioctl is allowed
  * @file: associated file
  * @cmd: ioctl cmd
@@ -2507,6 +2583,32 @@ int security_mmap_file(struct file *file
 }
 
 /**
+ * security_mmap_backing_file - Check if mmap'ing a backing file is allowed
+ * @vma: the vm_area_struct for the mmap'd region
+ * @backing_file: the backing file being mmap'd
+ * @user_file: the user file being mmap'd
+ *
+ * Check permissions for a mmap operation on a stacked filesystem.  This hook
+ * is called after the security_mmap_file() and is responsible for authorizing
+ * the mmap on @backing_file.  It is important to note that the mmap operation
+ * on @user_file has already been authorized and the @vma->vm_file has been
+ * set to @backing_file.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
+int security_mmap_backing_file(struct vm_area_struct *vma,
+			       struct file *backing_file,
+			       struct file *user_file)
+{
+	/* recommended by the stackable filesystem devs */
+	if (WARN_ON_ONCE(!(backing_file->f_mode & FMODE_BACKING)))
+		return -EIO;
+
+	return call_int_hook(mmap_backing_file, vma, backing_file, user_file);
+}
+EXPORT_SYMBOL_GPL(security_mmap_backing_file);
+
+/**
  * security_mmap_addr() - Check if mmap'ing an address is allowed
  * @addr: address
  *



