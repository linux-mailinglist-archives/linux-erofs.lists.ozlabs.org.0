Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FA91F459C
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Jun 2020 20:18:47 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49hJKJ25vfzDqYt
	for <lists+linux-erofs@lfdr.de>; Wed, 10 Jun 2020 04:18:44 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=gmx.com
 (client-ip=82.165.159.13; helo=mout-xforward.gmx.net;
 envelope-from=hsiangkao@gmx.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 secure) header.d=gmx.net header.i=@gmx.net header.a=rsa-sha256
 header.s=badeba3b8450 header.b=fm434SiY; 
 dkim-atps=neutral
Received: from mout-xforward.gmx.net (mout-xforward.gmx.net [82.165.159.13])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49hJK432cWzDqYt
 for <linux-erofs@lists.ozlabs.org>; Wed, 10 Jun 2020 04:18:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1591726698;
 bh=ipkIYOiSeQlE6AvcVindWg1Xo3Wbxtj4ct3QH/620k8=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
 b=fm434SiYxRPS0h9eR6WKJVW78uOFzFpu4ZkykFc/qOTnFsBFxpWFHZ+Q3C7WxMTKl
 5dsT+gUU/BCabb4s1devTuh8KfXfEnfCwnhW13RHmt+uPgojlXIKoOQ4cZXElzN3f1
 V4D5Pb9aFpS5nqhxELMazrInlXBGQwyVMqW1XGeA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from hsiangkao-HP-ZHAN-66-Pro-G1 ([36.63.210.59]) by mail.gmx.com
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1M5fIW-1jbYtG44oE-007Cub; Tue, 09 Jun 2020 20:18:17 +0200
Date: Wed, 10 Jun 2020 02:18:10 +0800
From: Gao Xiang <hsiangkao@gmx.com>
To: Li Guifu <bluce.lee@aliyun.com>
Subject: Re: [PATCH v2] erofs-utils: add a compress limit to source input
 stream
Message-ID: <20200609181810.GA6992@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20200609155009.11805-1-bluce.lee@aliyun.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200609155009.11805-1-bluce.lee@aliyun.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:dG7qsGaHG/r9FKowuquzaJYcD5uT+MVUEiHi61cVlnIczbgF5j/
 VU5y544djevMf2hsYfC1edrtU9vwB+kGDSKX+C/Lnv1a5a9FS3+vHMtw0jAo733n8mHIR94
 M+mxZBhzZfsRxJAklMMbQV3Jx6nRnFeshYivmIo8W4+Zh7iZ3Qp57bl1Kde8ckoIqUwyFnE
 9ynakybZNddz44QG/CDdQ==
X-Spam-Flag: YES
X-UI-Out-Filterresults: junk:10;V03:K0:eztb181kbHM=:hPHdHBS5MhFGqS7XXAvDqU+o
 3ao4lMzWwTqcf99L6Cejmj7dElurJCUO3/zbIb62n7kLV2Hv6IMa6sEfUa9VH2Qx0QtA86ypH
 ffWLa6kDuCYvlk1kXO8wBFxImZgokuou/y/Dr4d25+C2pLWDVL5JPsUqZ/EbgKSNSFj++z6dH
 XfCVKLVREnyWASCyvpQCqXncsZYI7153AKCRkpI4dcQ6mtgh6a2+SsBfmVEvMsFo5cmkVkO5l
 2HY8uBRIdtuvgDHKJIh3ZyDdtYhQDlqBg45X6VdbS1uvRT6vv14uEgM5EFG+n1CgHL4/ywTWS
 g0Z5hVpH8C6GdWSLhSX0NFEmpeVKo75vSPR0+9Uo1xchJsWJkZZHer/n9855ANwJ/x4xL+Uo6
 JPi9vZkCjD0q5cev0OVM4UHctrId4jfpCy4yVn1kmhMmcN+cBYWtUjsNyUbkVKE8DPC7bq2xO
 cbIqMCSp/q1PA8TwnqIa0mRGLCZC0WhHZDjCwlkOVEAaA0R7+L2llZHyAL7D9ILh5cg2aTlCK
 lDFHjukUZ3IXKbjnqReXxZeGrBKS2tnO5pIyMJWB1M1EYxDbopjqIObpqs4969z9W62U+wKPS
 GiGW59+/7uAqjCHkXNhAHH04OaGCMdsVskbsHg0KTnctN1ARbl8/iKyq0rscuXZowMiZNv0b5
 j/cW9veJWRA0Puk6g2SD7fA2dp/lGKROFq0iWin8x9IUDYPwkqtUBzCKthoLWP2NnsOy7btyS
 /jXkY1ipsLOm3zDh6PI+IxoovN8Q3U2Li/B8xzR3LcKHSfO5IokEibVm0xkAUxPs+cjNh15nZ
 MjYc4MTm2RBFSqzZIxem5HOwNDBCeXkxSC8+K5p1lZaubNawYwtBpo7bCkY1m40sxClvSDth5
 IPCosKr4Gq3wXaNFT620UtgwRg7TqXIEE/s7aH30H/YTo6G3I76eX5LRirAXW55mJpJtLbJvy
 34ZvjWuBvMSuwiKE92CN4+XOiluCREMpso1Prt0Yq9wkhPnI59SoiX75gUu05dnFJ8S3l7n+V
 KrHcqRReLdQdvecUDwNq2xP7R+l2jrnXbk4p6wwSi4FmcxL3Mctx8+VHdE89/5w2u4vsNp/A5
 xRHur4py+JjIwwCgWnT7u6Y2/2CA0j5+QU9+zZQPlHc+KoVV/sT5LiZ0PNEx+3+RU369e0LL4
 6sIOuip/6LbFGDgsQqvSD7zl7xhq8Di1q50MH6mT/SKzdIjc1kHNy4gvd6/QlZDlaG0JnJtvi
 08kx7c9AQ9hDF99Rbc5FSU3ZPrvQp9LzmN6/A==
