Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 688F49C3A9A
	for <lists+linux-erofs@lfdr.de>; Mon, 11 Nov 2024 10:13:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1731316386;
	bh=yfSoN4OSqAiMwHrjisFXEEhi83HwUxq1CYnJT/Lwnxk=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=LyW8v/xyXFVoi5QRK+gF1Y/vDDeaMO4e7/DWBonKn/oeD/vCaSM1/awb4W/WAKym+
	 GxTStENrwPbNvHUpGMQyFMd/M/YPqpN85xw4Lq6lnF42u1nvUvwXGzo0+o2TtNrGNU
	 ZMQs2asyXyzUFSYTO3qHtlTOzatcwhMx/ogK6En1VWSA7+RQABCKhcG61fHea03N4e
	 SQY80vRXnh+RWdw9fubrE4KT9wds/pZPu/AxG9qkq97L88UPRXHcmtOSCP25RfRsWu
	 PhPO5uImKPFPx/KsJGY3g/pjqBHSGic+pz3YTXJ+gGEQyZ5By53Es0dRErYdsSTdkG
	 QJdWeFSLyAz/g==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xn3jt2p6Jz2yb9
	for <lists+linux-erofs@lfdr.de>; Mon, 11 Nov 2024 20:13:06 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731316384;
	cv=none; b=Jar616aaD5ZQoeINtadNOcM/w+ty75wGfqi36xWtXaF9ZNDlj9mq6t+kklNdzPEqU/iWjO5dO/mowWui2Ia0M3nqGo/+dW1smCizCegJSVXBfn5TcJTDqug9JiQ7Mc2W94caSRoxIiSwePA9KNoF8mMHGwg+1wN+UJapO4iGu25hXCXjCO+bkU7J7Moj/A3RJlZMv+spUgl6IgEdql/CRpyWIZ+uXoBcCKXw6hiR+akmLh/U8/Fn0R/1JXU3fOk1wufS3AoBZTMLRJz57AGvLoANOfBcK+WHrKNbFlTf18RrO8psPkTJZwEtB6cgK/GrNW2hUeXKm1e4/MWxarq5bg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731316384; c=relaxed/relaxed;
	bh=yfSoN4OSqAiMwHrjisFXEEhi83HwUxq1CYnJT/Lwnxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hfTwVL32s8N3HMPV4QJRVkO01o3/xQKVJkl2snzRmOWbmT9fd0SRRXlB1xXPf3S0/04QYcViYJXTo9GPH6BFJKdpDYDNUPDI+j/ooIYKcngBGSRUwVpU9L9fzx2H5Qt13wzcyls90kZ4kEwxVDZ+eGHMjl3tABhAOrqa4I2QLbKn9D/LhhQA2Qvms0HflqvC8nNfmrdWe7eXKbbSaYUAfn5G6lL8+xa8kAyrdPADAMjfjux20eprjuH13dE99QM3fF5egJWbfUONQnmZxwCi1iObwX6E1ErNsm+k4B4p/xDYuQPLqoDzCE0iMFrWatEN0lM5gnMjSVIoL0WFhADhLA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fgPSPhwK; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fgPSPhwK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xn3jq0HNqz2xl6
	for <linux-erofs@lists.ozlabs.org>; Mon, 11 Nov 2024 20:13:02 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 73A975C4AE6;
	Mon, 11 Nov 2024 09:12:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56D85C4CED0;
	Mon, 11 Nov 2024 09:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731316378;
	bh=eLegIPzm6kl+o1xbtiBt0w/Vn129KLVaIrdkjfKYWaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fgPSPhwKVCoHhP5ZUhqFPaUA3BckikO442jgj8GZjtPjAiQvZy2Zt8UJaqx4sZ4cn
	 tLQLnuNp8PDWRuevwPEyIHOAmeXYlFpVSIX3s7ozITJY1rKstBsCZlFlksJ0gw6tmS
	 kdvvTwHsIdFewza2NlXVyqYUKM9MykIn/gCPy6V7rfKaE5bePR/WM3+hqBWYTt+baE
	 ElCEQ+0slDPOh3YKguR0LIEL0eNaL2YyYEX/vSMtnmZZUKcDhQynA4VIMn0yTrjVZ3
	 fE5fwQWPiTHePSimVwb1JplWrql7brpCmIVXRpE7c1XmVUtvAeONSspLa67X4zbXJl
	 sD6sd7jx8WGRQ==
To: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v4 00/33] netfs: Read performance improvements and "single-blob" support
Date: Mon, 11 Nov 2024 10:12:33 +0100
Message-ID: <20241111-kochkunst-kroll-f8386db7f273@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241108173236.1382366-1-dhowells@redhat.com>
References: <20241108173236.1382366-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=4915; i=brauner@kernel.org; h=from:subject:message-id; bh=eLegIPzm6kl+o1xbtiBt0w/Vn129KLVaIrdkjfKYWaA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQbnuoTcJer1I9iZPy/KXnXkR3yzUvPeSUdKhatyKkPP 1/h4qTTUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJHXyowMJ73NZvvz71XzWu/R kX/O6mpbvrbzAbX0naeF5dI9IzTqGRmeOOw/3D7HYsVKm7tHJ/g+THnPZ3IgVWj+mYxQHlHHyPM MAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
From: Christian Brauner via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Christian Brauner <brauner@kernel.org>
Cc: Dominique Martinet <asmadeus@codewreck.org>, linux-mm@kvack.org, Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Steve French <smfrench@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, linux-nfs@vger.kernel.org, Tom Talpey <tom@talpey.com>, ceph-devel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, Christian Brauner <brauner@kernel.org>, netdev@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, 08 Nov 2024 17:32:01 +0000, David Howells wrote:
> This set of patches is primarily about two things: improving read
> performance and supporting monolithic single-blob objects that have to be
> read/written as such (e.g. AFS directory contents).  The implementation of
> the two parts is interwoven as each makes the other possible.
> 
> READ PERFORMANCE
> ================
> 
> [...]

