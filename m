Return-Path: <linux-erofs+bounces-255-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE85AA008A
	for <lists+linux-erofs@lfdr.de>; Tue, 29 Apr 2025 05:31:23 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Zmm7Y05Lzz301N;
	Tue, 29 Apr 2025 13:31:21 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.178.84.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1745897480;
	cv=none; b=Os+N24iXO4SOhO/GLyqsxytNFTYHj6PPOp3xMvpux0ktkOS7kBNPayA97v6bVO/wNhaO2to230TfuZGrbTvRdI5DVpRvGF4o588VgeedecfqQa7/5jsBI62eSXM4jVK8sM5VYKS6kCSxj0aio1dK6oeMNtImSfkIXsgvauEU+t3JKlH5pS0Z+L2e0iyRVFBDPF5PbMe4pu9LBkKY08eOFSVDQ+TAPD/+ddcQb7fADZMdy7TyzNMjF3Rr6DTaQq1UfU1P0WPlSvsWvsqd/xp1+1WZHGC6fxWZ7naVpxBNoIHizNa3D0Y7jFIrwtO5jLhmgjwObXtan0RW42f4Dp234w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1745897480; c=relaxed/relaxed;
	bh=eSGpuPjstHcFaFXTQJZ2b27qd7E871vCMkQXp51Sa6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F2mu31q35vNJ8LOHzV7FywtOFR73fZ2xPbaaxBPCd+soZt5PXcKUjer4IF+KtImG6PlsJt7sEbxj8ZnG0ZzzvGUhfUvSO3Qw+hWgE9EPWa7R0siPj28MLN9WDAK7WABnu9bmw66eaXikBgrp2qJUW+nZfI2vFF2FTv2kwSnl5s4DGcihpxF8BxXcb+RbABvxEN4g/epsuj4PFuSjT0MGxB5Rl4E9biROSvPxnWxBmOEYbyv1h7d+bXbitZW0c/tnLbDuZX01LX6F2Sfjjcta6d/6hAOI/wkuR3RXVvCctpnlGcrGYSjd/+C16+SOZh4znTt6ngvIPm53+g9Kb5aSzQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dIEuhtQ+; dkim-atps=neutral; spf=pass (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dIEuhtQ+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Zmm7W5MsYz2yjV
	for <linux-erofs@lists.ozlabs.org>; Tue, 29 Apr 2025 13:31:19 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 467C55C3EF8;
	Tue, 29 Apr 2025 03:28:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BBD5C4CEE3;
	Tue, 29 Apr 2025 03:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745897475;
	bh=CuL+YpcnQKY0haqmcdUS5IRj6Y2DmxCYuPRov7XSKeM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dIEuhtQ+D06yhlDPd6yZl46Dnjate2a62MZZ63YCcohRNIRPPn2OsBVVldNIcKfQJ
	 0cO7oYXa3CQWMgvBZejTvQ7nYn+QUjJ/r6YhuvzhbeydVKqneLGXS2h0eW9itxwre3
	 mQ5c3E64QGvphmTwEuGYP3DbeXJ9Si4/q94t9iyv9Le3DypRJWBcOF/Ti19ErpGnej
	 BXTqtk6hLresQcxJn3cJsqzLA802Q8vRX998aAlw5eGaf66mzsQIOSH383RJVkjvze
	 F0KgCeeL2FmsT3IIFLgmktCMsAXXqQ8YzmJe/lW0SEAwD5IpBtMsQ7Jh+dRe4AFhJl
	 ZfcuekcpExWbw==
Date: Tue, 29 Apr 2025 11:31:05 +0800
From: Gao Xiang <xiang@kernel.org>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: xiang@kernel.org, chao@kernel.org, zbestahu@gmail.com,
	jefflexu@linux.alibaba.com, dhavale@google.com,
	linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] erofs: encode file handle with the internal helpers
Message-ID: <aBBH+Wrwa1xXFGmo@debian>
Mail-Followup-To: Hongbo Li <lihongbo22@huawei.com>, xiang@kernel.org,
	chao@kernel.org, zbestahu@gmail.com, jefflexu@linux.alibaba.com,
	dhavale@google.com, linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
References: <20250429011139.686847-1-lihongbo22@huawei.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250429011139.686847-1-lihongbo22@huawei.com>
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Hongbo,

I think the subject can be updated as:
`erofs-utils: fix file handle encoding for 64-bit NIDs`

