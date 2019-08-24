Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EFA9BE31
	for <lists+linux-erofs@lfdr.de>; Sat, 24 Aug 2019 16:12:39 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46G0b75v48zDrck
	for <lists+linux-erofs@lfdr.de>; Sun, 25 Aug 2019 00:12:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1566655955;
	bh=ySgNlpKcUWDCZ9Y9F04X0BvibkL4FLiqi/9SQBiwh1o=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=BsCFTq6YatIB60DBC/YO28iVPv/qc17ZWBS3A3BALtZzq4LO/wJ6BKR/6kaDbhfIe
	 45mR/2dtNpOCJSsm//zxgZlUEPsUiDDcfgW2pIdzIuaZIhXfNLA8+nsAZa+UkUZSSi
	 vBwUHV8VAXvysIzujTBNs5vOCLMR1irjJG6aiCmBx8jwiyglyjueimvxR/3csDNNcL
	 3FlPzmnsgaLs2dgyZX111F4b8f1s2lg0uLJyqf3r291zq19mrK7Ld2MR9bChDRnu5S
	 x0AMqH05RIp/RkTzhQ0RMYRY4CoVDKnTHCYGQxE2lfeQkzMEWEBGO4854a46295lro
	 JyLQUyMisb9LA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=77.238.177.145; helo=sonic314-19.consmr.mail.ir2.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="G3LPbsOo"; 
 dkim-atps=neutral
Received: from sonic314-19.consmr.mail.ir2.yahoo.com
 (sonic314-19.consmr.mail.ir2.yahoo.com [77.238.177.145])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46G0b23VlBzDrcN
 for <linux-erofs@lists.ozlabs.org>; Sun, 25 Aug 2019 00:12:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1566655940; bh=er+O2GJZIOEZwEbr6rrWYGiQrwCoY0Z+aZ5zh4rRR/I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=G3LPbsOokEWJ6PU7QshInvO1Q0KFlYRWcJwADavGFNrq74KnlK1sw2p/UO7ev4tirLkH7hhP/8iXDdehB++yBxDHPrlv2nLEEAvLLyWPtTEVK2KWxcprcT/TMDys0jUrUwNQjPHqY3xWaQ2oasl4GLk5be4bm2Xqhs5sw2ER/sNyT7YxAV0KieNBvhAIDYys9WngKsHdVYJtgSYeJ2jdlTRAoUlEAgw4ndsBQN33Knvf/YH00wi8ysVonB9siiMLzazdICcq6LUpVrRLQMbUB+aMRNmRJ2oKwjbSAw8HGGdhfGrxMlHqsHpW9+OeWVIpPfQMewtbD1lq7wI0PDMW4w==
X-YMail-OSG: bS9maGQVM1mpoUjfMrvloQ9cwJStonmdLQI30pcl.Pg3QCJf5yYmeXi1wGmf4mM
 z_zHZhcg0N0MA8HSOKIep6a.5WJz3VwbgkjqFs0ik9NsrgBjOSnecX9944EZVf3k7fw7jmn5kUdD
 tt5jfJSptyXAaW.wgBNWeyYotu3TDQLCKOyx4WooxKbqt1f4FV2N1W.2dFak4f0YhBHU8U.E8kPp
 uoPckOFDn51o5rDxJ3_n_qrJpoSEmIm8bwBPeAWN9A_VRzBEmt7z6GofdXYz9JWFdjmfK1_tFrMI
 u92866bHcQz5PKmWiKkbc_PeRzcOGevLhvnWXmuQMgzvP_a6wn3FeQWve_O_Q6GYiB24LJs8Hrng
 hBuVPxZTiPE0Nge8MqKMDcGDula6XHBQ8qGdFFXzk4FlrrsT2z_NNvaeb.rsqJ3xlzK0fZIHcW6R
 P.X_Cj5Pkle3wICrr7mCzzOholwdfBIsuneZQ3ED7sx.vtc_4XXUBmDLyfZ_R2Dig4M6SGXkSdtW
 XM7mpVy735Eof8SmyZT1t4YT1lJW7_2aOFnhqVNmxo7eBtEc4jnIR4EdoomTjNn6WdEeBkcL988F
 StDfIzIcS9jX.JxCXXtsM5kwDkg_gEAXrL._IUVd0agiS0nYI2XqklHsr01BhNPYhFgb_cPi2w4q
 RjWRDso_LbqvF0mt8i4D1kgUBI0cDL6w8hxLYOIC.yTHBNyHMnCj1N7XGT4Tw8jBxe.K.wji1UTl
 lB.HdxA44agtGWenU8GExfkZ7oOD9U0ihsAfJIIypU2pCA1eBaMQpmY9XxGF374HXHPiflwnPPda
 aGinD3q0eilVApi9xr_hJv1W5VXmKEOsjD.UjTHudMjg2bzepzSRnqjPT4JKqEssrpWd.tdg7Lkv
 jEb7.j.EzmT0NrgTvMEwD1MSIJ6.R7a0cTtQVCaMyORTId0XGRQT44IaN6TZx2yZ.Ou5y4NUats2
 JpMrP5a3j65ZXDq7G7SYAWyarUgSxFk1NWjdxJ9xRcRmm9lSN48HJ6cwSv2TG7RKwKjORvRpVwKu
 dSlC_lSzLCAbYGx4W6qSNTuQtvOqRrPxldpskyWRPVRbnTaggoLLTv_OVlxqliALN9Svg9ol_Dju
 efrOEufpAkOoVoTaFxPpRJEuW6As6TriHSTm.C2nj5nVGykRExGrb4YK3L1Nn7ldjfoIAnfV2UXr
 1Yhk5Cthb7dA4G8oC0davaUjnTsy0u0ifAdU4my9EiRimN4VoH7kuZ9yvcc_4JKrzW6EWxXcyRns
 9Nm9xlBFBoMjzfnUfjSE8fHb0RPI-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic314.consmr.mail.ir2.yahoo.com with HTTP; Sat, 24 Aug 2019 14:12:20 +0000
