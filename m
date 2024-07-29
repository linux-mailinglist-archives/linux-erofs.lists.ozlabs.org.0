Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3E593F95E
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Jul 2024 17:28:37 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=iVfdxkA+;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WXj1b4Trvz3cZ4
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Jul 2024 01:28:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=iVfdxkA+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.73.55; helo=sin.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WXj1V54KWz30T7
	for <linux-erofs@lists.ozlabs.org>; Tue, 30 Jul 2024 01:28:30 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 690B2CE0B45;
	Mon, 29 Jul 2024 15:28:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBBB4C32786;
	Mon, 29 Jul 2024 15:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722266907;
	bh=4znxeB30JZL1ANv2iJsfkWtOwMksV8fxflsn+hLKFt4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iVfdxkA+7IEIpDIK+ZU61EtpKu68/EFIwJcs+hLVWc/3dVZunRkyUOAyZzDIdwh4k
	 0+FG/fvKY55vz38KDFW9R6c2YmzJq8snQyUqSOtvILjF8QhJlfQ5JFDP2KSFilCUhZ
	 MljjzwmbJ50mmwTbSUsxl2M85X4KdftejDSs0LW1UvZrOgql1zkE9l1xtx6VbKyIri
	 yvkvX9TDIJj4y3sU3lpgESICtwtn7tRRPm2XMvLOWhyqSry9S+XwbdmumxkEdcJCxG
	 oJmdOvSoB3pqhkhnMKpxw00ojrL/GoPFDKwzBjfzZwSKDrtSXXrNBorFWOu55XBz4o
	 aZVsVhk3Iom6Q==
Date: Mon, 29 Jul 2024 17:28:22 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] vfs: Fix potential circular locking through setxattr()
 and removexattr()
Message-ID: <20240729-gespickt-negativ-c1ce987e3c07@brauner>
References: <20240723104533.mznf3svde36w6izp@quack3>
 <2136178.1721725194@warthog.procyon.org.uk>
 <2147168.1721743066@warthog.procyon.org.uk>
 <20240724133009.6st3vmk5ondigbj7@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240724133009.6st3vmk5ondigbj7@quack3>
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

