Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38424436F50
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Oct 2021 03:18:32 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hb61K5Wmhz3c4y
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Oct 2021 12:18:29 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=thesusis.net (client-ip=34.202.238.73; helo=vps.thesusis.net;
 envelope-from=phill@thesusis.net; receiver=<UNKNOWN>)
X-Greylist: delayed 530 seconds by postgrey-1.36 at boromir;
 Fri, 22 Oct 2021 12:18:25 AEDT
Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hb61F0Fx7z30RN
 for <linux-erofs@lists.ozlabs.org>; Fri, 22 Oct 2021 12:18:25 +1100 (AEDT)
Received: by vps.thesusis.net (Postfix, from userid 1000)
 id 42E3C6148D; Thu, 21 Oct 2021 21:09:01 -0400 (EDT)
References: <YXHK5HrQpJu9oy8w@casper.infradead.org>
User-agent: mu4e 1.7.0; emacs 27.1
From: Phillip Susi <phill@thesusis.net>
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: Readahead for compressed data
Date: Thu, 21 Oct 2021 21:04:45 -0400
In-reply-to: <YXHK5HrQpJu9oy8w@casper.infradead.org>
Message-ID: <87tuh9n9w2.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: Jan Kara <jack@suse.cz>, linux-ntfs-dev@lists.sourceforge.net,
 David Howells <dhowells@redhat.com>, linux-bcache@vger.kernel.org,
 Hsin-Yi Wang <hsinyi@chromium.org>, linux-fsdevel@vger.kernel.org,
 Phillip Lougher <phillip@squashfs.org.uk>, ntfs3@lists.linux.dev,
 linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


Matthew Wilcox <willy@infradead.org> writes:

> As far as I can tell, the following filesystems support compressed data:
>
> bcachefs, btrfs, erofs, ntfs, squashfs, zisofs
>
> I'd like to make it easier and more efficient for filesystems to
> implement compressed data.  There are a lot of approaches in use today,
> but none of them seem quite right to me.  I'm going to lay out a few
> design considerations next and then propose a solution.  Feel free to
> tell me I've got the constraints wrong, or suggest alternative solutions.
>
> When we call ->readahead from the VFS, the VFS has decided which pages
> are going to be the most useful to bring in, but it doesn't know how
> pages are bundled together into blocks.  As I've learned from talking to
> Gao Xiang, sometimes the filesystem doesn't know either, so this isn't
> something we can teach the VFS.
>
> We (David) added readahead_expand() recently to let the filesystem
> opportunistically add pages to the page cache "around" the area requested
> by the VFS.  That reduces the number of times the filesystem has to
> decompress the same block.  But it can fail (due to memory allocation
> failures or pages already being present in the cache).  So filesystems
> still have to implement some kind of fallback.

Wouldn't it be better to keep the *compressed* data in the cache and
decompress it multiple times if needed rather than decompress it once
and cache the decompressed data?  You would use more CPU time
decompressing multiple times, but be able to cache more data and avoid
more disk IO, which is generally far slower than the CPU can decompress
the data.



