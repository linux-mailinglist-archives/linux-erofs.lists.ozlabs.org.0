Return-Path: <linux-erofs+bounces-3806-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vpOgBXiWRmo/ZQsAu9opvQ
	(envelope-from <linux-erofs+bounces-3806-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 02 Jul 2026 18:48:56 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CEB6FA97F
	for <lists+linux-erofs@lfdr.de>; Thu, 02 Jul 2026 18:48:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=d0stB0Ss;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3806-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3806-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grjWm5DN8z2yN8;
	Fri, 03 Jul 2026 02:48:52 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783010932;
	cv=none; b=nwi+TspdumA7sHI+WqtDy5YO/qQIfPjkeykwJCn/7mstqXsYVUBBwhbp4YEioYUUyeQ7o2tVt6TcTYEgGD/fSvSNC/W0puywEhQCU4VyxD+C7v0fQ3oz5Aa0O31Ad4xwI7y1keiWnNQaF/tDk5LJs0n981SHRsW6k2cLIUVCo6QdrAu3km8PkJJn/ULfcJN7+Waa9Y1jft3wXNcEis8j7Qczh2pG/DtIwNSRiqMP8qoSYwgBdPr51opeOEnLD2hN9RHXyIEE+KwTJK1ZVy62JWDi8b2EL0hfCV4tAcOuwIBDmr0j+LtTBIVjf9zGn3CdifaLlvXqHHZMKymdb+Dufw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783010932; c=relaxed/relaxed;
	bh=1jboJ4dq9bOA7tslltpr1UacQkwzy8lkigtfhPIuTgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MyThXt7uhnv3nnqGgsI7Etuwdxt1IN1DcJX9RCvo1vZC3LW2wvZJJqr3oD+gSjgPwKkHHCobTPS76YE+d6pFwKt3yuzuoDOo/ojRX4v5ePcC3yXkQMMNuDiml5+mO0K9bwlzaUnsiYInGpTGotFKLSVihIzf8JpMJ2jMEgvTTejh4Tp/c4a7KrXsE40cBhmsSAFKevvXfDXXoz9bNrjwGHEl7LMSI0hcMr4IwnVwVvEVMs6h/td5Z+VYAArhEVndPTKVE+OXSq79cWyjQQFY793D+UokEeE7sCt9AJsrMtnAZU4vT/LV1bSSzXBBo4mJUWXYv9Aw4NSRFYYPYXsgXw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=d0stB0Ss; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grjWl3r0zz2xLq
	for <linux-erofs@lists.ozlabs.org>; Fri, 03 Jul 2026 02:48:51 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0DD1E601FE;
	Thu,  2 Jul 2026 16:48:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48A3D1F000E9;
	Thu,  2 Jul 2026 16:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783010928;
	bh=1jboJ4dq9bOA7tslltpr1UacQkwzy8lkigtfhPIuTgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d0stB0SsaxALdDaQLmXVm2wTqAWE2Bfz/LVUkCcU2uxgC3ZXZ2SuziFtadrTNCNS9
	 iQ2BPmDBa8c8vX3pRuBSXFydOTjpeuJV+fCdXfHBjFbjkbDwoa8h36SQL35WdZ8A1X
	 ZTEL2pGDEPfYTMzrlQ8i7f6ZFlr2MDnu4pwWWOng=
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
	Paul Moore <paul@paul-moore.com>,
	Cai Xinchen <caixinchen1@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 089/175] lsm: add backing_file LSM hooks
Date: Thu,  2 Jul 2026 18:19:50 +0200
Message-ID: <20260702155117.654590762@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155115.766838875@linuxfoundation.org>
References: <20260702155115.766838875@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.70 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3806-lists,linux-erofs=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:linux-fsdevel@vger.kernel.org,m:linux-unionfs@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:amir73il@gmail.com,m:serge@hallyn.com,m:brauner@kernel.org,m:paul@paul-moore.com,m:caixinchen1@huawei.com,m:sashal@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,vger.kernel.org,lists.ozlabs.org,gmail.com,hallyn.com,kernel.org,paul-moore.com,huawei.com];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ozlabs.org:email,hallyn.com:email,huawei.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp,paul-moore.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 30CEB6FA97F

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Moore <paul@paul-moore.com>

