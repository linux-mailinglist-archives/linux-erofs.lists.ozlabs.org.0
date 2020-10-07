Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 153C72861C3
	for <lists+linux-erofs@lfdr.de>; Wed,  7 Oct 2020 17:04:53 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4C5yLB1l2kzDqPW
	for <lists+linux-erofs@lfdr.de>; Thu,  8 Oct 2020 02:04:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1602083090;
	bh=5Wl4E5OK+sZj3ZuC2R6k3iELXZYTo0w5n8jqJc4pU1s=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=KNhLr5Qp0brcZQHy3+0tCWYTYSCBadDJiMDVnQj0xve4TdlcEcHQM/+Y+5tFi4PkB
	 aYTDGZeSQPzdjhDEubGnvrmv5lkmCyCcOO+LJ1RXHr8KDm7N1KZm4RlM1gS3Rad+Cz
	 S9JtYbaXsgGRzBbyhhfWt27ofPSpG60uY31ZMWBPwO3WXI8lZwiR/A+DHZiIYRKI0X
	 wBQBuLsB+ek2AfhdubLL/QpLmTD8khFShjl5GRgAeO+8mGB7S4w2etcZAc/uoocwMR
	 8u9uIpzQwjSJoIBzeiaS0V9CJ7xBc04VRRfBe+GSDgdF+JJN9/amYOiHwtYMyOekbs
	 dnIjOwffv8PaQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.68.205; helo=sonic304-24.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=lJgO65E9; dkim-atps=neutral
Received: from sonic304-24.consmr.mail.gq1.yahoo.com
 (sonic304-24.consmr.mail.gq1.yahoo.com [98.137.68.205])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C5yL32DywzDqNb
 for <linux-erofs@lists.ozlabs.org>; Thu,  8 Oct 2020 02:04:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1602083078; bh=WyUiJkLWUfsbe3mbx8CLy+UpA2Lixeek8apP5Q1g6Xw=;
 h=Date:From:To:Subject:References:In-Reply-To:From:Subject;
 b=lJgO65E9y4M8eU5v+ZISiSXsEubfBpDg1kYsGqwcPfofT8hRj3voJTaHlllEDgEURQTDS7rzolTPoNyR5mRGXlhZDyiloJJTI1yve7YlKHppYVjtzQsJ/+2rcDCiZAJuQnowTE9be4iPofVnSJWhVHjFpUvUNfBLdKyv7m0mjtJ233wsXFR0Zs3rbDfmOSl8encketwMGR7KpMApw574sB0/okZ2N8KcL8Yh8ol1McgIILBuCYohNLND7naYHT4ZSx8LTjLknQXuI6thH4zUAuDauf04c8PGjK0QS5aLfkytNWqS9dcMEFmR4NnUPy9U4POYsTVR+DBLyfuzP1BVvQ==
