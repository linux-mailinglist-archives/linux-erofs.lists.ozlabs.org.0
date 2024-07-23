Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB44939F77
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Jul 2024 13:12:07 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=uKckGtRr;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WSvcP4fc0z3ccX
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Jul 2024 21:12:05 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=uKckGtRr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.73.55; helo=sin.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WSvcK6QQrz2y8q
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Jul 2024 21:12:01 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 6C1AACE0E49;
	Tue, 23 Jul 2024 11:11:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C32CC4AF0A;
	Tue, 23 Jul 2024 11:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721733117;
	bh=hJsVgyiAMBuc1PS9TnXUFps/ubUqO5CQMzsyJiAKdsk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uKckGtRrSme/gn5Qfp5RqmwSQlxnye+sJyNKMBm3FTCNEFwRQCjLNnMtXoylUl7qm
	 RbPTWJTHmA3WEXdGtbxcS9OOAv5bXLirMw9wTewwQjFYZU1zizgRCd5ALAD/OKXmXF
	 Q9rQ+qGtFfUIgqRxMypWcHehgotGdQeTOD6B2sIYSpp2+qOZ8ehK0BiOv/bbgxVkyr
	 MrgcI+01BbJTY+C2q86YP6aHAMHryfjTnfT0F7V30eZ3UJ6m+pPsMxR0vKZJgs9AqI
	 FXGKYkNxlm+UiuaY/vwXep4LKfihhjBJP8iakE2KK9mPyHei4wWXf8G5R7K+Iirqmk
	 uQdOTFywO4zQQ==
Date: Tue, 23 Jul 2024 13:11:51 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] vfs: Fix potential circular locking through setxattr()
 and removexattr()
Message-ID: <20240723-aberkennen-unruhen-61570127dc6e@brauner>
References: <2136178.1721725194@warthog.procyon.org.uk>
 <20240723104533.mznf3svde36w6izp@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240723104533.mznf3svde36w6izp@quack3>
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
Cc: Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, David Howells <dhowells@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Jul 23, 2024 at 12:45:33PM GMT, Jan Kara wrote:
> On Tue 23-07-24 09:59:54, David Howells wrote:
> > When using cachefiles, lockdep may emit something similar to the circular
> > locking dependency notice below.  The problem appears to stem from the
> > following:
> > 
> >  (1) Cachefiles manipulates xattrs on the files in its cache when called
> >      from ->writepages().
> > 
> >  (2) The setxattr() and removexattr() system call handlers get the name
> >      (and value) from userspace after taking the sb_writers lock, putting
> >      accesses of the vma->vm_lock and mm->mmap_lock inside of that.
> > 
> >  (3) The afs filesystem uses a per-inode lock to prevent multiple
> >      revalidation RPCs and in writeback vs truncate to prevent parallel
> >      operations from deadlocking against the server on one side and local
> >      page locks on the other.
> > 
> > Fix this by moving the getting of the name and value in {get,remove}xattr()
> > outside of the sb_writers lock.  This also has the minor benefits that we
> > don't need to reget these in the event of a retry and we never try to take
> > the sb_writers lock in the event we can't pull the name and value into the
> > kernel.
> 
> Well, it seems like you are trying to get rid of the dependency
> sb_writers->mmap_sem. But there are other places where this dependency is

Independent of this issue, I think that moving the retrieval of name and
value out of the lock is a good thing. The commit message might need to
get reworded of course.

