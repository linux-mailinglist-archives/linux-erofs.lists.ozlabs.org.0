Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF6E9CF586
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Nov 2024 21:11:50 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xqp800jbKz3bLS
	for <lists+linux-erofs@lfdr.de>; Sat, 16 Nov 2024 07:11:44 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=136.144.140.114
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731701501;
	cv=none; b=bRBgwnCpMXBOSKpgjB5oUtA3UHGTykwrdcQeuL956OsbcLUKD4jmHKlRD0i6AIvrXx32AkVfHAhxFzE0Z6IJ4Q5LUTRflMGrjtyKEGknjdJbGrh+fPZcpv+Bybre9ivUbeGPbug2PsWTVSRkKDVcTem39C6YNz63E/+m3zYBicrspzAxggM2qgUAeM4Co7U9suFzUC8EL1zITWtq7RzsDC26NUT1f4KjH8mEGnapkiDGzGVDfWa2EzP6a34vRJXSYtVgNlxjq9UJCve5LinDZ2T0Qhiw7/AwTv8y0nfnLmZLKElpgUuPBpe9M/jwH2i6okkFv5iRPF03Z77GmjW4dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731701501; c=relaxed/relaxed;
	bh=1da3t6x+fQO90iML1j96gm3n46oBKBuH21WrjAs484Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GcE+pZ8ZR+bTiDkVJWvyBvSLrjoqgAJx/8l2SF4ftS+PkA8gCPA7SKInjLG5W/7KwWgNtSwPgdt48t318fcUktQ0W7if0C09N+hXfMmEdG6IrI+VEQsPIdA4bmBGw7bSMw109zlYtdiTua6f20Xs3IuLir42Gtn8p67rMs/ltpJt69ld68zXv2zUfmbE3LHVc1LPA3OcueOoYfwx9Kijl3MCT9bouqz7sGzsVbXGkdrE4wk640pzjUqttu+qiB0QylU4FlAwOw8jPbDiCdL0qJ5c9QpS9iROiv9sWMjLAakqGLHhAYZnmJr34lRlTNXCMkb5TbJYCkxQKK4R7b1LHA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl; dkim=pass (4096-bit key; secure) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.a=rsa-sha256 header.s=key header.b=cHfjERfY; dkim-atps=neutral; spf=pass (client-ip=136.144.140.114; helo=bout3.ijzerbout.nl; envelope-from=kees@ijzerbout.nl; receiver=lists.ozlabs.org) smtp.mailfrom=ijzerbout.nl
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl
Authentication-Results: lists.ozlabs.org;
	dkim=pass (4096-bit key; secure) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.a=rsa-sha256 header.s=key header.b=cHfjERfY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ijzerbout.nl (client-ip=136.144.140.114; helo=bout3.ijzerbout.nl; envelope-from=kees@ijzerbout.nl; receiver=lists.ozlabs.org)
X-Greylist: delayed 571 seconds by postgrey-1.37 at boromir; Sat, 16 Nov 2024 07:11:38 AEDT
Received: from bout3.ijzerbout.nl (bout3.ijzerbout.nl [136.144.140.114])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xqp7t6NmLz2yMP
	for <linux-erofs@lists.ozlabs.org>; Sat, 16 Nov 2024 07:11:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ijzerbout.nl; s=key;
	t=1731700922; bh=kTKcI7rAzWbnFx3Ax+rm7FwXA+3N7eD2+FIgr2oP7kg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cHfjERfY1/rAAYikk2QNbgGZwf8P76vzMPzQy0d38kXIISsg6cIu+TyONdT+1XA9d
	 dnHVgoiBK/U+Ro40XfKwbu0kYfn03m1yCclV6oORc5HF1o34pGsZmNOzLqCRhoSAH+
	 bVBVKjSR8nU5xVOSXJDnjtUPKMWJyAKcxgCzdVYtvgvWOYTpPivdsVJJLPoI2YBvDv
	 YfdiF9W8RjIdBQ3sShsTkRNGpSMMNgugIUwUnbAbuBOE3sUaWPyxt1eEG2fB+9Ojh6
	 clox9OhOuRhluFaZfycU5bW3lyo10aEcZYWTp4LajDyqEsevUsJGiGsQGbbtmUsAGw
	 zM/4cMlJZi0LxU8Iz7pva37mepW1yCxANkesaw/WVrlzxEL2BBIYcvn4Ns+IWj/Pl9
	 3xbzlIzCPENc15jBiKC3X5tUuOq6P+iM8sUBOmiD5JyFBSMXeuSuAu1HJ7Bbd4FyE/
	 PBYXB2Di/tBAed2LS23SuHO40UV3Hf8QS8rw4yLte6S2qH/ZvWXvDoEQF9H7Wt0ZGA
	 ysGoIjNlPNdRkfpyOTMNcAHMh4u1X1WsE3uuWa2Onkmd9yvzplXQr4YqjLyvanucka
	 NQVkL1t60WZZNPUDpdDPVX+iR4y9mn87zk2epeaPRvd1Pow2ipBYG6a3996OgEmpKk
	 fItX9fSiHH5XvvnpO8iKLYxA=
