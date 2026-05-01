Return-Path: <linux-erofs+bounces-3372-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNQ8J/Kq9GmBDQIAu9opvQ
	(envelope-from <linux-erofs+bounces-3372-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 01 May 2026 15:30:26 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3404ACBCC
	for <lists+linux-erofs@lfdr.de>; Fri, 01 May 2026 15:30:25 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g6X3L5CbQz2xnZ;
	Fri, 01 May 2026 23:30:22 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777642222;
	cv=none; b=idx8g3WOPXhSoLlb5/3Pd3iPeI7TQ5VCaOA6Tcke/CUm3YqPnSzq4+cxbDN6l7r7552GzNhYcivLanZGvXHweu7GHHh6qSOCL78zYRTubZm9QBEyYi5RwRqkXUcR9XDI55cjSYVlFLsm0SKczExcJDt02i0fcW80E2upKTfcYH33x+olAgCLO+36iYRa97IVj7JoPEsa/dLs/TAH94YILl8nOFMbP0MjcoMtQ1gVBWIIJ33ZK+OMjURbVeP0yoXLamCA8WfW4GTIdXIU8Ch3bUiJ+9PD4u4Een0EIleqqcyEVdCizQvyC5Od3+cBbTAUe51hhQoSWbV5l5cFrI8f4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777642222; c=relaxed/relaxed;
	bh=TZmjvnwSbsIMhbxLPu5UewQalfgLFSVoOIwAS1WQPYA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=QZ8VZRXPn0gbvg+vE+oMHiP7plWFKS/BoPy4NQLtyEWck2TrK9OGGdg2NwVTWgR7Q0WE/Dlu8lSE4HljcNDHSAcbfZ0Rw3TOPoZRE6ppyaknR4qQW/HoOPDvYGx9CcymPdB+k6B8+WLCCeIEvhK+kYWGPGkPfN8e+Z2uz5gahilHyeXOkwCeoFejMcMeKDFY8X4dT7mhC3rXiKa0LfyplyNHPveCP4gcbo8KKshCPePQHIu4r+fv/xjyY+rZlb50ulg3jzqBW3U4C9cIRvxxVma0bKu79E+szxDz/tYHWviOB6BFaUqFq+uEIkdnOEphEIlGEFRUov0jfzQAJEQYIQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=te76HEjP; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=te76HEjP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g6X3K3jG6z2xC3
	for <linux-erofs@lists.ozlabs.org>; Fri, 01 May 2026 23:30:21 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id EDDB860583;
	Fri,  1 May 2026 13:30:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32A4EC2BCB4;
	Fri,  1 May 2026 13:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777642218;
	bh=KJ7yZ+cMRKcN36INI6pZbEKm9jR74TQt2fT9awHbo/o=;
	h=Subject:To:Cc:From:Date:From;
	b=te76HEjPPuGqYDdnXGU19DVlcJy2bHEn8qQe7zmpaZGZ4XTB1E7AmIwmSXvBhWD/B
	 II7Tj48y1Gju0leizbjiLlUpp8FZuN+FK6BbKae6H5P9xrblYWT624HLfeNm/xpyHz
	 0/G9vbR2VIpI/lCxEsbXqxqm6tzbFB3DCcIjl2DQ=
Subject: Patch "lsm: add backing_file LSM hooks" has been added to the 7.0-stable tree
To: amir73il@gmail.com,brauner@kernel.org,gregkh@linuxfoundation.org,linux-erofs@lists.ozlabs.org,paul@paul-moore.com,serge@hallyn.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 01 May 2026 15:29:49 +0200
Message-ID: <2026050149-stunned-uneasily-8aa3@gregkh>
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
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 
X-Spam-Status: No, score=2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SORTED_RECIPS,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: AE3404ACBCC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.30 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3372-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS(0.00)[m:amir73il@gmail.com,m:brauner@kernel.org,m:gregkh@linuxfoundation.org,m:linux-erofs@lists.ozlabs.org,m:paul@paul-moore.com,m:serge@hallyn.com,m:stable-commits@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,linuxfoundation.org,lists.ozlabs.org,paul-moore.com,hallyn.com];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hallyn.com:email,ozlabs.org:email,linuxfoundation.org:dkim,linuxfoundation.org:email,paul-moore.com:email]


This is a note to let you know that I've just added the patch titled

    lsm: add backing_file LSM hooks

to the 7.0-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     lsm-add-backing_file-lsm-hooks.patch
and it can be found in the queue-7.0 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From 6af36aeb147a06dea47c49859cd6ca5659aeb987 Mon Sep 17 00:00:00 2001
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 19 Dec 2025 13:18:22 -0500
Subject: lsm: add backing_file LSM hooks

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


Patches currently in stable-queue which might be from paul@paul-moore.com are

queue-7.0/fs-prepare-for-adding-lsm-blob-to-backing_file.patch
queue-7.0/selinux-fix-overlayfs-mmap-and-mprotect-access-checks.patch
queue-7.0/lsm-add-backing_file-lsm-hooks.patch