On Tue, Apr 29, 2025 at 01:11:39AM +0000, Hongbo Li wrote:
> In erofs, the inode number has the location information of
> files. The default encode_fh uses the ino32, this will lack
> of some information when the file is too big. So we need
> the internal helpers to encode filehandle.
> 
> Since i_generation in EROFS is not used, here we only encode
> the nid into file handle when it is exported. So it is easy
> to parse the dentry from file handle.

If `FILEID_INO64_GEN_PARENT` is used, I don't think
the generation number should be emitted, as documented as:

`
/*
 * 64 bit inode number, 32 bit generation number.
 */
FILEID_INO64_GEN = 0x81,

/*
 * 64 bit inode number, 32 bit generation number,
 * 64 bit parent inode number, 32 bit parent generation.
 */
FILEID_INO64_GEN_PARENT = 0x82,
` 

Even the generation number is 0 but we might use
i_generation for some remote update use cases
in the future.

> 
> It is easy to reproduce test:
>   1. prepare an erofs image with nid bigger than UINT_MAX
>   2. mount -t erofs foo.img /mnt/erofs
>   3. set exportfs with configuration: /mnt/erofs *(rw,sync,
>      no_root_squash)
>   4. mount -t nfs $IP:/mnt/erofs /mnt/nfs
>   5. md5sum /mnt/nfs/foo # foo is the file which nid bigger
>      than UINT_MAX.
> For overlayfs case, the under filesystem's file handle is
> encoded in ovl_fb.fid, it is same as NFS's case.

Can we have a way to add a testcase for the overlayfs case:
since it's somewhat complex to write a testcase with nfs
above.

> 
> Fixes: 3e917cc305c6 ("erofs: make filesystem exportable")
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>  fs/erofs/super.c | 51 ++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 43 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index cadec6b1b554..8f787c47e04d 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -511,24 +511,59 @@ static int erofs_fc_parse_param(struct fs_context *fc,
>  	return 0;
>  }
>  
> -static struct inode *erofs_nfs_get_inode(struct super_block *sb,
> -					 u64 ino, u32 generation)
> +static int erofs_encode_fh(struct inode *inode, u32 *fh, int *max_len,
> +			   struct inode *parent)
>  {
> -	return erofs_iget(sb, ino);
> +	int len = parent ? 4 : 2;
> +	erofs_nid_t nid;
> +
> +	if (*max_len < len) {
> +		*max_len = len;
> +		return FILEID_INVALID;
> +	}
> +
> +	nid = EROFS_I(inode)->nid;
> +	fh[0] = (u32)(nid >> 32);
> +	fh[1] = (u32)(nid & 0xffffffff);
> +
> +	if (parent) {
> +		nid = EROFS_I(parent)->nid;
> +
> +		fh[2] = (u32)(nid >> 32);
> +		fh[3] = (u32)(nid & 0xffffffff);
> +	}
> +
> +	*max_len = len;
> +	return parent ? FILEID_INO64_GEN_PARENT : FILEID_INO64_GEN;
>  }
>  
>  static struct dentry *erofs_fh_to_dentry(struct super_block *sb,
>  		struct fid *fid, int fh_len, int fh_type)
>  {
> -	return generic_fh_to_dentry(sb, fid, fh_len, fh_type,
> -				    erofs_nfs_get_inode);
> +	erofs_nid_t nid;
> +
> +	if ((fh_type != FILEID_INO64_GEN &&
> +	     fh_type != FILEID_INO64_GEN_PARENT) || fh_len < 2)
> +		return NULL;
> +
> +	nid = (u64) fid->raw[0] << 32;
> +	nid |= (u64) fid->raw[1];
> +

Redundant new line.

> +	return d_obtain_alias(erofs_iget(sb, nid));
>  }
>  
>  static struct dentry *erofs_fh_to_parent(struct super_block *sb,
>  		struct fid *fid, int fh_len, int fh_type)
>  {
> -	return generic_fh_to_parent(sb, fid, fh_len, fh_type,
> -				    erofs_nfs_get_inode);
> +	erofs_nid_t nid;
> +
> +	if (fh_type != FILEID_INO64_GEN_PARENT || fh_len < 4)
> +		return NULL;
> +
> +	nid = (u64) fid->raw[2] << 32;
> +	nid |= (u64) fid->raw[3];
> +

Same here.

Thanks,
Gao Xiang

