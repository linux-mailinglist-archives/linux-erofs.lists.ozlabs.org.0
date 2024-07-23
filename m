Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2741D93A21A
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Jul 2024 15:58:10 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QZqBbFPw;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Oc95XPwe;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WSzJ00RRcz3dXM
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Jul 2024 23:58:08 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QZqBbFPw;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Oc95XPwe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WSzHw3DT6z3dWg
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Jul 2024 23:58:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721743077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+mD1ewwJQ3UoqJtaGN7mRy1QcxELMUlyTG0lTtPiLg4=;
	b=QZqBbFPwmku7nPLIDPR9W7nDC/nEJS7s/Q4mPbMtOFOqCqCmNNzJ2c9KI2z9REEp7xcAC0
	XlbwQX2UM2Vygfdb8BVqOmuvsQ/CLDknIzzPNl4JMDM8RI3c+VON392EskOXJdaWFerPhL
	1oqw2Qvy9tZ9uKhBudQ6sqnwu7QuzCk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721743078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+mD1ewwJQ3UoqJtaGN7mRy1QcxELMUlyTG0lTtPiLg4=;
	b=Oc95XPweNthRKCbPcl+WBLKSUMtf318KAeWOrPuxUn2sjEONtLXIygM9ncPg3tVMp7GUUI
	Yyd7GtV/THgx9T2jyY9qYgo3TW5bdudTrvzjntED8PftU0ctuNoJLAiBnDGk3mVgBoo3Rx
	hDouP5eWhYmDNUWJ2Zqqzj/oT41huCg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-poFk0CaNMfWaJRfm_9ZalA-1; Tue,
 23 Jul 2024 09:57:54 -0400
X-MC-Unique: poFk0CaNMfWaJRfm_9ZalA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E72261955D5D;
	Tue, 23 Jul 2024 13:57:50 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.216])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8A77119560B2;
	Tue, 23 Jul 2024 13:57:47 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240723104533.mznf3svde36w6izp@quack3>
References: <20240723104533.mznf3svde36w6izp@quack3> <2136178.1721725194@warthog.procyon.org.uk>
To: Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] vfs: Fix potential circular locking through setxattr() and removexattr()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2147167.1721743066.1@warthog.procyon.org.uk>
Date: Tue, 23 Jul 2024 14:57:46 +0100
Message-ID: <2147168.1721743066@warthog.procyon.org.uk>
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
Cc: Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, dhowells@redhat.com, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Jan Kara <jack@suse.cz> wrote:

> Well, it seems like you are trying to get rid of the dependency
> sb_writers->mmap_sem. But there are other places where this dependency is
> created, in particular write(2) path is a place where it would be very
> difficult to get rid of it (you take sb_writers, then do all the work
> preparing the write and then you copy user data into page cache which
> may require mmap_sem).
>
> ...
> 
> This is the problematic step - from quite deep in the locking chain holding
> invalidate_lock and having PG_Writeback set you suddently jump to very outer
> locking context grabbing sb_writers. Now AFAICT this is not a real deadlock
> problem because the locks are actually on different filesystems, just
> lockdep isn't able to see this. So I don't think you will get rid of these
> lockdep splats unless you somehow manage to convey to lockdep that there's
> the "upper" fs (AFS in this case) and the "lower" fs (the one behind
> cachefiles) and their locks are different.

I'm not sure you're correct about that.  If you look at the lockdep splat:

>  -> #2 (sb_writers#14){.+.+}-{0:0}:

The sb_writers lock is "personalised" to the filesystem type (the "#14"
annotation) which is set here:

	for (i = 0; i < SB_FREEZE_LEVELS; i++) {
		if (__percpu_init_rwsem(&s->s_writers.rw_sem[i],
					sb_writers_name[i],
					&type->s_writers_key[i]))  <----
			goto fail;
	}

in fs/super.c.

I think the problem is (1) that on one side, you've got, say, sys_setxattr()
taking an sb_writers lock and then accessing a userspace buffer, which (a) may
take mm->mmap_lock and vma->vm_lock and (b) may cause reading or writeback
from the netfs-based filesystem via an mmapped xattr name buffer].

Then (2) on the other side, you have a read or a write to the network
filesystem through netfslib which may invoke the cache, which may require
cachefiles to check the xattr on the cache file and maybe set/remove it -
which requires the sb_writers lock on the cache filesystem.

So if ->read_folio(), ->readahead() or ->writepages() can ever be called with
mm->mmap_lock or vma->vm_lock held, netfslib may call down to cachefiles and
ultimately, it should[*] then take the sb_writers lock on the backing
filesystem to perform xattr manipulation.

[*] I say "should" because at the moment cachefiles calls vfs_set/removexattr
    functions which *don't* take this lock (which is a bug).  Is this an error
    on the part of vfs_set/removexattr()?  Should they take this lock
    analogously with vfs_truncate() and vfs_iocb_iter_write()?

However, as it doesn't it manages to construct a locking chain via the
mapping.invalidate_lock, the afs vnode->validate_lock and something in execve
that I don't exactly follow.


I wonder if this is might be deadlockable by a multithreaded process (ie. so
they share the mm locks) where one thread is writing to a cached file whilst
another thread is trying to set/remove the xattr on that file.

David