Received: by smtp417.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 4adba6bbbd212abe61214a4c75852268; 
 Sat, 24 Aug 2019 14:12:15 +0000 (UTC)
Date: Sat, 24 Aug 2019 22:12:08 +0800
To: Pratik Shinde <pratikshinde320@gmail.com>
Subject: Re: [PATCH] erofs-utils: code for superblock checksum calculation.
Message-ID: <20190824141203.GC19943@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20190824123803.19797-1-pratikshinde320@gmail.com>
 <20190824140012.GB19943@hsiangkao-HP-ZHAN-66-Pro-G1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190824140012.GB19943@hsiangkao-HP-ZHAN-66-Pro-G1>
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
Cc: linux-erofs@lists.ozlabs.org, miaoxie@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sat, Aug 24, 2019 at 10:00:25PM +0800, Gao Xiang via Linux-erofs wrote:
> Hi Pratik,
> 
> On Sat, Aug 24, 2019 at 06:08:03PM +0530, Pratik Shinde wrote:
> > Adding code for superblock checksum calculation.
> > 
> > incorporated the changes suggested in previous patch.
> > 
> > Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
> 
> Thanks for your v2 patch.
> 
> Actually, I have some concern about the length of checksum,
> sizeof(struct erofs_super_block) could be changed in the
> later version, it's bad for EROFS future scalablity.
> 
> And I tend not to add another on-disk field to record
> the size of erofs_super_block as well, because the old
> Linux kernel cannot handle more about the new size,
> so it has little use except for checksum calculation.
> 
> Few hours ago, I discussed with Chao about this concern,
> I think this feature can be changed to do multiple-block
> checksum at the mount time, e.g:
>  - for small images, we can check the whole image once
>    at the mount time;
>  - for the large image, we can check the superblock
>    at the mount time, the rest can be handled by
>    block-based verification layer.
> 
> But we agreed that don't add this for this round
> since it's quite a new feature.
> 
> All in all, it's a new feature since we are addressing moving
> out of staging for this round. I tend to postpone this feature
> for now. I understand that you are very interested in EROFS.
> Considering EROFS current staging status, it's not such a place
> to add new features at all! I have marked your patch down and
                            ^ it should be a stop sign (.)
 
Sorry... that's my keyboard fault...

Let's postpone all new features and address more about moving out
EROFS. Only in this way, EROFS could have good future or it would
be dead. Hope to get your understanding...

Thanks,
Gao Xiang

