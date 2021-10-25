Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B39B5439EEA
	for <lists+linux-erofs@lfdr.de>; Mon, 25 Oct 2021 21:03:05 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HdPVH4TDSz2yKK
	for <lists+linux-erofs@lfdr.de>; Tue, 26 Oct 2021 06:03:03 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=thesusis.net (client-ip=34.202.238.73; helo=vps.thesusis.net;
 envelope-from=phill@thesusis.net; receiver=<UNKNOWN>)
Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HdPVD3ZrPz2xfD
 for <linux-erofs@lists.ozlabs.org>; Tue, 26 Oct 2021 06:03:00 +1100 (AEDT)
Received: by vps.thesusis.net (Postfix, from userid 1000)
 id 0C83861FD2; Mon, 25 Oct 2021 15:02:27 -0400 (EDT)
References: <YXHK5HrQpJu9oy8w@casper.infradead.org>
 <87tuh9n9w2.fsf@vps.thesusis.net> <20211022084127.GA1026@quack2.suse.cz>
User-agent: mu4e 1.7.0; emacs 27.1
From: Phillip Susi <phill@thesusis.net>
To: Jan Kara <jack@suse.cz>
Subject: Re: Readahead for compressed data
Date: Mon, 25 Oct 2021 14:59:45 -0400
In-reply-to: <20211022084127.GA1026@quack2.suse.cz>
Message-ID: <87fssprkql.fsf@vps.thesusis.net>
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
Cc: linux-ntfs-dev@lists.sourceforge.net, Matthew Wilcox <willy@infradead.org>,
 David Howells <dhowells@redhat.com>, linux-bcache@vger.kernel.org,
 Hsin-Yi Wang <hsinyi@chromium.org>, linux-fsdevel@vger.kernel.org,
 Phillip Lougher <phillip@squashfs.org.uk>, ntfs3@lists.linux.dev,
 linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


Jan Kara <jack@suse.cz> writes:

> Well, one of the problems with keeping compressed data is that for mmap(2)
> you have to have pages decompressed so that CPU can access them. So keeping
> compressed data in the page cache would add a bunch of complexity. That
> being said keeping compressed data cached somewhere else than in the page
> cache may certainly me worth it and then just filling page cache on demand
> from this data...

True... Did that multi generational LRU cache ever get merged?  I was
thinking you could use that to make sure that the kernel prefers to
reclaim the decompressed pages in favor of keeping the compressed ones
around.

