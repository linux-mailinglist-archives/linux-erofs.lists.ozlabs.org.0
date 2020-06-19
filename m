Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id C519C201E77
	for <lists+linux-erofs@lfdr.de>; Sat, 20 Jun 2020 01:04:05 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49pZ9v1yLLzDrS5
	for <lists+linux-erofs@lfdr.de>; Sat, 20 Jun 2020 09:04:03 +1000 (AEST)
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
 header.s=badeba3b8450 header.b=VVdbuytW; 
 dkim-atps=neutral
Received: from mout-xforward.gmx.net (mout-xforward.gmx.net [82.165.159.41])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49pZ9j3rmMzDrRC
 for <linux-erofs@lists.ozlabs.org>; Sat, 20 Jun 2020 09:03:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1592607822;
 bh=xpJFBygnPGLyvdfhdVoSQ9qU5/hbMdvIjuaqIOC4Lgs=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
 b=VVdbuytW74zxxsQ3jlc/OTlKOgvQhtYXwwfjUlMTpV1S+05LJdU4r3nZj9I6DXm8A
 QipyV79ltaMrNn1lZJigM9IV9SxvYXUBseu1kjWQItevdZPOEaIrpIbVECoHaaC6ok
 nzPrD2Nmt4p+58vgn+vR5sHaRFd/NlYwNacUN+zU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from hsiangkao-HP-ZHAN-66-Pro-G1 ([36.63.211.116]) by mail.gmx.com
 (mrgmx105 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1MhU5b-1jI3Re1xFD-00ed2O; Sat, 20 Jun 2020 01:03:42 +0200
Date: Sat, 20 Jun 2020 07:03:36 +0800
From: Gao Xiang <hsiangkao@gmx.com>
To: Li Guifu <bluce.lee@aliyun.com>
Subject: Re: [PATCH v5] erofs-utils: introduce segment compression
Message-ID: <20200619230335.GA22685@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20200618162657.3136-1-bluce.lee@aliyun.com>
 <20200619175133.6919-1-bluce.lee@aliyun.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619175133.6919-1-bluce.lee@aliyun.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:40n5uZokR6RvcuAJeQRUZl6JYPbd36ry7rIOdK+xCANpAKns0nf
 KUz2+YXq5LGhuSuTSZ/gq8aJVAoH/lacUKe5eWdm1Oaape6VIV78rNhAuFCaRyG4pZBSbEX
 PwQXoyc3IISh5i3Y4BDSKS21u1B6plDMTOUU/0DmBv7/sHSocy4kKrc0WIoDK+EFr0jC2MB
 Qv2F7ge6GKwqWdh8T5cpg==
X-Spam-Flag: YES
X-UI-Out-Filterresults: junk:10;V03:K0:k0fhj62s9cI=:nyRnMGuDD5XSdsJqYIG4DjOd
 wy+/grlRGC++aGWhoC2AXGOpqKhx5BiEIGY/jEamz70Ji52orR/DoOCqooqiX/kAp0tulw8Dv
 jb/sAV5rV0+j1g32FmhG+w8UiKP/8MxxmBSX3jtOWMm3+CMaiWSD5uGRs1pfVnoynO3hWNFXO
 qdR7GTf6Z/Q4tjq0YqdtTitr3PrUfA3PI8YLiHhbjZqV0V7br5lITE/lrIpShjzlNoFTwMWZc
 GyeHf4neVMJeQqbtjchogkjpoykKzmnDioU1MiuQdxqBZJkSKRQjhPoOF6Gbq0dW/MBckjXYn
 7hLBZ5DWfjaG9+syoejqF62wWSGuJXVWGIBf5uZyDssSjkGRFzjq2lisRvW+XjssO1xVQUDuW
 eWgxvCL2sXFx/JrSC7UpZ5A9an5vzMNhQUh1/JeNsLjbQuptsqKJS0rTaT/Vn4xWHrwNCzq2Y
 vPoqH2lWadqaasF91APJzYGGs9O87UaGZqpc3dqQNhhskCMc3jMBgT9gVxCtEPx6KNpZ7ORbO
 Oo1K4XLzywhr1qeW1Xo12CueI5R+oIv2L7ieiqDPCkg2PUET+JnLZxrAEm1sJIjlCfIDTt8pw
 seYW9vpcWJQ9Za5BHScufs387Z8taykjwwbolSh615SMkW1Rx8Co2we3LMY5yEztpBxNPzDKN
 BDvV9m7SMdOUpJ1f/yWOu0/6DeEUNQAPdYzwNu7VOdoH/uy6zlUIbauBRG9UeZh/jvAOW4hdj
 /GBx3kTifh32ggkoUFXo66wdKQVjBCYdsszSNsFSrrOTB/K/xN3oL8Ex+fD1LpwZdULsHJlC9
 9MzzM17RzmaYBVJdNwwa+epVSdIXflKFROy3Rwkkpnsebw1sLADUenoxhwWpJ+75NWFQFwU6y
 VriuKzguuC/CHiDKNiJ8qzfde608h1ePugAAGch21GhemvlK0d8EsW1BVTeyN5P4JfdLvY7GX
 uRlNCVFk9KersXHFfyy6oa2WNjh46tP68k41vXje225Uj9gIdL/4jXMJKhzaVjknHfhNtKP0u
 hAQOOno368gmFIu/LpK185ZdYZo5oEBOmVS2bFNSHIao81CKbi8FeNUCQeffiyvsN6TVYiLBW
 +FVV6vI0WS+Xioku3iyY6Y/q+dInEN4DnukpUQpX2hWVlLQUaL5TgL7+WwmupfrpERfP+wZtx
 aJ06NhKm74z631Xpi9l/8ni+qC/Y8yVHP0yasUno1hi5gbBnGbCk1I1ctEw3SnHFdXRnYNvUU
 pPtX7+TMJHgwMb8EmdAmGImunN0d+5M3K0CSw==
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

On Sat, Jun 20, 2020 at 01:51:33AM +0800, Li Guifu via Linux-erofs wrote:
> Support segment compression which seperates files in several logic
> units (segments) and each segment is compressed independently.
>
> Advantages:
>  - more friendly for data differencing;
>  - it can also be used for parallel compression in the same file later.
>
> Signed-off-by: Li Guifu <bluce.lee@aliyun.com>
> ---
>  include/erofs/config.h |  1 +
>  lib/compress.c         | 16 ++++++++++++++--
>  lib/config.c           |  1 +
>  man/mkfs.erofs.1       |  4 ++++
>  mkfs/main.c            | 16 +++++++++++++++-
>  5 files changed, 35 insertions(+), 3 deletions(-)
>
> diff --git a/include/erofs/config.h b/include/erofs/config.h
> index 2f09749..995664d 100644
> --- a/include/erofs/config.h
> +++ b/include/erofs/config.h
> @@ -36,6 +36,7 @@ struct erofs_configure {
>  	char *c_src_path;
>  	char *c_compr_alg_master;
>  	int c_compr_level_master;
> +	u64 c_compr_seg_size;

Could you please move this variable up a bit? Thanks.

char *c_compr_alg_master;
u64 c_compr_seg_size;
int c_compr_level_master;

>  	int c_force_inodeversion;
>  	/* < 0, xattr disabled and INT_MAX, always use inline xattrs */
>  	int c_inline_xattr_tolerance;
> diff --git a/lib/compress.c b/lib/compress.c
> index 6cc68ed..383ee00 100644
> --- a/lib/compress.c
> +++ b/lib/compress.c
> @@ -32,6 +32,7 @@ struct z_erofs_vle_compress_ctx {
>
>  	erofs_blk_t blkaddr;	/* pointing to the next blkaddr */
>  	u16 clusterofs;
> +	u64 segavail;
>  };
>
>  #define Z_EROFS_LEGACY_MAP_HEADER_SIZE	\
> @@ -158,13 +159,19 @@ static int vle_compress_one(struct erofs_inode *in=
ode,
>  	while (len) {
>  		bool raw;

unsigned int limit;

>
> +		count =3D min_t(u64, len, ctx->segavail);

kill this line.

> +		if (ctx->segavail <=3D EROFS_BLKSIZ) {
> +			if (len < ctx->segavail && !final)
> +				break;

limit =3D ctx->segavail;

> +			goto nocompression;
> +		}
> +
>  		if (len <=3D EROFS_BLKSIZ) {
>  			if (final)
>  				goto nocompression;
>  			break;
>  		}
>
> -		count =3D len;

count =3D min_t(u64, len, ctx->segavail);

>  		ret =3D erofs_compress_destsize(h, compressionlevel,
>  					      ctx->queue + ctx->head,
>  					      &count, dst, EROFS_BLKSIZ);
> @@ -174,8 +181,9 @@ static int vle_compress_one(struct erofs_inode *inod=
e,
>  					  inode->i_srcpath,
>  					  erofs_strerror(ret));
>  			}
> +			count =3D len;

kill this line and add limit =3D EROFS_BLKSIZ;

>  nocompression:
> -			ret =3D write_uncompressed_block(ctx, &len, dst);
> +			ret =3D write_uncompressed_block(ctx, &count, dst);

ret =3D write_uncompressed_block(ctx, &count, limit, dst);

and update write_uncompressed_block as well.

>  			if (ret < 0)
>  				return ret;
>  			count =3D ret;
> @@ -202,6 +210,9 @@ nocompression:
>
>  		++ctx->blkaddr;
>  		len -=3D count;
> +		ctx->segavail -=3D count;
> +		if (!ctx->segavail)
> +			ctx->segavail =3D cfg.c_compr_seg_size;
>
>  		if (!final && ctx->head >=3D EROFS_CONFIG_COMPR_MAX_SZ) {
>  			const unsigned int qh_aligned =3D
> @@ -422,6 +433,7 @@ int erofs_write_compressed_file(struct erofs_inode *=
inode)
>  	ctx.head =3D ctx.tail =3D 0;
>  	ctx.clusterofs =3D 0;
>  	remaining =3D inode->i_size;
> +	ctx.segavail =3D cfg.c_compr_seg_size;
>
>  	while (remaining) {
>  		const u64 readcount =3D min_t(u64, remaining,
> diff --git a/lib/config.c b/lib/config.c
> index da0c260..de982e1 100644
> --- a/lib/config.c
> +++ b/lib/config.c
> @@ -23,6 +23,7 @@ void erofs_init_configure(void)
>  	cfg.c_force_inodeversion =3D 0;
>  	cfg.c_inline_xattr_tolerance =3D 2;
>  	cfg.c_unix_timestamp =3D -1;
> +	cfg.c_compr_seg_size =3D UINT64_MAX;

cfg.c_compr_seg_size =3D -1;

since it is a very simple way to assign UINT_MAX by implicit sign
extension without taking care for the specific data type.

>  }
>
>  void erofs_show_config(void)
> diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
> index 891c5a8..b12cb22 100644
> --- a/man/mkfs.erofs.1
> +++ b/man/mkfs.erofs.1
> @@ -52,6 +52,10 @@ Forcely generate extended inodes (64-byte inodes) to =
output.
>  Set all files to the given UNIX timestamp. Reproducible builds requires=
 setting
>  all to a specific one.
>  .TP
> +.BI "\-S " #
> +Set the max input stream size at one compression. The default is unsign=
ed 64bit MAX.
> +It must be algin to EROFS block size(4096).

it's hard for end users to type "max 64-bit unsigned value"...

I'd suggest "Set max input stream size for each individual segment (disabl=
ed if 0).
The default value is 0. It should be aligned with blocksize."

> +.TP
>  .BI "\-\-exclude-path=3D" path
>  Ignore file that matches the exact literal path.
>  You may give multiple `--exclude-path' options.
> diff --git a/mkfs/main.c b/mkfs/main.c
> index 94bf1e6..96cc053 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -61,6 +61,7 @@ static void usage(void)
>  	      " -x#               set xattr tolerance to # (< 0, disable xattr=
s; default 2)\n"
>  	      " -EX[,...]         X=3Dextended options\n"
>  	      " -T#               set a fixed UNIX timestamp # to all files\n"
> +	      " -S#               set the max input stream size # at one compr=
ession\n"

-S#               Set max input stream size # for each individual segment\=
n

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
> +			cfg.c_compr_seg_size =3D strtoll(optarg, &endptr, 0);
> +			if (*endptr !=3D '\0' || !cfg.c_compr_seg_size) {

Disable this if cfg.c_compr_seg_size =3D=3D 0

> +				erofs_err("invalid compress segment size %s",
> +					  optarg);
> +				return -EINVAL;
> +			}
> +			if (cfg.c_compr_seg_size % EROFS_BLKSIZ) {
> +				erofs_err("segment size:%"PRIu64" should be align to %u",


Could you follow my advice in the previous reply?
Although I'm not good at English, but I don't think the above message is _=
reasonable_.

Thanks,
Gao Xiang

> +					  cfg.c_compr_seg_size, EROFS_BLKSIZ);
> +				return -EINVAL;
> +			}
> +			break;
>  		case 2:
>  			opt =3D erofs_parse_exclude_path(optarg, false);
>  			if (opt) {
> --
> 2.17.1
>