Received: from [IPV6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a] (racer.ijzerbout.nl [IPv6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a])
	by bout3.ijzerbout.nl (Postfix) with ESMTPSA id 7CF6618A7E9;
	Fri, 15 Nov 2024 21:02:00 +0100 (CET)
Message-ID: <b7135da8-a04f-48ec-957f-09542178b861@ijzerbout.nl>
Date: Fri, 15 Nov 2024 21:01:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/33] netfs: Abstract out a rolling folio buffer
 implementation
To: David Howells <dhowells@redhat.com>,
 Christian Brauner <christian@brauner.io>, Steve French <smfrench@gmail.com>,
 Matthew Wilcox <willy@infradead.org>
References: <20241108173236.1382366-1-dhowells@redhat.com>
 <20241108173236.1382366-8-dhowells@redhat.com>
Content-Language: en-US
From: Kees Bakker <kees@ijzerbout.nl>
In-Reply-To: <20241108173236.1382366-8-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.0
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
Cc: Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Shyam Prasad N <sprasad@microsoft.com>, v9fs@lists.linux.dev, netdev@vger.kernel.org, Dominique Martinet <asmadeus@codewreck.org>, Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, Tom Talpey <tom@talpey.com>, linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org, linux-mm@kvack.org, netfs@lists.linux.dev, Marc Dionne <marc.dionne@auristor.com>, Gao Xiang <hsiangkao@linux.alibaba.com>, Ilya Dryomov <idryomov@gmail.com>, Eric Van Hensbergen <ericvh@kernel.org>, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Op 08-11-2024 om 18:32 schreef David Howells:
> A rolling buffer is a series of folios held in a list of folio_queues.  New
> folios and folio_queue structs may be inserted at the head simultaneously
> with spent ones being removed from the tail without the need for locking.
>
> The rolling buffer includes an iov_iter and it has to be careful managing
> this as the list of folio_queues is extended such that an oops doesn't
> incurred because the iterator was pointing to the end of a folio_queue
> segment that got appended to and then removed.
>
> We need to use the mechanism twice, once for read and once for write, and,
> in future patches, we will use a second rolling buffer to handle bounce
> buffering for content encryption.
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> ---
>   fs/netfs/Makefile              |   1 +
>   fs/netfs/buffered_read.c       | 119 ++++-------------
>   fs/netfs/direct_read.c         |  14 +-
>   fs/netfs/direct_write.c        |  10 +-
>   fs/netfs/internal.h            |   4 -
>   fs/netfs/misc.c                | 147 ---------------------
>   fs/netfs/objects.c             |   2 +-
>   fs/netfs/read_pgpriv2.c        |  32 ++---
>   fs/netfs/read_retry.c          |   2 +-
>   fs/netfs/rolling_buffer.c      | 225 +++++++++++++++++++++++++++++++++
>   fs/netfs/write_collect.c       |  19 +--
>   fs/netfs/write_issue.c         |  26 ++--
>   include/linux/netfs.h          |  10 +-
>   include/linux/rolling_buffer.h |  61 +++++++++
>   include/trace/events/netfs.h   |   2 +
>   15 files changed, 375 insertions(+), 299 deletions(-)
>   create mode 100644 fs/netfs/rolling_buffer.c
>   create mode 100644 include/linux/rolling_buffer.h
> [...]
> diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
> index 88f2adfab75e..0722fb9919a3 100644
> --- a/fs/netfs/direct_write.c
> +++ b/fs/netfs/direct_write.c
> @@ -68,19 +68,19 @@ ssize_t netfs_unbuffered_write_iter_locked(struct kiocb *iocb, struct iov_iter *
>   		 * request.
>   		 */
>   		if (async || user_backed_iter(iter)) {
> -			n = netfs_extract_user_iter(iter, len, &wreq->iter, 0);
> +			n = netfs_extract_user_iter(iter, len, &wreq->buffer.iter, 0);
>   			if (n < 0) {
>   				ret = n;
>   				goto out;
>   			}
> -			wreq->direct_bv = (struct bio_vec *)wreq->iter.bvec;
> +			wreq->direct_bv = (struct bio_vec *)wreq->buffer.iter.bvec;
>   			wreq->direct_bv_count = n;
>   			wreq->direct_bv_unpin = iov_iter_extract_will_pin(iter);
>   		} else {
> -			wreq->iter = *iter;
> +			wreq->buffer.iter = *iter;
>   		}
>   
> -		wreq->io_iter = wreq->iter;
> +		wreq->buffer.iter = wreq->buffer.iter;
Is this correct, an assignment to itself?
>   	}
>   
>   	__set_bit(NETFS_RREQ_USE_IO_ITER, &wreq->flags);
> [...]