X-YMail-OSG: 3vNz5kkVM1mjoyr1c7zHE5CBM72Xi_5rP8V_F82ReRa482D.b05uNaEl9dOu90P
 MWL8HEZJR5clJfifN0n1Am1EhjvPlbze5yPClbjuVzukF57V._Rz.4eqUKLNuCqY17989CYaUgxw
 sPx6EIfVPE3wHcG3nRH7HyHvNmSdGhHxqBxBpllu3StaTD8gBUNsxX7wgMFFADjPZxuBwuZvgd42
 SD.lYVaKpIDbOE0i5K1z2xv1Xw2P3ZCVeyvudH9OTKEYD.L7KC4faXbqgHRaMy5QIz_jJ.04IoNg
 LC2a1Y5Pf.3UE0Ei3nK939yoPbydSmiIs5xa9t6Um5IjdTvyXL0AuAAiCR6OQyqwlPfNwry_ypsi
 VG_8x_PESJeUXCGlgWtE3ooZFs9bk_oUURNVisZUfB1iew3olCM2xXnH3eZccP..ly1ZjBWGWP_3
 QD8b2DFJLX0DIO5Xm6Tofh16T8yxxWmPp9pV1aJP8810wq3sHnjXsL2BWINIPLKAliMb82eXJjzC
 xQbt4boUdmQF74W2XS2gCS9HP2nizB4VAEOi.MYieLbyI8Bc_kwQFONbATUNZmifL3wbizGsFH_u
 0.zi_KV5.isOI_iWB5tPFrmjno8ndcKAhDIwbeQkYsCLegSVInPL_Nk9ro3TA24LiQZXPahXYajI
 Ew.L4FKRaKkiWVUehtn790yzPcARmN7ZQRR.RWn9FMZnG6ZVypgEVUqMpjuny09tlsk3e.vlz3v.
 c_fUBKZxqXmos00U52hhAkH7fbo77ku3aDC3Uw9QiLyWsEHfQpjWNWPhGCwxwdxkpDCvpb5qLMSh
 0Fo8Bj1wCnPM_q8Ude51OUERuiwR0wNn.3.GDEEbu8gWEAsCWNErUu0OCiUAi0cxdwnCrhASue5q
 _oEPu5RzIi2Wuf.DWUQbXxuk5QMf6PcQWbgKWPPIXkwerbKWgn.6bnpQ1LEWjdEhQPyLLnr0ryG8
 KQrTSqjVcFS3pb.NsCjwqqZf91hrpBo3vYE8VikW2z.nHWAB.z4SkxktmaLQ6hIGqWeBIu6jWaou
 I2VHGKGnmLGsDxzWtukj94owlHu4ZBUru2hmn2V1bX4Lu8VhY9M5hzbJCS5FC3xVJqqCgZR.qsbd
 Nd7fFJlTj9WFzfLdzc28O3hzmJmqkK1mpZucfn1oLgulFE5ZH5Hcq25zexVncCn7xGJ3pUC4r_xG
 f1kWViV6Jip9_zI0tWhyFZd5cgOp93FEO9Ul8kpFN4H.D6VG9NqXCSVSr1qhiv7DlTzd8mNpU5bz
 rvRxOpGVEwGXPCJZ3BgkDcH2oGHTCB0DfILVTufJUTBodFa0dHKUaVbphpai4qKFLEa9sgGq27mr
 ALXab2H7w8EYVrVx8uVnz6uoh0tgr6OLRf4VRvSrUJJj6fNpG9NgngDQQzqgxSnygQ2C36WI.whh
 h6gN62xGxl720IFxL8lUVAHqjZtKxf2.60aDv3R5.HQVGxFvuVhq3rik4eoVrxZidh89W.h_upO6
 rypGzkuX1ics4N_y03lI7R1X7wxHO9kBEexMvSubuNp_5NSDN_ROYfnEObz_b
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic304.consmr.mail.gq1.yahoo.com with HTTP; Wed, 7 Oct 2020 15:04:38 +0000
Received: by smtp411.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID bc844205648b9ef86536c6bc7dbc7fb7; 
 Wed, 07 Oct 2020 15:04:34 +0000 (UTC)
Date: Wed, 7 Oct 2020 23:04:22 +0800
To: Li Guifu <bluce.lee@aliyun.com>, Li Guifu <bluce.liguifu@huawei.com>,
 linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH v11] erofs-utils: introduce segment compression
Message-ID: <20201007150420.GB30128@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20200630172758.6533-1-bluce.lee@aliyun.com>
 <20200705083230.5027-1-bluce.lee@aliyun.com>
 <20200705182049.GA20632@hsiangkao-HP-ZHAN-66-Pro-G1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200705182049.GA20632@hsiangkao-HP-ZHAN-66-Pro-G1>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailer: WebService/1.1.16795
 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
 Apache-HttpAsyncClient/4.1.4 (Java/11.0.7)
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <hsiangkao@aol.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Guifu, some progress on this as well?