[ Upstream commit 6af36aeb147a06dea47c49859cd6ca5659aeb987 ]

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
[1. Mainline uses call_int_hook(FUNC, ...) with the default IRC baked
into the macro. Linux 6.6.y uses call_int_hook(FUNC, IRC, ...) requiring
an explicit default return value.

2. fs/backing-file.c does not exist in LTS
Linux 6.6.y places backing_file_open() in fs/open.c and lacks a
dedicated fs/backing-file.c.  The backing_file_mmap() function and
scoped_with_creds() do not exist in 6.6.y.  Therefore the LTS patch calls
security_mmap_backing_file() directly in ovl_mmap() in
fs/overlayfs/file.c rather than modifying backing_file_mmap().

3. Missing filesystems/modules
Linux 6.6.y does not have backing_tmpfile_open(), fs/fuse/passthrough.c,
or the erofs ishare mmap path that the mainline patch touches.  These hunks
are dropped in the 6.6 LTS backport.

4. Use macro backing_file to replace inline function to eliminate the
const warning.]
Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/file_table.c               |  32 +++++++---
 fs/internal.h                 |   3 +-
 fs/open.c                     |   7 ++-
 fs/overlayfs/file.c           |   8 ++-
 include/linux/fs.h            |  15 ++++-
 include/linux/lsm_audit.h     |   2 +-
 include/linux/lsm_hook_defs.h |   5 ++
 include/linux/lsm_hooks.h     |   1 +
 include/linux/security.h      |  22 +++++++
 security/security.c           | 110 ++++++++++++++++++++++++++++++++++
 10 files changed, 190 insertions(+), 15 deletions(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index b4c208a771539d..fa4d4c54f790c8 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -48,12 +48,12 @@ static struct percpu_counter nr_files __cacheline_aligned_in_smp;
 struct backing_file {
 	struct file file;
 	struct path real_path;
+#ifdef CONFIG_SECURITY
+	void *security;
+#endif
 };
 
-static inline struct backing_file *backing_file(struct file *f)
-{
-	return container_of(f, struct backing_file, file);
-}
+#define backing_file(f) container_of(f, struct backing_file, file)
 
 struct path *backing_file_real_path(struct file *f)
 {
@@ -72,8 +72,21 @@ static void file_free_rcu(struct rcu_head *head)
 		kmem_cache_free(filp_cachep, f);
 }
 
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
 	path_put(&ff->real_path);
 }
 
@@ -257,10 +270,12 @@ struct file *alloc_empty_file_noaccount(int flags, const struct cred *cred)
 	return f;
 }
 
-static int init_backing_file(struct backing_file *ff)
+static int init_backing_file(struct backing_file *ff,
+			     const struct file *user_file)
 {
 	memset(&ff->real_path, 0, sizeof(ff->real_path));
-	return 0;
+	backing_file_set_security(&ff->file, NULL);
+	return security_backing_file_alloc(&ff->file, user_file);
 }
 
 /*
@@ -270,7 +285,8 @@ static int init_backing_file(struct backing_file *ff)
  * This is only for kernel internal use, and the allocate file must not be
  * installed into file tables or such.
  */
