Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id C26C71FFE74
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Jun 2020 01:05:40 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49nyG76kgdzDrND
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Jun 2020 09:05:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=gmx.com
 (client-ip=82.165.159.41; helo=mout-xforward.gmx.net;
 envelope-from=hsiangkao@gmx.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 secure) header.d=gmx.net header.i=@gmx.net header.a=rsa-sha256
 header.s=badeba3b8450 header.b=gLrTTGuy; 
 dkim-atps=neutral
Received: from mout-xforward.gmx.net (mout-xforward.gmx.net [82.165.159.41])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49nyFy2XjXzDrMS
 for <linux-erofs@lists.ozlabs.org>; Fri, 19 Jun 2020 09:05:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1592521513;
 bh=X5N6U415u96j72FFniSZuWYSy1q8ts77UBmuir8ERkM=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
 b=gLrTTGuyVamJZJp3/7671QxutJ5Ax/mWQVgYkzeTjNmImIgVRRlA6mw+kjgzTTges
 5ND15XHQmJz9mC1jzFncHJC7+otrnsrtqL/DYGWqjzFe3RzBgKZu1amprMt5Vpidt2
 CuDIKuVx1a8fPezRhac2q1tmaDiYtyBccGvNJPnw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from hsiangkao-HP-ZHAN-66-Pro-G1 ([36.63.211.116]) by mail.gmx.com
 (mrgmx104 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1MNbox-1jVkjT1eaB-00P47J; Fri, 19 Jun 2020 01:05:13 +0200
Date: Fri, 19 Jun 2020 07:05:06 +0800
From: Gao Xiang <hsiangkao@gmx.com>
To: Li Guifu <bluce.lee@aliyun.com>
Subject: Re: [PATCH v4] erofs-utils: introduce segment compression
Message-ID: <20200618230505.GA15482@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20200618162657.3136-1-bluce.lee@aliyun.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618162657.3136-1-bluce.lee@aliyun.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:VEhBdKYlxan0bKFwdlwZA4AnXbn1J5trYUC9MZyKfeGR3Yv+Zhm
 PqcFHUOLsTqf7wYE2jWXrcXQPpju8fgLVEflihleoiL+/cirLeh93zRfukVcrwXfyNVDwnw
 u3ZLPNXAx4Mblfwdrc2HpWC+G0IxjkTnjq50/nhgbCA7gOEQpKre/dUvO0b1I+SFfaWXtV5
 FSXcUaYwn0vTbQgV3zZGg==
X-Spam-Flag: YES
X-UI-Out-Filterresults: junk:10;V03:K0:b5FsBC9dIMY=:Rj4Vjxk5hERrRQIDE/1Dg1WT
 j2GmvYx49Vw9JmCRS/F1lTEh8QqalbI6lb9qE5QgGHkSOqBGoO5ZD5EbFYg7InfxfhtnRO+Qu
 9dXezFrRGkBFLtsYESJBaqK8+mByYgviu5HAAQRSNIlT615hTNt5ByE+wep+Uk84Fap5umwRM
 Y75fZfkIJFn1UAFI1UNTZFsuE8aqXIn1yaOlq0VMjmn0DzKo5IfIGRqX8sAy9PDpVqghb25VS
 s7S58z3HD96qHaJPM31aY/kzWQghk2CU2q8MRIIesMTmu3OegN/z3lBKbGNH61w9oQWTdrG20
 a+8NcmuSISATdu6HEzM+dqKMf7x51rzSlivstgojL1ltPkF5X1V7s/avHGpSJphuRQCd+V55F
 KjHWc3fwyuUX/cCU2hXFzWDISOW0NttBRybDOwECyXPgbwBtpG/GqgIl6/5jD4W+mn/+3cE4Y
 2q1ZEZRR1ELVvlokDqcp59Oi/sGVXHonUTUFjJiUvuHSIhA9qYoxJ6KDfbcEDuuxVZGgpRoXC
 Y8XuHCLa/DAbqwrEsUwCp2OTqKp+aP5Ha7xbq3CZ+XgcCdbMfTfJA35b3mCkDbPiyZPQRauES
 Lio5y+N/fzwOD2HUVlMjIMYvQSJlJ+q9DxYzh4tOY3BXs3GTrGunbS6CNnO+azUAQsdR3pjto
 /HU3o3dg+nnHWAi4CC0Nc2cpeU/ngBvfiEKKkKzLW+f/yq++5OIbg3e6jlt8RSyQKRrgasVQP
 nep4jwG8ItL78DcZk1HN4/YwpmhH0eGMYtTQLcgFcAeZwX3TOD2nUhf0FkOJ5PNHtYlk43MiV
 A8EkE6WR4vnhgD62ZSa8EfMMLJGYirecEyo1YyXsAPiEixLg2X50jlo8uiV9/PN485VuVJhnc
 XE1as9qo/QhFq9FjSvl0vkqi7lgrs8+RNoZhGSvvI84EqBESXCL74ayWtVrXlvSMgYo1rjND3
 21Vb96st4dplrmvYARf4MaE3wpQZSm4PPkhZoTiJLco8yIpja80MaqxZzFHVeCzI8G9yF81wh
 nqjIcqCbRRi4llxDWBgsm2HvE6d+4GeqxLubmYKiD57v2PxY/3E0wt0ANtCIiSyHuOGqbv0db
 dSEsQ2TB3b3Ryk42i7TJq1jmkhOFKqck7qXnqg+rRazRF6ouWR9JT8uAYjAXRdG/dGyT70HIp
 21LGR04uCEuc81Yg/d+mgY6elfqtH2/9KI6qWgciLTMgjRvWZ+NgHmG6dsVNalGQd8J4C2SMv
 qB8cp0r/8EURB5kIBNuJrc6QiebYhg+BMcbCw==
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

On Fri, Jun 19, 2020 at 12:26:57AM +0800, Li Guifu via Linux-erofs wrote:
> Support segment compression which seperates files in several logic
> units (segments) and each segment is compressed independently.
>
> Advantages:
>  - more friendly for data differencing;
>  - it can also be used for parallel compression in the same file later.
>
> Signed-off-by: Li Guifu <bluce.lee@aliyun.com>
> ---
> Changes since v3 suggest by Gao Xiang<hsiangkao@gmx.com>:
>  - add 'S#' parameter to custome compression segment size
>  - move limit logic to size decrease
>
>  include/erofs/config.h |  1 +
>  lib/compress.c         |  8 ++++++--
>  lib/config.c           |  1 +
>  mkfs/main.c            | 16 +++++++++++++++-

Just do a quick response for this, and will test it later.

First, You might need to update the manpage as well.

>  4 files changed, 23 insertions(+), 3 deletions(-)
>
> diff --git a/include/erofs/config.h b/include/erofs/config.h
> index 2f09749..9125c1e 100644
> --- a/include/erofs/config.h
> +++ b/include/erofs/config.h
> @@ -36,6 +36,7 @@ struct erofs_configure {
>  	char *c_src_path;
>  	char *c_compr_alg_master;
>  	int c_compr_level_master;

u64 c_compr_segsize;

> +	unsigned int c_compr_seg_size;	/* max segment compress size */
>  	int c_force_inodeversion;
>  	/* < 0, xattr disabled and INT_MAX, always use inline xattrs */
>  	int c_inline_xattr_tolerance;
> diff --git a/lib/compress.c b/lib/compress.c
> index 6cc68ed..eb024aa 100644
> --- a/lib/compress.c
> +++ b/lib/compress.c
> @@ -32,6 +32,7 @@ struct z_erofs_vle_compress_ctx {
>
>  	erofs_blk_t blkaddr;	/* pointing to the next blkaddr */
>  	u16 clusterofs;
> +	unsigned int comprlimits;

How about the name "segavail"; ?

u64 segavail;


>  };
>
>  #define Z_EROFS_LEGACY_MAP_HEADER_SIZE	\
> @@ -163,8 +164,7 @@ static int vle_compress_one(struct erofs_inode *inod=
e,
>  				goto nocompression;
>  			break;
>  		}

I think we might add "if (segavail < EROFS_BLKSIZE) goto nocompression;"
since it seems better.

> -
> -		count =3D len;
> +		count =3D min(len, ctx->comprlimits);
>  		ret =3D erofs_compress_destsize(h, compressionlevel,
>  					      ctx->queue + ctx->head,
>  					      &count, dst, EROFS_BLKSIZ);
> @@ -202,6 +202,9 @@ nocompression:
>
>  		++ctx->blkaddr;
>  		len -=3D count;
> +		ctx->comprlimits -=3D count;
> +		if (!ctx->comprlimits)
> +			ctx->comprlimits =3D cfg.c_compr_seg_size;
>
>  		if (!final && ctx->head >=3D EROFS_CONFIG_COMPR_MAX_SZ) {
>  			const unsigned int qh_aligned =3D
> @@ -422,6 +425,7 @@ int erofs_write_compressed_file(struct erofs_inode *=
inode)
>  	ctx.head =3D ctx.tail =3D 0;
>  	ctx.clusterofs =3D 0;
>  	remaining =3D inode->i_size;
> +	ctx.comprlimits =3D cfg.c_compr_seg_size;
>
>  	while (remaining) {
>  		const u64 readcount =3D min_t(u64, remaining,
> diff --git a/lib/config.c b/lib/config.c
> index da0c260..1c39403 100644
> --- a/lib/config.c
> +++ b/lib/config.c
> @@ -23,6 +23,7 @@ void erofs_init_configure(void)
>  	cfg.c_force_inodeversion =3D 0;
>  	cfg.c_inline_xattr_tolerance =3D 2;
>  	cfg.c_unix_timestamp =3D -1;
> +	cfg.c_compr_seg_size =3D 1024U * EROFS_BLKSIZ;

We don't need that limit by default, so
cfg.c_compr_segsize =3D -1ULL;

>  }
>
>  void erofs_show_config(void)
> diff --git a/mkfs/main.c b/mkfs/main.c
> index 94bf1e6..036d818 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -61,6 +61,7 @@ static void usage(void)
>  	      " -x#               set xattr tolerance to # (< 0, disable xattr=
s; default 2)\n"
>  	      " -EX[,...]         X=3Dextended options\n"
>  	      " -T#               set a fixed UNIX timestamp # to all files\n"
> +	      " -S#               set the max input stream size # to one compr=
ess\n"
>  	      " --exclude-path=3DX  avoid including file X (X =3D exact litera=
l path)\n"
>  	      " --exclude-regex=3DX avoid including files that match X (X =3D =
regular expression)\n"
>  #ifdef HAVE_LIBSELINUX
> @@ -138,7 +139,7 @@ static int mkfs_parse_options_cfg(int argc, char *ar=
gv[])
>  	char *endptr;
>  	int opt, i;
>
> -	while((opt =3D getopt_long(argc, argv, "d:x:z:E:T:",
> +	while((opt =3D getopt_long(argc, argv, "d:x:z:E:T:S:",
>  				 long_options, NULL)) !=3D -1) {
>  		switch (opt) {
>  		case 'z':
> @@ -188,6 +189,19 @@ static int mkfs_parse_options_cfg(int argc, char *a=
rgv[])
>  				return -EINVAL;
>  			}
>  			break;
> +		case 'S':
> +			cfg.c_compr_seg_size =3D strtol(optarg, &endptr, 0);
> +			if (*endptr !=3D '\0') {
> +				erofs_err("invalid compress segment size %s",
> +					  optarg);
> +				return -EINVAL;
> +			}
> +			if (cfg.c_compr_seg_size % EROFS_BLKSIZ !=3D 0) {
> +				erofs_err("segment size:%u should be align to %u",
> +					  cfg.c_compr_seg_size, EROFS_BLKSIZ);
> +				return -EINVAL;
> +			}

if (!cfg.c_compr_segsize)
	cfg.c_compr_segsize =3D -1ULL;
else if (cfg.c_compr_segsize % EROFS_BLKSIZ) {
	erofs_err("segmentsize %u should be aligned with blocksize %u",
		  cfg.c_compr_seg_size, EROFS_BLKSIZ);
	return -EINVAL;
}

Thanks,
Gao Xiang