On Mon, Jul 06, 2020 at 02:20:50AM +0800, Gao Xiang via Linux-erofs wrote:
> Hi Guifu,
> 
> On Sun, Jul 05, 2020 at 04:32:30PM +0800, Li Guifu via Linux-erofs wrote:
> > Support segment compression which seperates files in several logic
> > units (segments) and each segment is compressed independently.
> > 
> > Advantages:
> >  - more friendly for data differencing;
> >  - it can also be used for parallel compression in the same file later.
> > 
> > Signed-off-by: Li Guifu <bluce.lee@aliyun.com>
> > ---
> > Changes from v10
> > - chang variable uncomprofs to clusterofs which only used
> >   when write uncompress block
> 
> Could you please test the following patch if you're available?
> Does it work?
> 
> From 0436ed04717853351e13d68db6f170f60e25fc12 Mon Sep 17 00:00:00 2001
> From: Li Guifu <bluce.lee@aliyun.com>
> Date: Sun, 5 Jul 2020 16:32:30 +0800
> Subject: [PATCH v12] erofs-utils: introduce segment compression
> 
> Support segment compression which seperates files in several logic
> units (segments) and each segment is compressed independently.
> 
> Advantages:
>  - more friendly for data differencing;
>  - it can also be used for parallel compression in the same file later.
> 
> Signed-off-by: Li Guifu <bluce.lee@aliyun.com>
> Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
> ---
>  include/erofs/config.h |  2 ++
>  lib/compress.c         | 38 ++++++++++++++++++++++++++++++--------
>  lib/config.c           |  1 +
>  man/mkfs.erofs.1       |  4 ++++
>  mkfs/main.c            | 12 +++++++++++-
>  5 files changed, 48 insertions(+), 9 deletions(-)
> 
> diff --git a/include/erofs/config.h b/include/erofs/config.h
> index 2f09749..b149633 100644
> --- a/include/erofs/config.h
> +++ b/include/erofs/config.h
> @@ -35,6 +35,8 @@ struct erofs_configure {
>  	char *c_img_path;
>  	char *c_src_path;
>  	char *c_compr_alg_master;
> +	u64 c_compr_segsize;
> +
>  	int c_compr_level_master;
>  	int c_force_inodeversion;
>  	/* < 0, xattr disabled and INT_MAX, always use inline xattrs */
> diff --git a/lib/compress.c b/lib/compress.c
> index 6cc68ed..4216fa7 100644
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
> @@ -124,24 +125,33 @@ static int write_uncompressed_block(struct z_erofs_vle_compress_ctx *ctx,
>  
>  	/* reset clusterofs to 0 if permitted */
>  	if (!erofs_sb_has_lz4_0padding() &&
> -	    ctx->head >= ctx->clusterofs) {
> +	    ctx->clusterofs && ctx->head >= ctx->clusterofs) {
>  		ctx->head -= ctx->clusterofs;
>  		*len += ctx->clusterofs;
> +
> +		ctx->segavail += ctx->clusterofs;
> +		DBG_BUGON(ctx->segavail > cfg.c_compr_segsize);
> +
> +		DBG_BUGON(ctx->segavail < EROFS_BLKSIZ);
> +		/* so only *len will be the candidate instead of segavail */
> +		count = *len;
> +
>  		ctx->clusterofs = 0;
> +	} else {
> +		count = min_t(u64, ctx->segavail, *len);
>  	}
>  
> -	/* write uncompressed data */
> -	count = min(EROFS_BLKSIZ, *len);
> +	if (count > EROFS_BLKSIZ)
> +		count = EROFS_BLKSIZ;
>  
> +	/* fill zero if the uncompressed block isn't full */
>  	memcpy(dst, ctx->queue + ctx->head, count);
>  	memset(dst + count, 0, EROFS_BLKSIZ - count);
>  
>  	erofs_dbg("Writing %u uncompressed data to block %u",
>  		  count, ctx->blkaddr);
>  	ret = blk_write(dst, ctx->blkaddr, 1);
> -	if (ret)
> -		return ret;
> -	return count;
> +	return ret ? ret : count;
>  }
>  
>  static int vle_compress_one(struct erofs_inode *inode,
> @@ -158,13 +168,20 @@ static int vle_compress_one(struct erofs_inode *inode,
>  	while (len) {
>  		bool raw;
>  
> +		if (ctx->segavail <= EROFS_BLKSIZ) {
> +			if (len < ctx->segavail && !final)
> +				break;
> +
> +			goto nocompression;
> +		}
> +
>  		if (len <= EROFS_BLKSIZ) {
>  			if (final)
>  				goto nocompression;
>  			break;
>  		}
>  
> -		count = len;
> +		count = min_t(u64, len, ctx->segavail);
>  		ret = erofs_compress_destsize(h, compressionlevel,
>  					      ctx->queue + ctx->head,
>  					      &count, dst, EROFS_BLKSIZ);
> @@ -195,8 +212,12 @@ nocompression:
>  				return ret;
>  			raw = false;
>  		}
> -
>  		ctx->head += count;
> +		DBG_BUGON(ctx->segavail < count);
> +		ctx->segavail -= count;
> +		if (!ctx->segavail)
> +			ctx->segavail = cfg.c_compr_segsize;
> +
>  		/* write compression indexes for this blkaddr */
>  		vle_write_indexes(ctx, count, raw);
>  
> @@ -421,6 +442,7 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
>  	ctx.metacur = compressmeta + Z_EROFS_LEGACY_MAP_HEADER_SIZE;
>  	ctx.head = ctx.tail = 0;
>  	ctx.clusterofs = 0;
> +	ctx.segavail = cfg.c_compr_segsize;
>  	remaining = inode->i_size;
>  
>  	while (remaining) {
> diff --git a/lib/config.c b/lib/config.c
> index da0c260..9d4bea1 100644
> --- a/lib/config.c
> +++ b/lib/config.c
> @@ -23,6 +23,7 @@ void erofs_init_configure(void)
>  	cfg.c_force_inodeversion = 0;
>  	cfg.c_inline_xattr_tolerance = 2;
>  	cfg.c_unix_timestamp = -1;
> +	cfg.c_compr_segsize = -1;
>  }
>  
>  void erofs_show_config(void)
> diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
> index 891c5a8..8d0fc10 100644
> --- a/man/mkfs.erofs.1
> +++ b/man/mkfs.erofs.1
> @@ -48,6 +48,10 @@ Forcely generate compact inodes (32-byte inodes) to output.
>  Forcely generate extended inodes (64-byte inodes) to output.
>  .RE
>  .TP
> +.BI "\-S " #
> +Set maximum blocks for each individual compress segment.
> +The default is 0 (disabled).
> +.TP
>  .BI "\-T " #
>  Set all files to the given UNIX timestamp. Reproducible builds requires setting
>  all to a specific one.
> diff --git a/mkfs/main.c b/mkfs/main.c
> index 94bf1e6..0265ae9 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -61,6 +61,7 @@ static void usage(void)
>  	      " -x#               set xattr tolerance to # (< 0, disable xattrs; default 2)\n"
>  	      " -EX[,...]         X=extended options\n"
>  	      " -T#               set a fixed UNIX timestamp # to all files\n"
> +	      " -S#               Set maximum blocks for each individual compress segment\n"
>  	      " --exclude-path=X  avoid including file X (X = exact literal path)\n"
>  	      " --exclude-regex=X avoid including files that match X (X = regular expression)\n"
>  #ifdef HAVE_LIBSELINUX
> @@ -138,7 +139,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
>  	char *endptr;
>  	int opt, i;
>  
> -	while((opt = getopt_long(argc, argv, "d:x:z:E:T:",
> +	while((opt = getopt_long(argc, argv, "d:x:z:E:T:S:",
>  				 long_options, NULL)) != -1) {
>  		switch (opt) {
>  		case 'z':
> @@ -188,6 +189,15 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
>  				return -EINVAL;
>  			}
>  			break;
> +		case 'S':
> +			i = strtoll(optarg, &endptr, 0);
> +			if (*endptr != '\0') {
> +				erofs_err("invalid blocks per compress segment %s",
> +					  optarg);
> +				return -EINVAL;
> +			}
> +			cfg.c_compr_segsize = i ? blknr_to_addr(i) : -1;
> +			break;
>  		case 2:
>  			opt = erofs_parse_exclude_path(optarg, false);
>  			if (opt) {
> -- 
> 2.24.0
> 
> 
> 
