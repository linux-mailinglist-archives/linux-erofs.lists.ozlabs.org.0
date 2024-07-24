Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B733C93AAA1
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Jul 2024 03:35:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1721784911;
	bh=TgLCl6dX6lWPw/0VkbIOMrO8TcbOiQmYCM+eTQ4uubs=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=oL5a2GcbDdc1PySWZMoa4TrmQrChBuW/rbEuPKKmiFAqIDxV4CB1o3dFz/BEoFHHV
	 6wz01fpr7s0aVm4hvSDkiU4bJ+OxE2XpbvPqlIqyH+4+4Lnnc30GTBf3ROD5EIyjIq
	 HvBRj0PQQGmyJGrs8Zq9Bz+J1u+5godmXmuuHlJ1xn7tpZ6BXuXNCmvf3gvhExnd0s
	 IkwbELN3M+kcrICs74J9YWmHgvSkWHgKSq5OwFFpZPS14uGm6h6KoOl0V7p1PHO1YU
	 nE7OWK4BZcTGfqfEZgYi9kexdWb16ATTXbPoMVJNyefUVH2bblLOu0Xe+tDp173QfQ
	 tp9Q3mpUeayDA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WTGmH3Bvjz3ccS
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Jul 2024 11:35:11 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=TNMjhOmL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=fromorbit.com (client-ip=2607:f8b0:4864:20::336; helo=mail-ot1-x336.google.com; envelope-from=david@fromorbit.com; receiver=lists.ozlabs.org)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WTGmB5hfXz3c13
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Jul 2024 11:35:05 +1000 (AEST)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-70365f905b6so4087845a34.0
        for <linux-erofs@lists.ozlabs.org>; Tue, 23 Jul 2024 18:35:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721784900; x=1722389700;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TgLCl6dX6lWPw/0VkbIOMrO8TcbOiQmYCM+eTQ4uubs=;
        b=RJq6q2Z6zNdbi/J+AgUnUgb3c7uRd5CXm5XkUiUHrd5eZ6JjlRnRpNu0c6YYTxTAAm
         6ZngaHGkdlEhQXccGQRWwSiXZWM5ylBw1gqLLqznNBcZK3YM5fze7Pq40uyRL6Ky9I1q
         j/mP+B89p9G6rN6Ro2iBNqIx4nKvXxLjPr5On1i5DMv2RO0QYdV+ebeHewjtKSIuNQAS
         WEinuBCk9OzqW9fNejB7cSKoyiRNRygimspWaRC4Os7JyR40PL+94zmzbycmb1J9p2D3
         OL0tlNz1+Duc5L1VNs/wJIXjT4MRRINk/iDdwv+prD2JrM4tHxkXh2UHa5zqGbtdIE+t
         l3ZA==
X-Forwarded-Encrypted: i=1; AJvYcCW8w78K6YpWk7xrlVWRh1QtBPxrHgF94fojzVkc+5mLPrtdlTvDXWUzuy4UPugLumn+0cNqMMfnE33C+iAFRvdp3M/hg2SG2WR/ylhK
X-Gm-Message-State: AOJu0YxvmVItqJf8JeznAV5mhUein2atcSssf+9xuEvvVomwMChBwaDV
	w2XBwK+mFOyPHDEB+lTPutbv2PCiwGJIGCGCJuu2oEtn1F4RZN+OYPaywk646tI=
X-Google-Smtp-Source: AGHT+IGrgiMmxeNAbEwss35kPfOGl5/tmfkncr/e5mJYcy66/Rdj0joepPVI5re+d+ypl9k1ZUALDg==
X-Received: by 2002:a05:6830:7316:b0:703:6434:aba8 with SMTP id 46e09a7af769-7092518c2f7mr731676a34.0.1721784899996;
        Tue, 23 Jul 2024 18:34:59 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-47-239.pa.nsw.optusnet.com.au. [49.181.47.239])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70d2a535f88sm4001440b3a.19.2024.07.23.18.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 18:34:59 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sWQu9-0098ej-0k;
	Wed, 24 Jul 2024 11:34:57 +1000
Date: Wed, 24 Jul 2024 11:34:57 +1000
To: Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] vfs: Fix potential circular locking through setxattr()
 and removexattr()
Message-ID: <ZqBaQS7IUTsU3ePs@dread.disaster.area>
References: <2136178.1721725194@warthog.procyon.org.uk>
 <20240723104533.mznf3svde36w6izp@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
From: Dave Chinner via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Dave Chinner <david@fromorbit.com>
Cc: Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, David Howells <dhowells@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Jul 23, 2024 at 12:45:33PM +0200, Jan Kara wrote:
> On Tue 23-07-24 09:59:54, David Howells wrote:
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

Actually, that can deadlock. We've just been over this with the NFS
localio proposal.  Network filesystem writeback that can recurse
into a local filesystem needs to be using (PF_LOCAL_THROTTLE |
PF_MEMALLOC_NOFS) for the writeback context.

This is to prevent the deadlocks on upper->lower->upper and
lower->upper->lower filesystem recursion via GFP_KERNEL memory
allocation and reclaim recursing between the two filesystems. This
is especially relevant for filesystems with ->writepage methods that
can be called from direct reclaim. Hence allocations in this path
need to be at least NOFS to prevent recursion back into the upper
filesystem from writeback into the lower filesystem.

Further, anywhere that dirty page writeback recurses into the front
end write path of a filesystem can deadlock in
balance_dirty_pages(). The upper filesystem can consume all the
dirty threshold and then the lower filesystem blocks trying to clean
dirty upper filesystem pages. Hence PF_LOCAL_THROTTLE is needed for
the lower filesystem IO to prevent it from being throttled when the
upper filesystem is throttled.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