> created, in particular write(2) path is a place where it would be very
> difficult to get rid of it (you take sb_writers, then do all the work
> preparing the write and then you copy user data into page cache which
> may require mmap_sem).
> 
> But looking at the lockdep splat below:
> 
> >  ======================================================
> >  WARNING: possible circular locking dependency detected
> >  6.10.0-build2+ #956 Not tainted
> >  ------------------------------------------------------
> >  fsstress/6050 is trying to acquire lock:
> >  ffff888138fd82f0 (mapping.invalidate_lock#3){++++}-{3:3}, at: filemap_fault+0x26e/0x8b0
> > 
> >  but task is already holding lock:
> >  ffff888113f26d18 (&vma->vm_lock->lock){++++}-{3:3}, at: lock_vma_under_rcu+0x165/0x250
> > 
> >  which lock already depends on the new lock.
> > 
> >  the existing dependency chain (in reverse order) is:
> > 
> >  -> #4 (&vma->vm_lock->lock){++++}-{3:3}:
> >         __lock_acquire+0xaf0/0xd80
> >         lock_acquire.part.0+0x103/0x280
> >         down_write+0x3b/0x50
> >         vma_start_write+0x6b/0xa0
> >         vma_link+0xcc/0x140
> >         insert_vm_struct+0xb7/0xf0
> >         alloc_bprm+0x2c1/0x390
> >         kernel_execve+0x65/0x1a0
> >         call_usermodehelper_exec_async+0x14d/0x190
> >         ret_from_fork+0x24/0x40
> >         ret_from_fork_asm+0x1a/0x30
> > 
> >  -> #3 (&mm->mmap_lock){++++}-{3:3}:
> >         __lock_acquire+0xaf0/0xd80
> >         lock_acquire.part.0+0x103/0x280
> >         __might_fault+0x7c/0xb0
> >         strncpy_from_user+0x25/0x160
> >         removexattr+0x7f/0x100
> >         __do_sys_fremovexattr+0x7e/0xb0
> >         do_syscall_64+0x9f/0x100
> >         entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > 
> >  -> #2 (sb_writers#14){.+.+}-{0:0}:
> >         __lock_acquire+0xaf0/0xd80
> >         lock_acquire.part.0+0x103/0x280
> >         percpu_down_read+0x3c/0x90
> >         vfs_iocb_iter_write+0xe9/0x1d0
> >         __cachefiles_write+0x367/0x430
> >         cachefiles_issue_write+0x299/0x2f0
> >         netfs_advance_write+0x117/0x140
> >         netfs_write_folio.isra.0+0x5ca/0x6e0
> >         netfs_writepages+0x230/0x2f0
> >         afs_writepages+0x4d/0x70
> >         do_writepages+0x1e8/0x3e0
> >         filemap_fdatawrite_wbc+0x84/0xa0
> >         __filemap_fdatawrite_range+0xa8/0xf0
> >         file_write_and_wait_range+0x59/0x90
> >         afs_release+0x10f/0x270
> >         __fput+0x25f/0x3d0
> >         __do_sys_close+0x43/0x70
> >         do_syscall_64+0x9f/0x100
> >         entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> This is the problematic step - from quite deep in the locking chain holding
> invalidate_lock and having PG_Writeback set you suddently jump to very outer
> locking context grabbing sb_writers. Now AFAICT this is not a real deadlock
> problem because the locks are actually on different filesystems, just
> lockdep isn't able to see this. So I don't think you will get rid of these
> lockdep splats unless you somehow manage to convey to lockdep that there's
> the "upper" fs (AFS in this case) and the "lower" fs (the one behind
> cachefiles) and their locks are different.
> 
> >  -> #1 (&vnode->validate_lock){++++}-{3:3}:
> >         __lock_acquire+0xaf0/0xd80
> >         lock_acquire.part.0+0x103/0x280
> >         down_read+0x95/0x200
> >         afs_writepages+0x37/0x70
> >         do_writepages+0x1e8/0x3e0
> >         filemap_fdatawrite_wbc+0x84/0xa0
> >         filemap_invalidate_inode+0x167/0x1e0
> >         netfs_unbuffered_write_iter+0x1bd/0x2d0
> >         vfs_write+0x22e/0x320
> >         ksys_write+0xbc/0x130
> >         do_syscall_64+0x9f/0x100
> >         entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > 
> >  -> #0 (mapping.invalidate_lock#3){++++}-{3:3}:
> >         check_noncircular+0x119/0x160
> >         check_prev_add+0x195/0x430
> >         __lock_acquire+0xaf0/0xd80
> >         lock_acquire.part.0+0x103/0x280
> >         down_read+0x95/0x200
> >         filemap_fault+0x26e/0x8b0
> >         __do_fault+0x57/0xd0
> >         do_pte_missing+0x23b/0x320
> >         __handle_mm_fault+0x2d4/0x320
> >         handle_mm_fault+0x14f/0x260
> >         do_user_addr_fault+0x2a2/0x500
> >         exc_page_fault+0x71/0x90
> >         asm_exc_page_fault+0x22/0x30
> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