Applied to the vfs-6.14.netfs branch of the vfs/vfs.git tree.
Patches in the vfs-6.14.netfs branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.14.netfs

[01/33] kheaders: Ignore silly-rename files
        https://git.kernel.org/vfs/vfs/c/3033d243b97c
[02/33] netfs: Remove call to folio_index()
        https://git.kernel.org/vfs/vfs/c/f709cec9dc52
[03/33] netfs: Fix a few minor bugs in netfs_page_mkwrite()
        https://git.kernel.org/vfs/vfs/c/07a80742a52b
[04/33] netfs: Remove unnecessary references to pages
        https://git.kernel.org/vfs/vfs/c/53f5f31a1549
[05/33] netfs: Use a folio_queue allocation and free functions
        https://git.kernel.org/vfs/vfs/c/1d044b4cb3e9
[06/33] netfs: Add a tracepoint to log the lifespan of folio_queue structs
        https://git.kernel.org/vfs/vfs/c/7583f643f714
[07/33] netfs: Abstract out a rolling folio buffer implementation
        https://git.kernel.org/vfs/vfs/c/2029a747a14d
[08/33] netfs: Make netfs_advance_write() return size_t
        https://git.kernel.org/vfs/vfs/c/34961bbe07a5
[09/33] netfs: Split retry code out of fs/netfs/write_collect.c
        https://git.kernel.org/vfs/vfs/c/8816207a3e26
[10/33] netfs: Drop the error arg from netfs_read_subreq_terminated()
        https://git.kernel.org/vfs/vfs/c/44c5114bb155
[11/33] netfs: Drop the was_async arg from netfs_read_subreq_terminated()
        https://git.kernel.org/vfs/vfs/c/3c8a83f74e0e
[12/33] netfs: Don't use bh spinlock
        https://git.kernel.org/vfs/vfs/c/5c962f9982cd
[13/33] afs: Don't use mutex for I/O operation lock
        https://git.kernel.org/vfs/vfs/c/244059f6472c
[14/33] afs: Fix EEXIST error returned from afs_rmdir() to be ENOTEMPTY
        https://git.kernel.org/vfs/vfs/c/10e890507ed5
[15/33] afs: Fix directory format encoding struct
        https://git.kernel.org/vfs/vfs/c/c8f34615191c
[16/33] netfs: Remove some extraneous directory invalidations
        https://git.kernel.org/vfs/vfs/c/ab143ef48b3b
[17/33] cachefiles: Add some subrequest tracepoints
        https://git.kernel.org/vfs/vfs/c/46599823a281
[18/33] cachefiles: Add auxiliary data trace
        https://git.kernel.org/vfs/vfs/c/499c9d489d7b
[19/33] afs: Add more tracepoints to do with tracking validity
        https://git.kernel.org/vfs/vfs/c/606d920396fd
[20/33] netfs: Add functions to build/clean a buffer in a folio_queue
        https://git.kernel.org/vfs/vfs/c/823f8d570db5
[21/33] netfs: Add support for caching single monolithic objects such as AFS dirs
        https://git.kernel.org/vfs/vfs/c/5ae8e69c119a
[22/33] afs: Make afs_init_request() get a key if not given a file
        https://git.kernel.org/vfs/vfs/c/bfeb953ddf0b
[23/33] afs: Use netfslib for directories
        https://git.kernel.org/vfs/vfs/c/2b6bae4ca558
[24/33] afs: Use netfslib for symlinks, allowing them to be cached
        https://git.kernel.org/vfs/vfs/c/a16c68c66f52
[25/33] afs: Eliminate afs_read
        https://git.kernel.org/vfs/vfs/c/b84e275b6da2
[26/33] afs: Fix cleanup of immediately failed async calls
        https://git.kernel.org/vfs/vfs/c/355d07737082
[27/33] afs: Make {Y,}FS.FetchData an asynchronous operation
        https://git.kernel.org/vfs/vfs/c/e31fb01515da
[28/33] netfs: Change the read result collector to only use one work item
        https://git.kernel.org/vfs/vfs/c/1bd9011ee163
[29/33] afs: Make afs_mkdir() locally initialise a new directory's content
        https://git.kernel.org/vfs/vfs/c/4e93a341aec1
[30/33] afs: Use the contained hashtable to search a directory
        https://git.kernel.org/vfs/vfs/c/08890740b1d7
[31/33] afs: Locally initialise the contents of a new symlink on creation
        https://git.kernel.org/vfs/vfs/c/d4f4a6bde676
[32/33] afs: Add a tracepoint for afs_read_receive()
        https://git.kernel.org/vfs/vfs/c/f06ba511d8d5
[33/33] netfs: Report on NULL folioq in netfs_writeback_unlock_folios()
        https://git.kernel.org/vfs/vfs/c/19375843912f
