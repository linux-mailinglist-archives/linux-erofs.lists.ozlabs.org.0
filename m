Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id D59BA9BE1A
	for <lists+linux-erofs@lfdr.de>; Sat, 24 Aug 2019 16:01:10 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46G0Kw0DB5zDrV2
	for <lists+linux-erofs@lfdr.de>; Sun, 25 Aug 2019 00:01:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1566655268;
	bh=Kwl/QC0qWnLV/xMppf67JYwb3r1kevS6CvPXjOX1758=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=e4mbMwOKkL296O/UcMzy+cZuTt+gOvdk9vKkgLtzYC6FaSAWxVshdKid/1ZrOl6UO
	 lMTIbZsAj2vGOF1O6iczThtr0rE3E55zhSkhlsw12zif9Pnk1ibWXF2LkjJvkRXg8X
	 DxQX20I/hVEX/MuWL7akiduvn2xvpJFA0zsQSzHYBgLvz6TUTM0OXrmUpREcBj4rbl
	 /dOCUprLf7VzB4mJOUPCy/ELai260WPZ3letw2pjwYmN4Jzls8uDHd0+et6YASo6Ml
	 jNaDAuAqEE/hqXw6/4xXQeJaZwSUtAsXUzUFP2KXIHBAz/tTHgWkbB72IEazTciQfz
	 9cv4FSw9QasdA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=98.137.65.204; helo=sonic311-23.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="YQrQiKzj"; 
 dkim-atps=neutral
Received: from sonic311-23.consmr.mail.gq1.yahoo.com
 (sonic311-23.consmr.mail.gq1.yahoo.com [98.137.65.204])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46G0KZ5DRTzDrMG
 for <linux-erofs@lists.ozlabs.org>; Sun, 25 Aug 2019 00:00:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1566655243; bh=X8yJx/79eiL+L8kb3k5w/d9svKXYYjEJM734z61J+4c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=YQrQiKzj1+5l5vMi5uMRY8AajCMUW5M+SeDxNHXEYuU1TjbKeLIEsf8zrgaM39LUzCcriICT8OHgcbsHIk3PS+3TA9iHs0uBFCeGEeLv1ZfXlH6XGygfpmgUxn3lOU+Pelgc7eEojMehNzNZigsYxrgkZZZ5TGxljcfpwxAdEYr8JCzTsO8n37z2iUfFFlVWCt6irI/SH3Ikkxfh06mL3uD9dDx3MrMUnGs362oMeuox/98vcS6q9abKIgEnwi+dy7MINTREn1dfBTCboNvRPFLYSF186s69pvKd4no7qJIz9/N/+5xESp8oH5sku+NcVZQEenokmyuiKuCAfeQWmQ==
X-YMail-OSG: kNxj2_4VM1kKsDgI96SC6n08XKFIobmpqoFQsvirvoHGJElRivNFp6fhD9I6B1l
 6ZOv5VLren4TpL.oWuEwAlponQC.A4I2a4f36lSksOiwkNPjWDZR90PPUw.mrEz63Immq7ahh44U
 UG7Fw0OJUUL34MF2jFGsL.7tpx.GagwOPCyuoOw6KH7sEbLjbw4lKLawFZdNJTVTwSlYdelglU3j
 IgpY612VHwBuIf_RNpG2ZAEnMumpcbYPjZnw9x_xlL8upB6t_7DpaiwaEOIqtBBA2Ud_E_OvPunq
 R2PIUZF3lc.VbUy.t.Q.zgWyytySR1Ua4Rus21Gk.UsH_EvynDu7jZq55sIjJV6av6veNnDMcbkj
 DCuamCUJQe_.mZvpXFD3H6xEcY.5pYHjau0Bpoeewa8FfmJiwFzLKB2MFaPF4GpRHm6M0K7Y.1Xs
 kMHKZIPPJuOt25nLH.Fqgax5uXbSNso8R.q4lb_O2.LJ2mlgCh0tEFB.1eIdDGslSZmkTthAKXnp
 5WOc6alXM9yJWQKcr8K0A41oxY9_27MLEWqXz0wWkYFGnUthMsTGb0gIbv.O.MDd.PPSwlMA8N8.
 lGDdaFQpR.VcRP4mwLK_qDuXkJ.v.LLwyUPC6SLnjp7VeOkKLsehGN1w_8bLA4.dSBu2.Mpzif._
 s_SHrxrw6mqXNJkhNQskCwV8tOHdCO12eQB8zXQyiuMjkRXKrzCksL2njiSYZhxPkVhgLwpYh3kP
 gjc_QDKNXtqeNSkRDXh9aVF1G7EwOc1LpWQWJjbV6ZhOb5JZGp.0_jihHUiwxQ8Dws937tuDtxkP
 npwd2N.TXRmqNkLLPVHp5CoBo3YBPzX1Sl7Y4.JWj00oujunuZGIm890M4B6OqhD.r_gRH6.JR.B
 o4pD33wjT4N6AUkD0B1ystyHb5G_3uddcZW5yV_H1Wg..DWRUExTQaFb7byBsdQzNgbpqMT2nepf
 F15x_NrUY3iHuOh_EbYOtczSq5UeaeWRnfb44E5Z5nUzMXDrCHYTn4dZWHBV3ocytfQ7uoyOgrE1
 mW9quH9635cmfHRlBLdjk9ipCLVybO5HCW0uOeO6BHSHOaJFh48zR1KC.UfKmLmDm2V2C2J0s2sX
 axGFvcvQpOedsvzBLgK1AOhe.1S4ETNdrFGjbdZ7_pDR4He7B4J_WAM2o7U_j6VvJh0DO.RWlN6v
 wt8Ue0tCPqxwpvgOeyqhPHq7hv12vQcSPWYSJ2V2vUOdO1ZnC9Xea0wCVo6Cc.EhHgJ4xyxbtyb4
 lN7YCAvnCfcYR7ngkw9gQ4nQiv9Uz
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic311.consmr.mail.gq1.yahoo.com with HTTP; Sat, 24 Aug 2019 14:00:43 +0000
Received: by smtp426.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 1c5bd6792aeb2536f7923bbcf7d9e7c5; 
 Sat, 24 Aug 2019 14:00:41 +0000 (UTC)
