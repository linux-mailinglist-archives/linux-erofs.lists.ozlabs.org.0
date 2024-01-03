Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FAC28235E3
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Jan 2024 20:50:08 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b=VSrUyOj1;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b=LWwj+WDn;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4T50gL01hHz3bsn
	for <lists+linux-erofs@lfdr.de>; Thu,  4 Jan 2024 06:50:06 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b=VSrUyOj1;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b=LWwj+WDn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codewreck.org (client-ip=2001:41d0:1:7a93::1; helo=nautica.notk.org; envelope-from=asmadeus@codewreck.org; receiver=lists.ozlabs.org)
X-Greylist: delayed 415 seconds by postgrey-1.37 at boromir; Thu, 04 Jan 2024 06:50:02 AEDT
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4T50gG2bcWz3bTN
	for <linux-erofs@lists.ozlabs.org>; Thu,  4 Jan 2024 06:50:02 +1100 (AEDT)
Received: by nautica.notk.org (Postfix, from userid 108)
	id 4283DC024; Wed,  3 Jan 2024 20:42:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1704310975; bh=vmsIH42o366lLCEtX1AOBPqwGBCA85i22kuEmfl/pd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VSrUyOj1qK/l/eFf/XzNdKkgcBSVhkVUlfm+O8VfUWxl5YGw1O98A0g/8wm0CJiFs
	 qi6JHNWLaTGaPp14YTfeCaQXkH5+RL6bwNXFjCQsyvFb+cw1VQF1qA3//JvTx8sBZO
	 s6GviFkWCB2OvJsDDnDGnv64iBDIEyaBPSCGtlXKt2OrlUk54XnleIYyGtaTQwh8dg
	 ANr3qLQlJnI+UTvy7nPUOA03QkZ+ntbCkZUufI/u591ZPQJhwXuYv9pBxyE3ivykpG
	 eHaGxGSSdjeNhqzwuKDW0iDIGpwt4kdtqaxn4f4lh6BtlWSBpUxAcAfMG5Epms5Zyu
	 wNeVtF6txco2Q==
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on nautica.notk.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=UNPARSEABLE_RELAY
	autolearn=unavailable version=3.3.2
Received: from gaia (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id C491EC009;
	Wed,  3 Jan 2024 20:42:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1704310974; bh=vmsIH42o366lLCEtX1AOBPqwGBCA85i22kuEmfl/pd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LWwj+WDnHlGIP8EddYD3ijwsipowZRszG5+7mmCFYhPYcMYSgYc5OJWYKs/tWPFHN
	 rrohSgHE3FDw1Mz8MzqKaodyJNeoI6TPLLL1d9Q1NJ66DkBG1MToMhqviNGVurzibK
	 1v22R0jso4fpbQJhRwbvPhzlAx+wgUiIT1fhTsxbUlHcy+LZCp5AuuEDVpHZvdvm4Q
	 tz/qGu7pt38R1ENarIYiaSDSKJWDhbYJ3ITsB+lf+1WGa1O/YU+Zn72WKAxHgI36F7
	 R0VGRHPjU7EG0v4NoM3+uFtkJeOVM0NL97kSEtIGAUuzOaFEK4U+GXIQ0jdzOpRbY9
	 awVfqCK9ksGxA==
Received: from localhost (gaia [local])
	by gaia (OpenSMTPD) with ESMTPA id bdfe584f;
	Wed, 3 Jan 2024 19:42:39 +0000 (UTC)
Date: Thu, 4 Jan 2024 04:42:24 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 4/5] 9p: Always update remote_i_size in stat2inode
Message-ID: <ZZW4oEuzCx-7AYpo@codewreck.org>
References: <20240103145935.384404-1-dhowells@redhat.com>
 <20240103145935.384404-5-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240103145935.384404-5-dhowells@redhat.com>
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
Cc: Latchesar Ionkov <lucho@ionkov.net>, Christian Schoenebeck <linux_oss@crudebyte.com>, linux-mm@kvack.org, Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Steve French <smfrench@gmail.com>, linux-cachefs@redhat.com, Gao Xiang <hsiangkao@linux.alibaba.com>, Ilya Dryomov <idryomov@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, ceph-devel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, Christian Brauner <christian@brauner.io>, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

David Howells wrote on Wed, Jan 03, 2024 at 02:59:28PM +0000:
> Always update remote_i_size in v9fs_stat2inode*() if the size is available,
> even if we are asked not to update i_isize

Sorry -- hold on for this patch, let's drop it for now and take it more
slowly through next cycle.

I had mostly forgotten about V9FS_STAT2INODE_KEEP_ISIZE and not paying
enough attention yesterday evening, but it's not innocent -- I assume
netfs will do the right thing if we update the *remote* i_size when
there is cached data, but the inode's i_size cannot be updated as
easily.

It's hard to notice because the comment got split in 5e3cc1ee1405a7
("9p: use inode->i_lock to protect i_size_write() under 32-bit"), but
v9fs_refresh_inode* still have it:
        /*      
         * We don't want to refresh inode->i_size,
         * because we may have cached data
         */

I assume refreshing i_size at a bad time would act like a truncation
of cached memory.

(To answer the other thread's comment that v9fs_i_size_write is useless;
it's far from obvious enough but I'm afraid it is needed:
- include/linux/fs.h has a comment saying i_size_write does need locking
around it for 32bit to avoid breaking i_size_seqcount; that's still true
in today's tree.
- we could use any lock as long as it's coherent within the 9p
subsystem, but we don't need a whole mutex so i_lock it is.)
-- 
Dominique Martinet | Asmadeus