On Wed, Jul 24, 2024 at 03:30:09PM GMT, Jan Kara wrote:
> On Tue 23-07-24 14:57:46, David Howells wrote:
> > Jan Kara <jack@suse.cz> wrote:
> > 
> > > Well, it seems like you are trying to get rid of the dependency
> > > sb_writers->mmap_sem. But there are other places where this dependency is
> > > created, in particular write(2) path is a place where it would be very
> > > difficult to get rid of it (you take sb_writers, then do all the work
> > > preparing the write and then you copy user data into page cache which
> > > may require mmap_sem).
> > >
> > > ...
> > > 
> > > This is the problematic step - from quite deep in the locking chain holding
> > > invalidate_lock and having PG_Writeback set you suddently jump to very outer
> > > locking context grabbing sb_writers. Now AFAICT this is not a real deadlock
> > > problem because the locks are actually on different filesystems, just
> > > lockdep isn't able to see this. So I don't think you will get rid of these
> > > lockdep splats unless you somehow manage to convey to lockdep that there's
> > > the "upper" fs (AFS in this case) and the "lower" fs (the one behind
> > > cachefiles) and their locks are different.
> > 
> > I'm not sure you're correct about that.  If you look at the lockdep splat:
> > 
> > >  -> #2 (sb_writers#14){.+.+}-{0:0}:
> > 
> > The sb_writers lock is "personalised" to the filesystem type (the "#14"
> > annotation) which is set here:
> > 
> > 	for (i = 0; i < SB_FREEZE_LEVELS; i++) {
> > 		if (__percpu_init_rwsem(&s->s_writers.rw_sem[i],
> > 					sb_writers_name[i],
> > 					&type->s_writers_key[i]))  <----
> > 			goto fail;
> > 	}
> > 
> > in fs/super.c.
> 
> Right, forgot about that. Thanks for correction! So after pondering about
> this some more, this is actually a real problem and deadlockable. See
> below.
> 
> > I think the problem is (1) that on one side, you've got, say, sys_setxattr()
> > taking an sb_writers lock and then accessing a userspace buffer, which (a) may
> > take mm->mmap_lock and vma->vm_lock and (b) may cause reading or writeback
> > from the netfs-based filesystem via an mmapped xattr name buffer].
> 
> Yes, we agree on that. I was just pointing out that:
> 
> vfs_write()
>   file_start_write() -> grabs sb_writers
>   generic_file_write_iter()
>     generic_perform_write()
>       fault_in_iov_iter_readable()
> 
> is another path which enforces exactly the same lock ordering.
> 
> > Then (2) on the other side, you have a read or a write to the network
> > filesystem through netfslib which may invoke the cache, which may require
> > cachefiles to check the xattr on the cache file and maybe set/remove it -
> > which requires the sb_writers lock on the cache filesystem.
> > 
> > So if ->read_folio(), ->readahead() or ->writepages() can ever be called with
> > mm->mmap_lock or vma->vm_lock held, netfslib may call down to cachefiles and
> > ultimately, it should[*] then take the sb_writers lock on the backing
> > filesystem to perform xattr manipulation.
> 
> Well, ->read_folio() under mm->mmap_lock is a standard thing to happen in a
> page fault. Now grabbing sb_writers (of any filesystem) in that path is
> problematic and can deadlock though:
> 
> page fault
>   grab mm->mmap_lock
>   filemap_fault()
>     if (unlikely(!folio_test_uptodate(folio))) {
>       filemap_read_folio() on fs A
>         now if you grab sb_writers on fs B:
> 			freeze_super() on fs B		write(2) on fs B
> 							  sb_start_write(fs B)
> 			  sb->s_writers.frozen = SB_FREEZE_WRITE;
> 			  sb_wait_write(sb, SB_FREEZE_WRITE);
> 			    - waits for write
> 	sb_start_write(fs B) - blocked behind freeze_super()
> 							  generic_perform_write()
> 							    fault_in_iov_iter_readable()
> 							      page fault
> 							        grab mm->mmap_lock
> 								  => deadlock
> 
> Now this is not the deadlock your lockdep trace is showing but it is a
> similar one. Like:
> 
> filemap_invalidate() on fs A	freeze_super() on fs B	page fault on fs A	write(2) on fs B
>   filemap_invalidate_lock()				  lock mm->mmap_lock	  sb_start_write(fs B)
>   filemap_fdatawrite_wbc()				  filemap_fault()
>     afs_writepages()					    filemap_invalidate_lock_shared()
>       cachefiles_issue_write()				      => blocks behind filemap_invalidate()
> 				  sb->s_writers.frozen = SB_FREEZE_WRITE;
> 				  sb_wait_write(sb, SB_FREEZE_WRITE);
> 				    => blocks behind write(2)
>         sb_start_write() on fs B
> 	  => blocks behind freeze_super()
> 							  			  generic_perform_write()
> 										    fault_in_iov_iter_readable()
> 										      page fault
> 										        grab mm->mmap_lock
> 											  => deadlock
> 
> So I still maintain that grabbing sb_start_write() from quite deep within
> locking hierarchy (like from writepages when having pages locked, but even
> holding invalidate_lock is enough for the problems) is problematic and
> prone to deadlocks.
> 
> > [*] I say "should" because at the moment cachefiles calls vfs_set/removexattr
> >     functions which *don't* take this lock (which is a bug).  Is this an error
> >     on the part of vfs_set/removexattr()?  Should they take this lock
> >     analogously with vfs_truncate() and vfs_iocb_iter_write()?
> > 
> > However, as it doesn't it manages to construct a locking chain via the
> > mapping.invalidate_lock, the afs vnode->validate_lock and something in execve
> > that I don't exactly follow.
> > 
> > 
> > I wonder if this is might be deadlockable by a multithreaded process (ie. so
> > they share the mm locks) where one thread is writing to a cached file whilst
> > another thread is trying to set/remove the xattr on that file.
> 
> Yep, see above. Now the hard question is how to fix this because what you
> are doing seems to be inherent in how cachefiles fs is designed to work.

So one idea may be to create a private mount for cachefiles and then claim
write access when that private mount is created and retaining that write access
for the duration of cachefiles being run. See my draft patch below.

Right now things are as follows (roughly). Say cachefiles uses a directory of
the rootfs e.g., /mnt/cache-dir/ then cache->mnt points to /.

With my patch this becomes:

mnt["/mnt/cache-dir"] = clone_private_mnt("/mnt/cache-dir");

so cache->mnt points to "/mnt/cache-dir". That shouldn't be an issue though.

The more interesting changes in behavior come from mount properties. For
example, when

mount --bind /mnt/cache-dir /opt/

is created and /opt is used for cachefiles. When the bind-mount of
/mnt/cache-dir at /opt is made read-only it becomes read-only for cachefiles as
well.

But with an internal private mount that's no longer true. The internal mount
cannot be mounted read-only from userspace. Arguably, that would have been the
correct semantics right from the start similar to what overlayfs is doing.

However, the bigger semantic change would come from claiming write access when
the private mount is created. Claiming write access for as long as cachefiles
is running means that that the filesystem that is used cannot be remounted
read-only because mnt_hold_writers() would tell you to get lost. That
might be ok though. It just is something that should only be done with
capable(CAP_SYS_ADMIN) which cachefiles requires anyway.

I think the bigger issue might be freezing. Not because of the type of
operation but because freeze_super() would wait in sb_wait_write(sb,
SB_FREEZE_WRITE) until all writes finish and obviously they won't if
cachefiles just keeps running. That means you might hang forever.

One way to get around this last issue might be to introduce
SB_FREEZE_WRITE_LONGTERM which cachefiles can use (might even be able to
do that without a private mount then) and have freeze return with an
error in case long-term write access is claimed.

So anyway, trade-offs to be considered here. I just thought I throw this
out as a potential solution.

/* draft, sketch */

diff --git a/fs/cachefiles/cache.c b/fs/cachefiles/cache.c
index 9fb06dc16520..acbb5b95a9d1 100644
--- a/fs/cachefiles/cache.c
+++ b/fs/cachefiles/cache.c
@@ -20,6 +20,7 @@ int cachefiles_add_cache(struct cachefiles_cache *cache)
        struct path path;
        struct kstatfs stats;
        struct dentry *graveyard, *cachedir, *root;
+       struct vfsmount *mnt;
        const struct cred *saved_cred;
        int ret;

@@ -41,6 +42,20 @@ int cachefiles_add_cache(struct cachefiles_cache *cache)
        if (ret < 0)
                goto error_open_root;

+       mnt = clone_private_mount(&path);
+       if (IS_ERR(mnt)) {
+               path_put(&path);
+               goto error_unsupported;
+       }
+
+       ret = mnt_want_write(mnt);
+       if (ret) {
+               mntput(mnt);
+               path_put(&path);
+               goto error_unsupported;
+       }
+
+       mntput(path.mnt);
        cache->mnt = path.mnt;
        root = path.dentry;

diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index 89b11336a836..c3f0a5e6bdb5 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -816,6 +816,7 @@ static void cachefiles_daemon_unbind(struct cachefiles_cache *cache)

        cachefiles_put_directory(cache->graveyard);
        cachefiles_put_directory(cache->store);
+       mnt_drop_write(cache->mnt);
        mntput(cache->mnt);
        put_cred(cache->cache_cred);
