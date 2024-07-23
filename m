Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E162E939D0E
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Jul 2024 11:00:18 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GcL2aU/Q;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bL8cfUYd;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WSrhJ09Dxz3cgM
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Jul 2024 19:00:16 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GcL2aU/Q;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bL8cfUYd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WSrhC5Hrwz30fM
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Jul 2024 19:00:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721725206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8ltHMdHYFgzTHmTSDOpVknq60bxF5gft0MPRVgKW40w=;
	b=GcL2aU/QrGc8MdH2/FCUCdASuMNefCvw4T+0ShmiPfuR2ddXi+dcq5lL3AY6DGwk/lX4bC
	WscSAUXRMwmfcKnB9YHbW0lbnj4T/XnyK3Zc5Q06OAfh7nn4OOECcy5eBvozMP6Gq2fPqH
	LCfDkd7nRFLGWIJ1TlnPoKgaCxe2iAo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721725207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8ltHMdHYFgzTHmTSDOpVknq60bxF5gft0MPRVgKW40w=;
	b=bL8cfUYdZC7u8CxScurBSjK2Xl7Xw+E8M++JzW7pA2Y9yYN1Bh09gleCkJxFxDQxQbS2go
	V2K0Yt7r8nVebWF1GnF2/Fn5xe76sKrQfR99Su9LjTSkGNuKPCu+KXXCoWHmyu5InEFfAp
	hDcCyeRBuETDtYgfPtikxW3rU8B7kWU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-29-M4oE5xN3MI6ObU4qZXNsZQ-1; Tue,
 23 Jul 2024 05:00:02 -0400
X-MC-Unique: M4oE5xN3MI6ObU4qZXNsZQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 20D6B1955F06;
	Tue, 23 Jul 2024 09:00:00 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.216])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CA1AA19560B2;
	Tue, 23 Jul 2024 08:59:55 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
    Christian Brauner <brauner@kernel.org>
Subject: [PATCH] vfs: Fix potential circular locking through setxattr() and removexattr()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2136177.1721725194.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jul 2024 09:59:54 +0100
Message-ID: <2136178.1721725194@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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
Cc: Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, dhowells@redhat.com, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

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

Fix this by moving the getting of the name and value in {get,remove}xattr(=
)
outside of the sb_writers lock.  This also has the minor benefits that we
don't need to reget these in the event of a retry and we never try to take
the sb_writers lock in the event we can't pull the name and value into the
kernel.

