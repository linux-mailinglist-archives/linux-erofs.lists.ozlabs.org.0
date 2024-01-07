Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5948264F4
	for <lists+linux-erofs@lfdr.de>; Sun,  7 Jan 2024 17:09:39 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Je4QSk1X;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4T7Mb33gHmz3bT8
	for <lists+linux-erofs@lfdr.de>; Mon,  8 Jan 2024 03:09:35 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Je4QSk1X;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:40e1:4800::1; helo=sin.source.kernel.org; envelope-from=horms@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4T7MZw513dz2xwH
	for <linux-erofs@lists.ozlabs.org>; Mon,  8 Jan 2024 03:09:28 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 63A35CE0B6E;
	Sun,  7 Jan 2024 16:09:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CDAAC433C8;
	Sun,  7 Jan 2024 16:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704643764;
	bh=vtEdJ8x0t9Cig7F/OQ58765CvJpN5U3pnuPNn8bEtX0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Je4QSk1Xsi5jvomPOikxCGlVFwk8iqkAbNF6aVYGaBGYI1jkUw+CADMBs0/wZQr36
	 xy22SDkRZMP5sMid5EvoeH3h/Kwf68Tcbn77GX8EDm+cjFQlFTs6TguY93Et6BFDPv
	 UlIs+e2Jheeb2/ck0biFbtZrf0Vw9LMCbIX3TaJmqJZgdrEhhfSfxUMIfjU8lZxJF7
	 Q+aCdvG3kA6VLZkjLHS+Vga8pwGe2Z6VghL3LobYtAq3sM2rUGAW8uNlztGT7uqIEc
	 x+WdUyce0Wh+SeZcYOdm2MG39rO2B8pkIyqp3viKoDClILrK1BwA1eJJXlvP2hGICM
	 kq7yyH7rMCZgg==
Date: Sun, 7 Jan 2024 16:09:16 +0000
From: Simon Horman <horms@kernel.org>
To: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 1/5] cachefiles: Fix __cachefiles_prepare_write()
Message-ID: <20240107160916.GA129355@kernel.org>
References: <20240103145935.384404-1-dhowells@redhat.com>
 <20240103145935.384404-2-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103145935.384404-2-dhowells@redhat.com>
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
Cc: Dominique Martinet <asmadeus@codewreck.org>, linux-mm@kvack.org, Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Steve French <smfrench@gmail.com>, linux-cachefs@redhat.com, Gao Xiang <hsiangkao@linux.alibaba.com>, Ilya Dryomov <idryomov@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, ceph-devel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, Christian Brauner <christian@brauner.io>, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, Yiqun Leng <yqleng@linux.alibaba.com>, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Jan 03, 2024 at 02:59:25PM +0000, David Howells wrote:
> Fix __cachefiles_prepare_write() to correctly determine whether the
> requested write will fit correctly with the DIO alignment.
> 
> Reported-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Tested-by: Yiqun Leng <yqleng@linux.alibaba.com>
> Tested-by: Jia Zhu <zhujia.zj@bytedance.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: linux-cachefs@redhat.com
> cc: linux-erofs@lists.ozlabs.org
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-mm@kvack.org
> ---
>  fs/cachefiles/io.c | 28 +++++++++++++++++-----------
>  1 file changed, 17 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
> index bffffedce4a9..7529b40bc95a 100644
> --- a/fs/cachefiles/io.c
> +++ b/fs/cachefiles/io.c
> @@ -522,16 +522,22 @@ int __cachefiles_prepare_write(struct cachefiles_object *object,
>  			       bool no_space_allocated_yet)
>  {
>  	struct cachefiles_cache *cache = object->volume->cache;
> -	loff_t start = *_start, pos;
> -	size_t len = *_len, down;
> +	unsigned long long start = *_start, pos;
> +	size_t len = *_len;
>  	int ret;
>  
>  	/* Round to DIO size */
> -	down = start - round_down(start, PAGE_SIZE);
> -	*_start = start - down;
> -	*_len = round_up(down + len, PAGE_SIZE);
> -	if (down < start || *_len > upper_len)
> +	start = round_down(*_start, PAGE_SIZE);
> +	if (start != *_start) {
> +		kleave(" = -ENOBUFS [down]");
> +		return -ENOBUFS;
> +	}
> +	if (*_len > upper_len) {
> +		kleave(" = -ENOBUFS [up]");
>  		return -ENOBUFS;
> +	}
> +
> +	*_len = round_up(len, PAGE_SIZE);
>  
>  	/* We need to work out whether there's sufficient disk space to perform
>  	 * the write - but we can skip that check if we have space already
> @@ -542,7 +548,7 @@ int __cachefiles_prepare_write(struct cachefiles_object *object,
>  
>  	pos = cachefiles_inject_read_error();
>  	if (pos == 0)
> -		pos = vfs_llseek(file, *_start, SEEK_DATA);
> +		pos = vfs_llseek(file, start, SEEK_DATA);
>  	if (pos < 0 && pos >= (loff_t)-MAX_ERRNO) {

Hi David,

I realise these patches have been accepted, but I have a minor nit:
pos is now unsigned, and so cannot be less than zero.

Flagged by Smatch and Coccinelle.

>  		if (pos == -ENXIO)
>  			goto check_space; /* Unallocated tail */
> @@ -550,7 +556,7 @@ int __cachefiles_prepare_write(struct cachefiles_object *object,
>  					  cachefiles_trace_seek_error);
>  		return pos;
>  	}
> -	if ((u64)pos >= (u64)*_start + *_len)
> +	if (pos >= start + *_len)
>  		goto check_space; /* Unallocated region */
>  
>  	/* We have a block that's at least partially filled - if we're low on
> @@ -563,13 +569,13 @@ int __cachefiles_prepare_write(struct cachefiles_object *object,
>  
>  	pos = cachefiles_inject_read_error();
>  	if (pos == 0)
> -		pos = vfs_llseek(file, *_start, SEEK_HOLE);
> +		pos = vfs_llseek(file, start, SEEK_HOLE);
>  	if (pos < 0 && pos >= (loff_t)-MAX_ERRNO) {

Ditto.

>  		trace_cachefiles_io_error(object, file_inode(file), pos,
>  					  cachefiles_trace_seek_error);
>  		return pos;
>  	}
> -	if ((u64)pos >= (u64)*_start + *_len)
> +	if (pos >= start + *_len)
>  		return 0; /* Fully allocated */
>  
>  	/* Partially allocated, but insufficient space: cull. */
> @@ -577,7 +583,7 @@ int __cachefiles_prepare_write(struct cachefiles_object *object,
>  	ret = cachefiles_inject_remove_error();
>  	if (ret == 0)
>  		ret = vfs_fallocate(file, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
> -				    *_start, *_len);
> +				    start, *_len);
>  	if (ret < 0) {
>  		trace_cachefiles_io_error(object, file_inode(file), ret,
>  					  cachefiles_trace_fallocate_error);
> 
