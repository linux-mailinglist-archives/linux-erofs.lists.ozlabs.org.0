Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0343D7B1E8A
	for <lists+linux-erofs@lfdr.de>; Thu, 28 Sep 2023 15:34:21 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=kuHbRTy2;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RxDwV5k2Kz3dDq
	for <lists+linux-erofs@lfdr.de>; Thu, 28 Sep 2023 23:34:18 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=kuHbRTy2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RxDsH70krz3dwQ
	for <linux-erofs@lists.ozlabs.org>; Thu, 28 Sep 2023 23:31:31 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 4120661B7D;
	Thu, 28 Sep 2023 13:31:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8757C433C7;
	Thu, 28 Sep 2023 13:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695907889;
	bh=r0hQXmQnOijwmkf9TTTA4LIpwyQ/WrWVSuk4R6AtERI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kuHbRTy20f7lg3HEHfC5CwQr73ZEW76NEwiuyFuC4fHFDUzq7PW/X3p6/1J0fOEjH
	 LW7t1SFeuHfQ4TpVtJJ640Htkc5qUwzsHqDT2V7Qq/N+uo31KVka9RtC6X00e3Muls
	 RXvp0qmYJ1iwoCPs67oOQHc6on38orfTcQQ59sBEZPmLfwnXpVYKVzJqsZeJcGi207
	 sHo06mxLrYRbfhQBbZGpn02oypBUXPyJdCCt+NCuzNW54rUjRptNUMXUDSp//yPB12
	 JACxToRH3G3ckvYtcuN6+K+ee48+p8iuMF7mh32CkQ3T8Vmyo4pozahVIdJA8PKZb0
	 i7pnjucvXVpQw==
Date: Thu, 28 Sep 2023 21:31:22 +0800
From: Gao Xiang <xiang@kernel.org>
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH] erofs: update documentation
Message-ID: <ZRWAKh02rWgWo5c+@debian>
Mail-Followup-To: Jingbo Xu <jefflexu@linux.alibaba.com>, chao@kernel.org,
	linux-erofs@lists.ozlabs.org, huyue2@coolpad.com, corbet@lwn.net,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230928131600.84701-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230928131600.84701-1-jefflexu@linux.alibaba.com>
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
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Sep 28, 2023 at 09:16:00PM +0800, Jingbo Xu wrote:
>  - update new features like bloom filter and DEFLATE.
> 
>  - add documentation for the long xattr name prefixes, which was
>    landed upstream since v6.4.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> ---
>  Documentation/filesystems/erofs.rst | 40 ++++++++++++++++++++++++++---
>  1 file changed, 37 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
> index 4654ee57c1d5..522183737be6 100644
> --- a/Documentation/filesystems/erofs.rst
> +++ b/Documentation/filesystems/erofs.rst
> @@ -58,12 +58,14 @@ Here are the main features of EROFS:
>  
>   - Support extended attributes as an option;
>  
> + - Support a bloom filter that speeds up negative extended attribute lookups;
> +
>   - Support POSIX.1e ACLs by using extended attributes;
>  
>   - Support transparent data compression as an option:
> -   LZ4 and MicroLZMA algorithms can be used on a per-file basis; In addition,
> -   inplace decompression is also supported to avoid bounce compressed buffers
> -   and page cache thrashing.
> +   LZ4, MicroLZMA and DEFLATE algorithms can be used on a per-file basis; In
> +   addition, inplace decompression is also supported to avoid bounce compressed
> +   buffers and unnecessary page cache thrashing.
>  
>   - Support chunk-based data deduplication and rolling-hash compressed data
>     deduplication;
> @@ -268,6 +270,38 @@ details.)
>  
>  By the way, chunk-based files are all uncompressed for now.
>  
> +Long extended attribute name prefixes
> +-------------------------------------
> +There are use cases that extended attributes with different values can have

                        ^ where

> +only a few common prefixes (such as overlayfs xattrs).  The predefined prefixes
> +works inefficiently in both image size and runtime performance in such cases.

  ^ work

> +
> +The long xattr name prefixes feature is introduced to address this issue.  The
> +overall idea is that, apart from the existing predefined prefixes, the xattr
> +entry could also refer to user specified long xattr name prefixes, e.g.

                             ^ user-specified

> +"trusted.overlay.".
> +
> +When referring to a long xattr name prefix, the highest bit (bit 7) of
> +erofs_xattr_entry.e_name_index is set, while the lower bits (bit 0-6) as a whole
> +represents the index of the referred long name prefix among all long name
> +prefixes.  Therefore, only the trailing part of the name apart from the long
> +xattr name prefix is stored in erofs_xattr_entry.e_name, which could be empty if
> +the full xattr name matches exactly as its long xattr name prefix.
> +
> +All long xattr prefixes are stored one by one in the packed inode as long as
> +the packed inode is valid, or meta inode otherwise.  The xattr_prefix_count (of

                                ^ the meta inode

> +on-disk superblock) indicates the total number of the long xattr name prefixes,

^ the on-disk superblock

> +while (xattr_prefix_start * 4) indicates the start offset of long name prefixes
> +in the packed/meta inode.  Note that, long extended attribute name prefixes is

                                                                            ^ are

> +disabled if xattr_prefix_count is 0.
> +
> +Each long name prefix is stored in the format: ALIGN({__le16 len, data}, 4),
> +where len represents the total size of the data part.  The data part is actually
> +represented by 'struct erofs_xattr_long_prefix', where base_index represents the
> +index of the predefined xattr name prefix, e.g. EROFS_XATTR_INDEX_TRUSTED for
> +"trusted.overlay." long name prefix, while the infix string kepts the string

                                                               ^ keeps
Thanks,
Gao Xiang