Alternative approaches that might fix this include moving the dispatch of =
a
write to the cache off to a workqueue or trying to do without the
validation lock in afs.  Note that this might also affect other filesystem=
s
that use netfslib and/or cachefiles.

 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
 WARNING: possible circular locking dependency detected
 6.10.0-build2+ #956 Not tainted
 ------------------------------------------------------
 fsstress/6050 is trying to acquire lock:
 ffff888138fd82f0 (mapping.invalidate_lock#3){++++}-{3:3}, at: filemap_fau=
lt+0x26e/0x8b0

 but task is already holding lock:
 ffff888113f26d18 (&vma->vm_lock->lock){++++}-{3:3}, at: lock_vma_under_rc=
u+0x165/0x250

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
  #0: ffff888113f26d18 (&vma->vm_lock->lock){++++}-{3:3}, at: lock_vma_und=
er_rcu+0x165/0x250

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
cc: Alexander Viro <viro@zeniv.linux.org.uk>
cc: Christian Brauner <brauner@kernel.org>
cc: Jan Kara <jack@suse.cz>
cc: Jeff Layton <jlayton@kernel.org>
cc: Gao Xiang <xiang@kernel.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: netfs@lists.linux.dev
cc: linux-erofs@lists.ozlabs.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/xattr.c |   88 ++++++++++++++++++++++++++++++++-----------------------=
------
 1 file changed, 47 insertions(+), 41 deletions(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index f8b643f91a98..ab46c5bd168f 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -630,10 +630,9 @@ int do_setxattr(struct mnt_idmap *idmap, struct dentr=
y *dentry,
 			ctx->kvalue, ctx->size, ctx->flags);
 }
 =

-static long
-setxattr(struct mnt_idmap *idmap, struct dentry *d,
-	const char __user *name, const void __user *value, size_t size,
-	int flags)
+static int path_setxattr(const char __user *pathname,
+			 const char __user *name, const void __user *value,
+			 size_t size, int flags, unsigned int lookup_flags)
 {
 	struct xattr_name kname;
 	struct xattr_ctx ctx =3D {
@@ -643,33 +642,20 @@ setxattr(struct mnt_idmap *idmap, struct dentry *d,
 		.kname    =3D &kname,
 		.flags    =3D flags,
 	};
+	struct path path;
 	int error;
 =

 	error =3D setxattr_copy(name, &ctx);
 	if (error)
 		return error;
 =

-	error =3D do_setxattr(idmap, d, &ctx);
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
 	error =3D user_path_at(AT_FDCWD, pathname, lookup_flags, &path);
 	if (error)
-		return error;
+		goto out;
 	error =3D mnt_want_write(path.mnt);
 	if (!error) {
-		error =3D setxattr(mnt_idmap(path.mnt), path.dentry, name,
-				 value, size, flags);
+		error =3D do_setxattr(mnt_idmap(path.mnt), path.dentry, &ctx);
 		mnt_drop_write(path.mnt);
 	}
 	path_put(&path);
@@ -677,6 +663,9 @@ static int path_setxattr(const char __user *pathname,
 		lookup_flags |=3D LOOKUP_REVAL;
 		goto retry;
 	}
+
+out:
+	kvfree(ctx.kvalue);
 	return error;
 }
 =

@@ -697,19 +686,32 @@ SYSCALL_DEFINE5(lsetxattr, const char __user *, path=
name,
 SYSCALL_DEFINE5(fsetxattr, int, fd, const char __user *, name,
 		const void __user *,value, size_t, size, int, flags)
 {
+	struct xattr_name kname;
+	struct xattr_ctx ctx =3D {
+		.cvalue   =3D value,
+		.kvalue   =3D NULL,
+		.size     =3D size,
+		.kname    =3D &kname,
+		.flags    =3D flags,
+	};
 	struct fd f =3D fdget(fd);
-	int error =3D -EBADF;
+	int error;
 =

 	if (!f.file)
-		return error;
+		return -EBADF;
 	audit_file(f.file);
+	error =3D setxattr_copy(name, &ctx);
+	if (error)
+		goto out_f;
+
 	error =3D mnt_want_write_file(f.file);
 	if (!error) {
-		error =3D setxattr(file_mnt_idmap(f.file),
-				 f.file->f_path.dentry, name,
-				 value, size, flags);
+		error =3D do_setxattr(file_mnt_idmap(f.file),
+				    f.file->f_path.dentry, &ctx);
 		mnt_drop_write_file(f.file);
 	}
+	kvfree(ctx.kvalue);
+out_f:
 	fdput(f);
 	return error;
 }
@@ -899,9 +901,17 @@ SYSCALL_DEFINE3(flistxattr, int, fd, char __user *, l=
ist, size_t, size)
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
 =

@@ -910,25 +920,13 @@ removexattr(struct mnt_idmap *idmap, struct dentry *=
d,
 		error =3D -ERANGE;
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
 	error =3D user_path_at(AT_FDCWD, pathname, lookup_flags, &path);
 	if (error)
 		return error;
 	error =3D mnt_want_write(path.mnt);
 	if (!error) {
-		error =3D removexattr(mnt_idmap(path.mnt), path.dentry, name);
+		error =3D removexattr(mnt_idmap(path.mnt), path.dentry, kname);
 		mnt_drop_write(path.mnt);
 	}
 	path_put(&path);
@@ -954,15 +952,23 @@ SYSCALL_DEFINE2(lremovexattr, const char __user *, p=
athname,
 SYSCALL_DEFINE2(fremovexattr, int, fd, const char __user *, name)
 {
 	struct fd f =3D fdget(fd);
+	char kname[XATTR_NAME_MAX + 1];
 	int error =3D -EBADF;
 =

 	if (!f.file)
 		return error;
 	audit_file(f.file);
+
+	error =3D strncpy_from_user(kname, name, sizeof(kname));
+	if (error =3D=3D 0 || error =3D=3D sizeof(kname))
+		error =3D -ERANGE;
+	if (error < 0)
+		return error;
+
 	error =3D mnt_want_write_file(f.file);
 	if (!error) {
 		error =3D removexattr(file_mnt_idmap(f.file),
-				    f.file->f_path.dentry, name);
+				    f.file->f_path.dentry, kname);
 		mnt_drop_write_file(f.file);
 	}
 	fdput(f);