Content-Transfer-Encoding: quoted-printable
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Guifu,

On Tue, Jun 09, 2020 at 11:50:09PM +0800, Li Guifu via Linux-erofs wrote:
> It cause a differential amplification when create binary diff
> image for upgrade. Give a limits to cut compress, so the amplification
> will be limit in the given size.

Try to write a better commit message... and if we limit that by introducin=
g
segment compression (e.g. 4M segment size), we could have the following
benefits:
 - more friendly to block diff (and more details about this);
 - it can also be used for parallel compression in the same file.

>
> Signed-off-by: Li Guifu <bluce.lee@aliyun.com>
> ---
> changes since v1:
>  - fix variable "readcount" use the min data with comprlimits
>
>  include/erofs/internal.h |  1 +
>  lib/compress.c           | 22 +++++++++++++++++-----
>  2 files changed, 18 insertions(+), 5 deletions(-)
>
> diff --git a/include/erofs/internal.h b/include/erofs/internal.h
> index 41da189..367c0b0 100644
> --- a/include/erofs/internal.h
> +++ b/include/erofs/internal.h
> @@ -41,6 +41,7 @@ typedef unsigned short umode_t;
>
>  #define EROFS_ISLOTBITS		5
>  #define EROFS_SLOTSIZE		(1U << EROFS_ISLOTBITS)
> +#define EROFS_COMPR_LIMITS	(1024U * EROFS_BLKSIZ)

Could we put it into cfg and add a new command line
argument for this? how about compress_segment_size?

>
>  typedef u64 erofs_off_t;
>  typedef u64 erofs_nid_t;
> diff --git a/lib/compress.c b/lib/compress.c
> index 6cc68ed..fe1cb09 100644
> --- a/lib/compress.c
> +++ b/lib/compress.c
> @@ -150,7 +150,7 @@ static int vle_compress_one(struct erofs_inode *inod=
e,
>  {
>  	struct erofs_compress *const h =3D &compresshandle;
>  	unsigned int len =3D ctx->tail - ctx->head;
> -	unsigned int count;
> +	unsigned int count =3D 0;
>  	int ret;
>  	static char dstbuf[EROFS_BLKSIZ * 2];
>  	char *const dst =3D dstbuf + EROFS_BLKSIZ;
> @@ -159,7 +159,7 @@ static int vle_compress_one(struct erofs_inode *inod=
e,
>  		bool raw;
>
>  		if (len <=3D EROFS_BLKSIZ) {
> -			if (final)
> +			if (!count || final)

I think you could avoid this trick by adding a counter in
z_erofs_vle_compress_ctx or whatever place...

>  				goto nocompression;
>  			break;
>  		}
> @@ -392,7 +392,7 @@ int erofs_write_compressed_file(struct erofs_inode *=
inode)
>  {
>  	struct erofs_buffer_head *bh;
>  	struct z_erofs_vle_compress_ctx ctx;
> -	erofs_off_t remaining;
> +	erofs_off_t remaining, comprlimits;
>  	erofs_blk_t blkaddr, compressed_blocks;
>  	unsigned int legacymetasize;
>  	int ret, fd;
> @@ -422,10 +422,14 @@ int erofs_write_compressed_file(struct erofs_inode=
 *inode)
>  	ctx.head =3D ctx.tail =3D 0;
>  	ctx.clusterofs =3D 0;
>  	remaining =3D inode->i_size;
> +	comprlimits =3D EROFS_COMPR_LIMITS;
>
>  	while (remaining) {
> -		const u64 readcount =3D min_t(u64, remaining,
> -					    sizeof(ctx.queue) - ctx.tail);
> +		const u64 readcount =3D min_t(u64,
> +					     min_t(u64, remaining,
> +						sizeof(ctx.queue) - ctx.tail),
> +						comprlimits);
> +

We don't need to limit I/O... it would become ineffective
when such limits are small...

>
>  		ret =3D read(fd, ctx.queue + ctx.tail, readcount);
>  		if (ret !=3D readcount) {
> @@ -434,11 +438,19 @@ int erofs_write_compressed_file(struct erofs_inode=
 *inode)
>  		}
>  		remaining -=3D readcount;
>  		ctx.tail +=3D readcount;
> +		comprlimits -=3D readcount;
>
> +compr_continue:
>  		/* do one compress round */
>  		ret =3D vle_compress_one(inode, &ctx, false);
>  		if (ret)
>  			goto err_bdrop;
> +		if (!comprlimits) {
> +			if (ctx.head !=3D ctx.tail)
> +				goto compr_continue;
> +			ctx.clusterofs =3D 0;
> +			comprlimits =3D EROFS_COMPR_LIMITS;

this can be more clearer...

Thanks,
Gao Xiang

> +		}
>  	}
>
>  	/* do the final round */
> --
> 2.17.1
>
