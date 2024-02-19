Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C2564859F44
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Feb 2024 10:09:02 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TdcCv4k59z3cCK
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Feb 2024 20:08:59 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=leemhuis.info (client-ip=80.237.130.52; helo=wp530.webpack.hosteurope.de; envelope-from=regressions@leemhuis.info; receiver=lists.ozlabs.org)
X-Greylist: delayed 1805 seconds by postgrey-1.37 at boromir; Mon, 19 Feb 2024 20:08:53 AEDT
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TdcCn2zkPz3brl
	for <linux-erofs@lists.ozlabs.org>; Mon, 19 Feb 2024 20:08:52 +1100 (AEDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rbzAY-0007jO-Uv; Mon, 19 Feb 2024 09:38:35 +0100
Message-ID: <960e015a-ec2e-42c2-bd9e-4aa47ab4ef2a@leemhuis.info>
Date: Mon, 19 Feb 2024 09:38:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] netfs: Fix missing zero-length check in unbuffered
 write
Content-Language: en-US, de-DE
To: David Howells <dhowells@redhat.com>,
 Christian Brauner <christian@brauner.io>
References: <20240129094924.1221977-1-dhowells@redhat.com>
 <20240129094924.1221977-3-dhowells@redhat.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
In-Reply-To: <20240129094924.1221977-3-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1708333733;3b653c48;
X-HE-SMSGID: 1rbzAY-0007jO-Uv
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
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, Linux kernel regressions list <regressions@lists.linux.dev>, v9fs@lists.linux.dev, Dominique Martinet <asmadeus@codewreck.org>, linux_oss@crudebyte.com, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, ceph-devel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 29.01.24 10:49, David Howells wrote:
> Fix netfs_unbuffered_write_iter() to return immediately if
> generic_write_checks() returns 0, indicating there's nothing to write.
> Note that netfs_file_write_iter() already does this.
> 
> Also, whilst we're at it, put in checks for the size being zero before we
> even take the locks.  Note that generic_write_checks() can still reduce the
> size to zero, so we still need that check.
> 
> Without this, a warning similar to the following is logged to dmesg:
> 
> 	netfs: Zero-sized write [R=1b6da]
> 
> and the syscall fails with EIO, e.g.:
> 
> 	/sbin/ldconfig.real: Writing of cache extension data failed: Input/output error
> 
> This can be reproduced on 9p by:
> 
> 	xfs_io -f -c 'pwrite 0 0' /xfstest.test/foo
> 
> Fixes: 153a9961b551 ("netfs: Implement unbuffered/DIO write support")
> Reported-by: Eric Van Hensbergen <ericvh@kernel.org>
> Link: https://lore.kernel.org/r/ZbQUU6QKmIftKsmo@FV7GG9FTHL/

David, thx for fixing Eric's regression, which I'm tracking.

Christian, just wondering: that patch afaics is sitting in vfs.netfs for
about three weeks now -- is that intentional or did it maybe fell
through the cracks somehow?

> [...]

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