> I will work with you later. Hope to get your understanding...
> 
> Thanks,
> Gao Xiang
> 
> > ---
> >  include/erofs/config.h |  1 +
> >  include/erofs_fs.h     | 10 ++++++++
> >  mkfs/main.c            | 64 +++++++++++++++++++++++++++++++++++++++++++++++++-
> >  3 files changed, 74 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/erofs/config.h b/include/erofs/config.h
> > index 05fe6b2..40cd466 100644
> > --- a/include/erofs/config.h
> > +++ b/include/erofs/config.h
> > @@ -22,6 +22,7 @@ struct erofs_configure {
> >  	char *c_src_path;
> >  	char *c_compr_alg_master;
> >  	int c_compr_level_master;
> > +	int c_feature_flags;
> >  };
> >  
> >  extern struct erofs_configure cfg;
> > diff --git a/include/erofs_fs.h b/include/erofs_fs.h
> > index 601b477..9ac2635 100644
> > --- a/include/erofs_fs.h
> > +++ b/include/erofs_fs.h
> > @@ -20,6 +20,16 @@
> >  #define EROFS_REQUIREMENT_LZ4_0PADDING	0x00000001
> >  #define EROFS_ALL_REQUIREMENTS		EROFS_REQUIREMENT_LZ4_0PADDING
> >  
> > +/*
> > + * feature definations.
> > + */
> > +#define EROFS_DEFAULT_FEATURES		EROFS_FEATURE_SB_CHKSUM
> > +#define EROFS_FEATURE_SB_CHKSUM		0x0001
> > +
> > +
> > +#define EROFS_HAS_COMPAT_FEATURE(super,mask)	\
> > +	( le32_to_cpu((super)->features) & (mask) )
> > +
> >  struct erofs_super_block {
> >  /*  0 */__le32 magic;           /* in the little endian */
> >  /*  4 */__le32 checksum;        /* crc32c(super_block) */
> > diff --git a/mkfs/main.c b/mkfs/main.c
> > index f127fe1..355fd2c 100644
> > --- a/mkfs/main.c
> > +++ b/mkfs/main.c
> > @@ -31,6 +31,45 @@ static void usage(void)
> >  	fprintf(stderr, " -EX[,...] X=extended options\n");
> >  }
> >  
> > +#define CRCPOLY	0x82F63B78
> > +static inline u32 crc32c(u32 seed, unsigned char const *in, size_t len)
> > +{
> > +	int i;
> > +	u32 crc = seed;
> > +
> > +	while (len--) {
> > +		crc ^= *in++;
> > +		for (i = 0; i < 8; i++) {
> > +			crc = (crc >> 1) ^ ((crc & 1) ? CRCPOLY : 0);
> > +		}
> > +	}
> > +	erofs_dump("calculated crc: 0x%x\n", crc);
> > +	return crc;
> > +}
> > +
> > +char *feature_opts[] = {
> > +	"nosbcrc", NULL
> > +};
> > +#define O_SB_CKSUM	0
> > +
> > +static int parse_feature_subopts(char *opts)
> > +{
> > +	char *arg;
> > +
> > +	cfg.c_feature_flags = EROFS_DEFAULT_FEATURES;
> > +	while (*opts != '\0') {
> > +		switch(getsubopt(&opts, feature_opts, &arg)) {
> > +		case O_SB_CKSUM:
> > +			cfg.c_feature_flags |= (~EROFS_FEATURE_SB_CHKSUM);
> > +			break;
> > +		default:
> > +			erofs_err("incorrect suboption");
> > +			return -EINVAL;
> > +		}
> > +	}
> > +	return 0;
> > +}
> > +
> >  static int parse_extended_opts(const char *opts)
> >  {
> >  #define MATCH_EXTENTED_OPT(opt, token, keylen) \
> > @@ -79,7 +118,8 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
> >  {
> >  	int opt, i;
> >  
> > -	while ((opt = getopt(argc, argv, "d:z:E:")) != -1) {
> > +	cfg.c_feature_flags = EROFS_DEFAULT_FEATURES;
> > +	while ((opt = getopt(argc, argv, "d:z:E:o:")) != -1) {
> >  		switch (opt) {
> >  		case 'z':
> >  			if (!optarg) {
> > @@ -113,6 +153,12 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
> >  				return opt;
> >  			break;
> >  
> > +		case 'O':
> > +			opt = parse_feature_subopts(optarg);
> > +			if (opt)
> > +				return opt;
> > +			break;
> > +
> >  		default: /* '?' */
> >  			return -EINVAL;
> >  		}
> > @@ -144,6 +190,15 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
> >  	return 0;
> >  }
> >  
> > +u32 erofs_superblock_checksum(struct erofs_super_block *sb)
> > +{
> > +	u32 crc;
> > +	crc = crc32c(~0, (const unsigned char *)sb,
> > +		    sizeof(struct erofs_super_block));
> > +	erofs_dump("superblock checksum: 0x%x\n", crc);
> > +	return crc;
> > +}
> > +
> >  int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
> >  				  erofs_nid_t root_nid)
> >  {
> > @@ -155,6 +210,7 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
> >  		.meta_blkaddr  = sbi.meta_blkaddr,
> >  		.xattr_blkaddr = 0,
> >  		.requirements = cpu_to_le32(sbi.requirements),
> > +		.features = cpu_to_le32(cfg.c_feature_flags),
> >  	};
> >  	const unsigned int sb_blksize =
> >  		round_up(EROFS_SUPER_END, EROFS_BLKSIZ);
> > @@ -169,6 +225,12 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
> >  	sb.blocks       = cpu_to_le32(erofs_mapbh(NULL, true));
> >  	sb.root_nid     = cpu_to_le16(root_nid);
> >  
> > +	if (EROFS_HAS_COMPAT_FEATURE(&sb, EROFS_FEATURE_SB_CHKSUM)) {
> > +		sb.checksum = 0;
> > +		u32 crc = erofs_superblock_checksum(&sb);
> > +		sb.checksum = cpu_to_le32(crc);
> > +	}
> > +
> >  	buf = calloc(sb_blksize, 1);
> >  	if (!buf) {
> >  		erofs_err("Failed to allocate memory for sb: %s",
> > -- 
> > 2.9.3
> > 
