Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 42263972FBC
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Sep 2024 11:54:43 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X2zZS0rnmz2yZ5
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Sep 2024 19:54:40 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=147.75.193.91
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725962078;
	cv=none; b=CpjxBqh//NwqHu39Ygt2lisCOSXs4ySR+UeaFVT8yCI/pqiemzLDkwSPY1pwXQJomAT4zdrqpWSUu2Zkg69X1ldt04iWCBO5i0ldRmh36DOCXgLE8ziDysVEjYXGtUmsqs9F1KacSJiXqzcxs1kGTmi14uS9sDYaNESZxfJahaXYLUgyBuy5W0sMymFDegC7o69tVbtCtCHrfNV9dyUK5OjneZQoSIEzYxYYjPaTfcVPCRQlT8uA6M0eZo1ks91PN90U0dk3rzMouBEPc5Aka/EyWsPq8RSjE+ZHXBNGy8hxPXvpNQiYyCSASHuvuC4azmdswx1VmOhjprtVfFwzAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725962078; c=relaxed/relaxed;
	bh=qNL4kIs+gXkQ2EbWyKiDPCK5DmFH5crYa6WP71OtOnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OyupS6qED7ptX3wO0BNdXypo2VQseKgTI52ZVXSUKfvQRYpeZ0l7Pm6+p5kRo8QzsqlhLTrqrTkylZBVtDkDRCneqPC8rORQTvIbW81tCgY2zNHCHIEkiVvBzlKJoFqwpaHVrsm24n6SBPqARxQZpNq5rKw3Xbmq1R20PVSnzHbJ7pLD3S61LppBAwK6NVU4lXePiHWScyP6ujTIoiL+XO8CouI+tAwP4GtuoIIw78rlovuBk99oqSAGNnV7in/AJuXAl0DAX0Ccx45IB/nb5FXTRN1X4RX1TWFwpIlcyafJGljzyeeq7Sr2QG8wrwZjFEO/KKJfkK3ab9XtahBj/A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=qjUNn448; dkim-atps=neutral; spf=pass (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=qjUNn448;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X2zZP363Pz2xwH
	for <linux-erofs@lists.ozlabs.org>; Tue, 10 Sep 2024 19:54:36 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 4DCA8A44423;
	Tue, 10 Sep 2024 09:54:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5233C4CEC3;
	Tue, 10 Sep 2024 09:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725962072;
	bh=rG3tpbi/ocN+XIIuDnFF10/bxYZkGyA0bnpN7uvqTA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qjUNn448Keongl+6FVFskFNSTVeaPDtrk9AwuLxVmC968XDA+5XMlQWX1WV1tY4CG
	 HH+4OOEFkDjvkvxk9Hu0eh993/dUBPIDcPlqBP/q8ZnfWr0aUjlqiCmXw6oAWrq1lO
	 AQs7oq38MrSETcrWzgkmcqjqRQnP/6O5x0ZYfTvg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Subject: [PATCH 6.10 258/375] vfs: Fix potential circular locking through setxattr() and removexattr()
Date: Tue, 10 Sep 2024 11:30:55 +0200
Message-ID: <20240910092631.232821998@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092622.245959861@linuxfoundation.org>
References: <20240910092622.245959861@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
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
Cc: Sasha Levin <sashal@kernel.org>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jeff Layton <jlayton@kernel.org>, patches@lists.linux.dev, Matthew Wilcox <willy@infradead.org>, David Howells <dhowells@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

[ Upstream commit c3a5e3e872f3688ae0dc57bb78ca633921d96a91 ]

When using cachefiles, lockdep may emit something similar to the circular
locking dependency notice below.  The problem appears to stem from the
following:

 (1) Cachefiles manipulates xattrs on the files in its cache when called
     from ->writepages().

 (2) The setxattr() and removexattr() system call handlers get the name
     (and value) from userspace after taking the sb_writers lock, putting
     accesses of the vma->vm_lock and mm->mmap_lock inside of that.

 (3) The afs filesystem uses a per-inode lock to prevent multiple
     revalidation RPCs and in writeback vs truncate to prevent parallel
     operations from deadlocking against the server on one side and local
     page locks on the other.

Fix this by moving the getting of the name and value in {get,remove}xattr()
outside of the sb_writers lock.  This also has the minor benefits that we
don't need to reget these in the event of a retry and we never try to take
the sb_writers lock in the event we can't pull the name and value into the
kernel.

Alternative approaches that might fix this include moving the dispatch of a
write to the cache off to a workqueue or trying to do without the
validation lock in afs.  Note that this might also affect other filesystems
that use netfslib and/or cachefiles.

 ======================================================
 WARNING: possible circular locking dependency detected
 6.10.0-build2+ #956 Not tainted
 ------------------------------------------------------
 fsstress/6050 is trying to acquire lock:
 ffff888138fd82f0 (mapping.invalidate_lock#3){++++}-{3:3}, at: filemap_fault+0x26e/0x8b0

 but task is already holding lock:
 ffff888113f26d18 (&vma->vm_lock->lock){++++}-{3:3}, at: lock_vma_under_rcu+0x165/0x250

 which lock already depends on the new lock.

 the existing dependency chain (in reverse order) is:

 -> #4 (&vma->vm_lock->lock){++++}-{3:3}:
        __lock_acquire+0xaf0/0xd80
        lock_acquire.part.0+0x103/0x280
        down_write+0x3b/0x50
        vma_start_write+0x6b/0xa0
        vma_link+0xcc/0x140
        insert_vm_struct+0xb7/0xf0
        alloc_bprm+0x2c1/0x390
        kernel_execve+0x65/0x1a0
        call_usermodehelper_exec_async+0x14d/0x190
        ret_from_fork+0x24/0x40
        ret_from_fork_asm+0x1a/0x30

 -> #3 (&mm->mmap_lock){++++}-{3:3}:
        __lock_acquire+0xaf0/0xd80
        lock_acquire.part.0+0x103/0x280
        __might_fault+0x7c/0xb0
        strncpy_from_user+0x25/0x160
        removexattr+0x7f/0x100
        __do_sys_fremovexattr+0x7e/0xb0
        do_syscall_64+0x9f/0x100
        entry_SYSCALL_64_after_hwframe+0x76/0x7e

 -> #2 (sb_writers#14){.+.+}-{0:0}:
        __lock_acquire+0xaf0/0xd80
        lock_acquire.part.0+0x103/0x280
        percpu_down_read+0x3c/0x90
        vfs_iocb_iter_write+0xe9/0x1d0
        __cachefiles_write+0x367/0x430
        cachefiles_issue_write+0x299/0x2f0
        netfs_advance_write+0x117/0x140
        netfs_write_folio.isra.0+0x5ca/0x6e0
        netfs_writepages+0x230/0x2f0
        afs_writepages+0x4d/0x70
        do_writepages+0x1e8/0x3e0
        filemap_fdatawrite_wbc+0x84/0xa0
        __filemap_fdatawrite_range+0xa8/0xf0
        file_write_and_wait_range+0x59/0x90
        afs_release+0x10f/0x270
        __fput+0x25f/0x3d0
        __do_sys_close+0x43/0x70
        do_syscall_64+0x9f/0x100
        entry_SYSCALL_64_after_hwframe+0x76/0x7e

 -> #1 (&vnode->validate_lock){++++}-{3:3}:
        __lock_acquire+0xaf0/0xd80
        lock_acquire.part.0+0x103/0x280
        down_read+0x95/0x200
        afs_writepages+0x37/0x70
        do_writepages+0x1e8/0x3e0
        filemap_fdatawrite_wbc+0x84/0xa0
        filemap_invalidate_inode+0x167/0x1e0
        netfs_unbuffered_write_iter+0x1bd/0x2d0
        vfs_write+0x22e/0x320
        ksys_write+0xbc/0x130
        do_syscall_64+0x9f/0x100
        entry_SYSCALL_64_after_hwframe+0x76/0x7e

 -> #0 (mapping.invalidate_lock#3){++++}-{3:3}:
        check_noncircular+0x119/0x160
        check_prev_add+0x195/0x430
        __lock_acquire+0xaf0/0xd80
        lock_acquire.part.0+0x103/0x280
        down_read+0x95/0x200
        filemap_fault+0x26e/0x8b0
        __do_fault+0x57/0xd0
        do_pte_missing+0x23b/0x320
        __handle_mm_fault+0x2d4/0x320
        handle_mm_fault+0x14f/0x260
        do_user_addr_fault+0x2a2/0x500
        exc_page_fault+0x71/0x90
        asm_exc_page_fault+0x22/0x30

 other info that might help us debug this:

 Chain exists of:
   mapping.invalidate_lock#3 --> &mm->mmap_lock --> &vma->vm_lock->lock

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   rlock(&vma->vm_lock->lock);
                                lock(&mm->mmap_lock);
                                lock(&vma->vm_lock->lock);
   rlock(mapping.invalidate_lock#3);

  *** DEADLOCK ***

 1 lock held by fsstress/6050:
  #0: ffff888113f26d18 (&vma->vm_lock->lock){++++}-{3:3}, at: lock_vma_under_rcu+0x165/0x250

 stack backtrace:
 CPU: 0 PID: 6050 Comm: fsstress Not tainted 6.10.0-build2+ #956
 Hardware name: ASUS All Series/H97-PLUS, BIOS 2306 10/09/2014
 Call Trace:
  <TASK>
  dump_stack_lvl+0x57/0x80
  check_noncircular+0x119/0x160
  ? queued_spin_lock_slowpath+0x4be/0x510
  ? __pfx_check_noncircular+0x10/0x10
  ? __pfx_queued_spin_lock_slowpath+0x10/0x10
  ? mark_lock+0x47/0x160
  ? init_chain_block+0x9c/0xc0
  ? add_chain_block+0x84/0xf0
  check_prev_add+0x195/0x430
  __lock_acquire+0xaf0/0xd80
  ? __pfx___lock_acquire+0x10/0x10
  ? __lock_release.isra.0+0x13b/0x230
  lock_acquire.part.0+0x103/0x280
  ? filemap_fault+0x26e/0x8b0
  ? __pfx_lock_acquire.part.0+0x10/0x10
  ? rcu_is_watching+0x34/0x60
  ? lock_acquire+0xd7/0x120
  down_read+0x95/0x200
  ? filemap_fault+0x26e/0x8b0
  ? __pfx_down_read+0x10/0x10
  ? __filemap_get_folio+0x25/0x1a0
  filemap_fault+0x26e/0x8b0
  ? __pfx_filemap_fault+0x10/0x10
  ? find_held_lock+0x7c/0x90
  ? __pfx___lock_release.isra.0+0x10/0x10
  ? __pte_offset_map+0x99/0x110
  __do_fault+0x57/0xd0
  do_pte_missing+0x23b/0x320
  __handle_mm_fault+0x2d4/0x320
  ? __pfx___handle_mm_fault+0x10/0x10
  handle_mm_fault+0x14f/0x260
  do_user_addr_fault+0x2a2/0x500
  exc_page_fault+0x71/0x90
  asm_exc_page_fault+0x22/0x30

Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/r/2136178.1721725194@warthog.procyon.org.uk
cc: Alexander Viro <viro@zeniv.linux.org.uk>
cc: Christian Brauner <brauner@kernel.org>
cc: Jan Kara <jack@suse.cz>
cc: Jeff Layton <jlayton@kernel.org>
cc: Gao Xiang <xiang@kernel.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: netfs@lists.linux.dev
cc: linux-erofs@lists.ozlabs.org
cc: linux-fsdevel@vger.kernel.org
[brauner: fix minor issues]
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xattr.c | 91 ++++++++++++++++++++++++++++--------------------------
 1 file changed, 48 insertions(+), 43 deletions(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index f8b643f91a98..7672ce5486c5 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -630,10 +630,9 @@ int do_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
 			ctx->kvalue, ctx->size, ctx->flags);
 }
 
-static long
-setxattr(struct mnt_idmap *idmap, struct dentry *d,
-	const char __user *name, const void __user *value, size_t size,
-	int flags)
+static int path_setxattr(const char __user *pathname,
+			 const char __user *name, const void __user *value,
+			 size_t size, int flags, unsigned int lookup_flags)
 {
 	struct xattr_name kname;
 	struct xattr_ctx ctx = {
@@ -643,33 +642,20 @@ setxattr(struct mnt_idmap *idmap, struct dentry *d,
 		.kname    = &kname,
 		.flags    = flags,
 	};
+	struct path path;
 	int error;
 
 	error = setxattr_copy(name, &ctx);
 	if (error)
 		return error;
 
-	error = do_setxattr(idmap, d, &ctx);
-
-	kvfree(ctx.kvalue);
-	return error;
-}
-
-static int path_setxattr(const char __user *pathname,
-			 const char __user *name, const void __user *value,
-			 size_t size, int flags, unsigned int lookup_flags)
-{
-	struct path path;
-	int error;
-
 retry:
 	error = user_path_at(AT_FDCWD, pathname, lookup_flags, &path);
 	if (error)
-		return error;
+		goto out;
 	error = mnt_want_write(path.mnt);
 	if (!error) {
-		error = setxattr(mnt_idmap(path.mnt), path.dentry, name,
-				 value, size, flags);
+		error = do_setxattr(mnt_idmap(path.mnt), path.dentry, &ctx);
 		mnt_drop_write(path.mnt);
 	}
 	path_put(&path);
@@ -677,6 +663,9 @@ static int path_setxattr(const char __user *pathname,
 		lookup_flags |= LOOKUP_REVAL;
 		goto retry;
 	}
+
+out:
+	kvfree(ctx.kvalue);
 	return error;
 }
 
@@ -697,20 +686,32 @@ SYSCALL_DEFINE5(lsetxattr, const char __user *, pathname,
 SYSCALL_DEFINE5(fsetxattr, int, fd, const char __user *, name,
 		const void __user *,value, size_t, size, int, flags)
 {
-	struct fd f = fdget(fd);
-	int error = -EBADF;
+	struct xattr_name kname;
+	struct xattr_ctx ctx = {
+		.cvalue   = value,
+		.kvalue   = NULL,
+		.size     = size,
+		.kname    = &kname,
+		.flags    = flags,
+	};
+	int error;
 
+	CLASS(fd, f)(fd);
 	if (!f.file)
-		return error;
+		return -EBADF;
+
 	audit_file(f.file);
+	error = setxattr_copy(name, &ctx);
+	if (error)
+		return error;
+
 	error = mnt_want_write_file(f.file);
 	if (!error) {
-		error = setxattr(file_mnt_idmap(f.file),
-				 f.file->f_path.dentry, name,
-				 value, size, flags);
+		error = do_setxattr(file_mnt_idmap(f.file),
+				    f.file->f_path.dentry, &ctx);
 		mnt_drop_write_file(f.file);
 	}
-	fdput(f);
+	kvfree(ctx.kvalue);
 	return error;
 }
 
@@ -899,9 +900,17 @@ SYSCALL_DEFINE3(flistxattr, int, fd, char __user *, list, size_t, size)
  * Extended attribute REMOVE operations
  */
 static long
-removexattr(struct mnt_idmap *idmap, struct dentry *d,
-	    const char __user *name)
+removexattr(struct mnt_idmap *idmap, struct dentry *d, const char *name)
 {
+	if (is_posix_acl_xattr(name))
+		return vfs_remove_acl(idmap, d, name);
+	return vfs_removexattr(idmap, d, name);
+}
+
+static int path_removexattr(const char __user *pathname,
+			    const char __user *name, unsigned int lookup_flags)
+{
+	struct path path;
 	int error;
 	char kname[XATTR_NAME_MAX + 1];
 
@@ -910,25 +919,13 @@ removexattr(struct mnt_idmap *idmap, struct dentry *d,
 		error = -ERANGE;
 	if (error < 0)
 		return error;
-
-	if (is_posix_acl_xattr(kname))
-		return vfs_remove_acl(idmap, d, kname);
-
-	return vfs_removexattr(idmap, d, kname);
-}
-
-static int path_removexattr(const char __user *pathname,
-			    const char __user *name, unsigned int lookup_flags)
-{
-	struct path path;
-	int error;
 retry:
 	error = user_path_at(AT_FDCWD, pathname, lookup_flags, &path);
 	if (error)
 		return error;
 	error = mnt_want_write(path.mnt);
 	if (!error) {
-		error = removexattr(mnt_idmap(path.mnt), path.dentry, name);
+		error = removexattr(mnt_idmap(path.mnt), path.dentry, kname);
 		mnt_drop_write(path.mnt);
 	}
 	path_put(&path);
@@ -954,15 +951,23 @@ SYSCALL_DEFINE2(lremovexattr, const char __user *, pathname,
 SYSCALL_DEFINE2(fremovexattr, int, fd, const char __user *, name)
 {
 	struct fd f = fdget(fd);
+	char kname[XATTR_NAME_MAX + 1];
 	int error = -EBADF;
 
 	if (!f.file)
 		return error;
 	audit_file(f.file);
+
+	error = strncpy_from_user(kname, name, sizeof(kname));
+	if (error == 0 || error == sizeof(kname))
+		error = -ERANGE;
+	if (error < 0)
+		return error;
+
 	error = mnt_want_write_file(f.file);
 	if (!error) {
 		error = removexattr(file_mnt_idmap(f.file),
-				    f.file->f_path.dentry, name);
+				    f.file->f_path.dentry, kname);
 		mnt_drop_write_file(f.file);
 	}
 	fdput(f);
-- 
2.43.0