Date: Sat, 24 Aug 2019 22:00:25 +0800
To: Pratik Shinde <pratikshinde320@gmail.com>
Subject: Re: [PATCH] erofs-utils: code for superblock checksum calculation.
Message-ID: <20190824140012.GB19943@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20190824123803.19797-1-pratikshinde320@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190824123803.19797-1-pratikshinde320@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Cc: miaoxie@huawei.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Pratik,

On Sat, Aug 24, 2019 at 06:08:03PM +0530, Pratik Shinde wrote:
> Adding code for superblock checksum calculation.
> 
> incorporated the changes suggested in previous patch.
> 
> Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>

Thanks for your v2 patch.

Actually, I have some concern about the length of checksum,
sizeof(struct erofs_super_block) could be changed in the
later version, it's bad for EROFS future scalablity.

And I tend not to add another on-disk field to record
the size of erofs_super_block as well, because the old
Linux kernel cannot handle more about the new size,
so it has little use except for checksum calculation.

Few hours ago, I discussed with Chao about this concern,
I think this feature can be changed to do multiple-block
checksum at the mount time, e.g:
 - for small images, we can check the whole image once
   at the mount time;
 - for the large image, we can check the superblock
   at the mount time, the rest can be handled by
   block-based verification layer.

But we agreed that don't add this for this round
since it's quite a new feature.

All in all, it's a new feature since we are addressing moving
out of staging for this round. I tend to postpone this feature
for now. I understand that you are very interested in EROFS.
Considering EROFS current staging status, it's not such a place
to add new features at all! I have marked your patch down and
I will work with you later. Hope to get your understanding...

Thanks,
Gao Xiang