-struct file *alloc_empty_backing_file(int flags, const struct cred *cred)
+struct file *alloc_empty_backing_file(int flags, const struct cred *cred,
+				      const struct file *user_file)
 {
 	struct backing_file *ff;
 	int error;
@@ -287,7 +303,7 @@ struct file *alloc_empty_backing_file(int flags, const struct cred *cred)
 
 	/* The f_mode flags must be set before fput(). */
 	ff->file.f_mode |= FMODE_BACKING | FMODE_NOACCOUNT;
-	error = init_backing_file(ff);
+	error = init_backing_file(ff, user_file);
 	if (unlikely(error)) {
 		fput(&ff->file);
 		return ERR_PTR(error);
diff --git a/fs/internal.h b/fs/internal.h
index d64ae03998cce9..576026e1ce3aab 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -93,7 +93,8 @@ extern void chroot_fs_refs(const struct path *, const struct path *);
  */
 struct file *alloc_empty_file(int flags, const struct cred *cred);
 struct file *alloc_empty_file_noaccount(int flags, const struct cred *cred);
-struct file *alloc_empty_backing_file(int flags, const struct cred *cred);
+struct file *alloc_empty_backing_file(int flags, const struct cred *cred,
+				      const struct file *user_file);
 
 static inline void put_file_access(struct file *file)
 {
diff --git a/fs/open.c b/fs/open.c
index b5ea1dcbfb2242..5b164481d80b34 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1175,18 +1175,19 @@ EXPORT_SYMBOL_GPL(kernel_file_open);
  * the backing inode on the underlying filesystem, which can be
  * retrieved using backing_file_real_path().
  */
-struct file *backing_file_open(const struct path *path, int flags,
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
 
-	f->f_path = *path;
+	f->f_path = *user_path;
 	path_get(real_path);
 	*backing_file_real_path(f) = *real_path;
 	error = do_dentry_open(f, d_inode(real_path->dentry), NULL);
diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 8be4dc050d1ed2..07f00cf91977ee 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -60,7 +60,7 @@ static struct file *ovl_open_realfile(const struct file *file,
 		if (!inode_owner_or_capable(real_idmap, realinode))
 			flags &= ~O_NOATIME;
 
-		realfile = backing_file_open(&file->f_path, flags, realpath,
+		realfile = backing_file_open(file, flags, realpath,
 					     current_cred());
 	}
 	revert_creds(old_cred);
@@ -527,6 +527,7 @@ static int ovl_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 
 static int ovl_mmap(struct file *file, struct vm_area_struct *vma)
 {
+	struct file *user_file = vma->vm_file;
 	struct file *realfile = file->private_data;
 	const struct cred *old_cred;
 	int ret;
@@ -540,6 +541,11 @@ static int ovl_mmap(struct file *file, struct vm_area_struct *vma)
 	vma_set_file(vma, realfile);
 
 	old_cred = ovl_override_creds(file_inode(file)->i_sb);
+	ret = security_mmap_backing_file(vma, realfile, user_file);
+	if (ret) {
+		revert_creds(old_cred);
+		return ret;
+	}
 	ret = call_mmap(vma->vm_file, vma);
 	revert_creds(old_cred);
 	ovl_file_accessed(file);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 4cdeeaedaa404f..5a897ee50f29cf 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2515,11 +2515,24 @@ struct file *dentry_open(const struct path *path, int flags,
 			 const struct cred *creds);
 struct file *dentry_create(const struct path *path, int flags, umode_t mode,
 			   const struct cred *cred);
-struct file *backing_file_open(const struct path *path, int flags,
+struct file *backing_file_open(const struct file *user_file, int flags,
 			       const struct path *real_path,
 			       const struct cred *cred);
 struct path *backing_file_real_path(struct file *f);
 
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
  * file_real_path - get the path corresponding to f_inode
  *
diff --git a/include/linux/lsm_audit.h b/include/linux/lsm_audit.h
index 97a8b21eb03339..c0a2839253fa1f 100644
--- a/include/linux/lsm_audit.h
+++ b/include/linux/lsm_audit.h
@@ -93,7 +93,7 @@ struct common_audit_data {
 #endif
 		char *kmod_name;
 		struct lsm_ioctlop_audit *op;
-		struct file *file;
+		const struct file *file;
 		struct lsm_ibpkey_audit *ibpkey;
 		struct lsm_ibendport_audit *ibendport;
 		int reason;
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 2923754c13bce6..567d7f16609c8b 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -169,6 +169,9 @@ LSM_HOOK(int, 0, kernfs_init_security, struct kernfs_node *kn_dir,
 LSM_HOOK(int, 0, file_permission, struct file *file, int mask)
 LSM_HOOK(int, 0, file_alloc_security, struct file *file)
 LSM_HOOK(void, LSM_RET_VOID, file_free_security, struct file *file)
+LSM_HOOK(int, 0, backing_file_alloc, struct file *backing_file,
+	 const struct file *user_file)
+LSM_HOOK(void, LSM_RET_VOID, backing_file_free, struct file *backing_file)
 LSM_HOOK(int, 0, file_ioctl, struct file *file, unsigned int cmd,
 	 unsigned long arg)
 LSM_HOOK(int, 0, file_ioctl_compat, struct file *file, unsigned int cmd,
@@ -176,6 +179,8 @@ LSM_HOOK(int, 0, file_ioctl_compat, struct file *file, unsigned int cmd,
 LSM_HOOK(int, 0, mmap_addr, unsigned long addr)
 LSM_HOOK(int, 0, mmap_file, struct file *file, unsigned long reqprot,
 	 unsigned long prot, unsigned long flags)
+LSM_HOOK(int, 0, mmap_backing_file, struct vm_area_struct *vma,
+	 struct file *backing_file, struct file *user_file)
 LSM_HOOK(int, 0, file_mprotect, struct vm_area_struct *vma,
 	 unsigned long reqprot, unsigned long prot)
 LSM_HOOK(int, 0, file_lock, struct file *file, unsigned int cmd)
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index dcb5e5b5eb1352..3b56b60195ceb9 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -59,6 +59,7 @@ struct security_hook_list {
 struct lsm_blob_sizes {
 	int	lbs_cred;
 	int	lbs_file;
+	int lbs_backing_file;
 	int	lbs_inode;
 	int	lbs_superblock;
 	int	lbs_ipc;
diff --git a/include/linux/security.h b/include/linux/security.h
index 937840870d86c3..4866ffdb4e6c1d 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -389,11 +389,17 @@ int security_kernfs_init_security(struct kernfs_node *kn_dir,
 int security_file_permission(struct file *file, int mask);
 int security_file_alloc(struct file *file);
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
@@ -984,6 +990,15 @@ static inline int security_file_alloc(struct file *file)
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
@@ -1003,6 +1018,13 @@ static inline int security_mmap_file(struct file *file, unsigned long prot,
 	return 0;
 }
 
+static inline int security_mmap_backing_file(struct vm_area_struct *vma,
+					     struct file *backing_file,
+					     struct file *user_file)
+{
+	return 0;
+}
+
 static inline int security_mmap_addr(unsigned long addr)
 {
 	return cap_mmap_addr(addr);
diff --git a/security/security.c b/security/security.c
index 1794860fd614ea..4b61766c3d27bd 100644
--- a/security/security.c
+++ b/security/security.c
@@ -78,6 +78,7 @@ struct security_hook_heads security_hook_heads __ro_after_init;
 static BLOCKING_NOTIFIER_HEAD(blocking_lsm_notifier_chain);
 
 static struct kmem_cache *lsm_file_cache;
+static struct kmem_cache *lsm_backing_file_cache;
 static struct kmem_cache *lsm_inode_cache;
 
 char *lsm_names;
@@ -200,6 +201,8 @@ static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
 
 	lsm_set_blob_size(&needed->lbs_cred, &blob_sizes.lbs_cred);
 	lsm_set_blob_size(&needed->lbs_file, &blob_sizes.lbs_file);
+	lsm_set_blob_size(&needed->lbs_backing_file,
+			     &blob_sizes.lbs_backing_file);
 	/*
 	 * The inode blob gets an rcu_head in addition to
 	 * what the modules might need.
@@ -374,6 +377,7 @@ static void __init ordered_lsm_init(void)
 
 	init_debug("cred blob size       = %d\n", blob_sizes.lbs_cred);
 	init_debug("file blob size       = %d\n", blob_sizes.lbs_file);
+	init_debug("backing_file blob size  = %d\n", blob_sizes.lbs_backing_file);
 	init_debug("inode blob size      = %d\n", blob_sizes.lbs_inode);
 	init_debug("ipc blob size        = %d\n", blob_sizes.lbs_ipc);
 	init_debug("msg_msg blob size    = %d\n", blob_sizes.lbs_msg_msg);
@@ -388,6 +392,11 @@ static void __init ordered_lsm_init(void)
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
@@ -616,6 +625,30 @@ static int lsm_file_alloc(struct file *file)
 	return 0;
 }
 
+/**
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
 /**
  * lsm_inode_alloc - allocate a composite inode blob
  * @inode: the inode that needs a blob
@@ -2630,6 +2663,57 @@ void security_file_free(struct file *file)
 	}
 }
 
+/**
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
+	rc = call_int_hook(backing_file_alloc, 0, backing_file, user_file);
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
 /**
  * security_file_ioctl() - Check if an ioctl is allowed
  * @file: associated file
@@ -2723,6 +2807,32 @@ int security_mmap_file(struct file *file, unsigned long prot,
 	return ima_file_mmap(file, prot, prot_adj, flags);
 }
 
+/**
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
+	return call_int_hook(mmap_backing_file, 0, vma, backing_file, user_file);
+}
+EXPORT_SYMBOL_GPL(security_mmap_backing_file);
+
 /**
  * security_mmap_addr() - Check if mmap'ing an address is allowed
  * @addr: address
-- 
2.53.0




