Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BC64779EA6D
	for <lists+linux-erofs@lfdr.de>; Wed, 13 Sep 2023 16:06:41 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=AeJGmr0U;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Rm2Lj6XGmz3hwg
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Sep 2023 00:06:37 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=AeJGmr0U;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.73.55; helo=sin.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Rm1xH6LvMz3dWZ
	for <linux-erofs@lists.ozlabs.org>; Wed, 13 Sep 2023 23:48:03 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by sin.source.kernel.org (Postfix) with ESMTPS id 94536CE1F1B;
	Wed, 13 Sep 2023 13:48:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42C9DC433C8;
	Wed, 13 Sep 2023 13:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694612879;
	bh=jJGp9xbCBBWiP4s30EbvcWuYmO9bPTRYaT7OCr64m2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AeJGmr0UIzigIAdUZQ7hx0hfdQxO6DwZ4luLBiBMlewROzpPyQRapfyhxKzm/n4nI
	 mqFl7GisItYGem5YKljOIcL+vlT8HW4250OWDrsmdF+vzcg2jLeUcdO4USOp9i23X8
	 NfIJ4v45AyRDEUCHwmG4wNZubqo4DL3eLDH712w0dLGo56jA0uhbxJzWFMzVzA3Wpm
	 w7/e3hYsUCvhTzJsN+v5ZATHrU9pI6zH+0PQg0Wu1OiL2FjgrtuXb4aNmMTHyPWRoj
	 tpC3ZratbOqaMB7prgsrayaI1NlNm5cM7DgvD7lXGraXP3knRbY9cKgzW/CKvacriH
	 q3TMMsuH8j47A==
Date: Wed, 13 Sep 2023 21:47:52 +0800
From: Gao Xiang <xiang@kernel.org>
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v8 8/8] erofs-utils: mkfs: add `--ovlfs-strip` option
Message-ID: <ZQG9iBAACAz/XC1F@debian>
Mail-Followup-To: Jingbo Xu <jefflexu@linux.alibaba.com>,
	hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org
References: <20230913120304.15741-1-jefflexu@linux.alibaba.com>
 <20230913120304.15741-9-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230913120304.15741-9-jefflexu@linux.alibaba.com>
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
Cc: hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Sep 13, 2023 at 08:03:03PM +0800, Jingbo Xu wrote:
> Add `--ovlfs-strip=[0|1]` option for tarfs and rebuild mode for now
> in order to control whether some overlayfs related stuffs (e.g.
> whiteout files, OVL_XATTR_OPAQUE and OVL_XATTR_ORIGIN xattrs) are
> finally stripped.
> 
> This option is disabled by default for mkfs, that is, the overlayfs
> related stuffs described above are kept in the image by default.
> 
> Specify `--ovlfs-strip=1` explicitly to strip these stuffs.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---

...

> diff --git a/lib/xattr.c b/lib/xattr.c
> index e3a1b44..fffccb4 100644
> --- a/lib/xattr.c
> +++ b/lib/xattr.c
> @@ -499,11 +499,29 @@ int erofs_setxattr(struct erofs_inode *inode, char *key,
>  	return erofs_xattr_add(&inode->i_xattrs, item);
>  }
>  
> +static void erofs_clearxattr(struct erofs_inode *inode, const char *key)

I rename it as erofs_removexattr().

Thanks,
Gao Xiang