> ---
>  include/erofs/config.h |  1 +
>  include/erofs_fs.h     | 10 ++++++++
>  mkfs/main.c            | 64 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 74 insertions(+), 1 deletion(-)
> 
> diff --git a/include/erofs/config.h b/include/erofs/config.h
> index 05fe6b2..40cd466 100644
> --- a/include/erofs/config.h
> +++ b/include/erofs/config.h
> @@ -22,6 +22,7 @@ struct erofs_configure {
>  	char *c_src_path;
>  	char *c_compr_alg_master;
>  	int c_compr_level_master;
> +	int c_feature_flags;
>  };
>  
>  extern struct erofs_configure cfg;
> diff --git a/include/erofs_fs.h b/include/erofs_fs.h
> index 601b477..9ac2635 100644
> --- a/include/erofs_fs.h
> +++ b/include/erofs_fs.h
> @@ -20,6 +20,16 @@
>  #define EROFS_REQUIREMENT_LZ4_0PADDING	0x00000001
>  #define EROFS_ALL_REQUIREMENTS		EROFS_REQUIREMENT_LZ4_0PADDING
>  
> +/*
> + * feature definations.
> + */
> +#define EROFS_DEFAULT_FEATURES		EROFS_FEATURE_SB_CHKSUM
> +#define EROFS_FEATURE_SB_CHKSUM		0x0001
> +
> +
> +#define EROFS_HAS_COMPAT_FEATURE(super,mask)	\
> +	( le32_to_cpu((super)->features) & (mask) )
> +
>  struct erofs_super_block {
>  /*  0 */__le32 magic;           /* in the little endian */
>  /*  4 */__le32 checksum;        /* crc32c(super_block) */
> diff --git a/mkfs/main.c b/mkfs/main.c
> index f127fe1..355fd2c 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -31,6 +31,45 @@ static void usage(void)
>  	fprintf(stderr, " -EX[,...] X=extended options\n");
>  }
>  
> +#define CRCPOLY	0x82F63B78
> +static inline u32 crc32c(u32 seed, unsigned char const *in, size_t len)
> +{
> +	int i;
> +	u32 crc = seed;
> +
> +	while (len--) {
> +		crc ^= *in++;
> +		for (i = 0; i < 8; i++) {
> +			crc = (crc >> 1) ^ ((crc & 1) ? CRCPOLY : 0);
> +		}
> +	}
> +	erofs_dump("calculated crc: 0x%x\n", crc);
> +	return crc;
> +}
> +
> +char *feature_opts[] = {
> +	"nosbcrc", NULL
> +};
> +#define O_SB_CKSUM	0
> +
> +static int parse_feature_subopts(char *opts)
> +{
> +	char *arg;
> +
> +	cfg.c_feature_flags = EROFS_DEFAULT_FEATURES;
> +	while (*opts != '\0') {
> +		switch(getsubopt(&opts, feature_opts, &arg)) {
> +		case O_SB_CKSUM:
> +			cfg.c_feature_flags |= (~EROFS_FEATURE_SB_CHKSUM);
> +			break;
> +		default:
> +			erofs_err("incorrect suboption");
> +			return -EINVAL;
> +		}
> +	}
> +	return 0;
> +}
> +
>  static int parse_extended_opts(const char *opts)
>  {
>  #define MATCH_EXTENTED_OPT(opt, token, keylen) \
> @@ -79,7 +118,8 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
>  {
>  	int opt, i;
>  
> -	while ((opt = getopt(argc, argv, "d:z:E:")) != -1) {
> +	cfg.c_feature_flags = EROFS_DEFAULT_FEATURES;
> +	while ((opt = getopt(argc, argv, "d:z:E:o:")) != -1) {
>  		switch (opt) {
>  		case 'z':
>  			if (!optarg) {
> @@ -113,6 +153,12 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
>  				return opt;
>  			break;
>  
> +		case 'O':
> +			opt = parse_feature_subopts(optarg);
> +			if (opt)
> +				return opt;
> +			break;
> +
>  		default: /* '?' */
>  			return -EINVAL;
>  		}
> @@ -144,6 +190,15 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
>  	return 0;
>  }
>  
> +u32 erofs_superblock_checksum(struct erofs_super_block *sb)
> +{
> +	u32 crc;
> +	crc = crc32c(~0, (const unsigned char *)sb,
> +		    sizeof(struct erofs_super_block));
> +	erofs_dump("superblock checksum: 0x%x\n", crc);
> +	return crc;
> +}
> +
>  int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
>  				  erofs_nid_t root_nid)
>  {
> @@ -155,6 +210,7 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
>  		.meta_blkaddr  = sbi.meta_blkaddr,
>  		.xattr_blkaddr = 0,
>  		.requirements = cpu_to_le32(sbi.requirements),
> +		.features = cpu_to_le32(cfg.c_feature_flags),
>  	};
>  	const unsigned int sb_blksize =
>  		round_up(EROFS_SUPER_END, EROFS_BLKSIZ);
> @@ -169,6 +225,12 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
>  	sb.blocks       = cpu_to_le32(erofs_mapbh(NULL, true));
>  	sb.root_nid     = cpu_to_le16(root_nid);
>  
> +	if (EROFS_HAS_COMPAT_FEATURE(&sb, EROFS_FEATURE_SB_CHKSUM)) {
> +		sb.checksum = 0;
> +		u32 crc = erofs_superblock_checksum(&sb);
> +		sb.checksum = cpu_to_le32(crc);
> +	}
> +
>  	buf = calloc(sb_blksize, 1);
>  	if (!buf) {
>  		erofs_err("Failed to allocate memory for sb: %s",
> -- 
> 2.9.3
> 
