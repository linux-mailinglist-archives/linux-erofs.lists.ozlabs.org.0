Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id D7FBCDDD6D
	for <lists+linux-erofs@lfdr.de>; Sun, 20 Oct 2019 11:06:44 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46wv5m4pKczDqSj
	for <lists+linux-erofs@lfdr.de>; Sun, 20 Oct 2019 20:06:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1571562396;
	bh=DtBkhlIS+Ouz9PTUZnLKt5dVwFcR4qOiDQ7u6u4hB0Y=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=UjB0DYZ8OpO+Fqo/7fq6wgx1CLfkae5S+t53EKTYtyFVkEcwtDNfL2Gu6lpolWhvr
	 KTjzc7FfQvwD9z+NUS68W1nWn4uyqm/OnVXmcmPJ2Hrpkg6telbi+GWGAEdQU+aQi7
	 U0cPMseiLjqsVudNVEaMyuRUewPVrCm8vmG3tpl1a/uEgG8YtpBhSmMRFj6vfTlV6N
	 +ymO6a1grQ9h3GPgBa8tg1MWW5s4cJpapbIWEwUpZQxz3rlhp0Ra+KTlcn11mnhv56
	 akYU8ynfCjwRTTYn6xyKjKAeYe+LXzl98iiPzU/PB2RA0IfMOvkoosnCcdp69YT/+D
	 /sABIc/P0nVjw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=87.248.110.83; helo=sonic302-20.consmr.mail.ir2.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="NKmWdYFG"; 
 dkim-atps=neutral
Received: from sonic302-20.consmr.mail.ir2.yahoo.com
 (sonic302-20.consmr.mail.ir2.yahoo.com [87.248.110.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46wv5W1c1vzDqRq
 for <linux-erofs@lists.ozlabs.org>; Sun, 20 Oct 2019 20:06:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1571562374; bh=o+j5RQVeevf9eFHVPb3WehuH+sL2YrjCW6A1x4iGfH4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=NKmWdYFGwRlkL40VLFP3c5cbxMzQDoWx1gQseYHGRcbQK7ZtHhB4Jcar9cT7Z+8J9UoyrkkEK2HUEbKvWmxb9I2N/r4H79GM4Iy4EcaE181fVutXaVbqT78Vm1CkZ3YULLTSbbScpa0mKbJbE0eMVyiNmr7tFD6+/SBrFv4nHHSwXHbbm4n8M4k20YhTgMTKFugAp33nuPWQdnCkWRHo5xnCNDddxpHwSwXjpAY9digZ+Kt35GtAqeh3gPRBpVr6bKW9kflS7h/iIMcFgoMAb8oV7LvZHlak5Drqzbr/dwJSyVBt38riCffTLuo07Yx/SbtysbJxsJUXjbBryntrvg==
X-YMail-OSG: BuGw5oEVM1nU74rAq5TmaGr93t4ER0JR1ZxR0Ml1CfusGHOja_fXELpHCpb13SI
 3HY9lpDMXhhy.5oiLJInEGM3.xPD37Qt4B.hvHjoBA_XBscj.6wo_6MQ.W3tfCMNZOJmOz4hqrHZ
 BH1ZJX0RfMFpzp031hpjWY_e6uVH_JybhFGkEkacl6uPIkt6EN8e59MnD2xn5alsUihpMxRkV9F9
 a19YrVXTZvJOeTmw9uQV.FxWFK0Z8p6dNKU5h3xjMBgYeMT8Ia0SlGHUEt83LaAoobo4IOzqFt2d
 qyWa6MgHJ9cVm2OMly6MS421bzlNKN8FVNr.MqrK0EK2btIaNS9TVjoFyTxqo4rho1RodqS5ijcT
 4V4RnNYdhKz_CVZuk6iaY02DCYcX8ZUtxULyeZ4v9qUjAMbHystINuTJTDkSGdqdbCzQe8FLIyi7
 0AbSxM06mrandvPqhRIjoGly6LWhOkIzr0JBDJJuk53Okpw36YlJx00vQ18En_ujbLrL62JwM3aY
 eE57MhQ8YYlMC.NUHyHWTzLg5pL8cfIItlVTBDCQq4X1vqYUjfkpGlDWlGQbjwkTdB3HupqlMbvc
 wz8gsfnjkOnb9WSZYyfc42SIxoIDS1wH0ttcXmhg_6fRuRkMQMV4w3M_1xsEzj1jC4xwW6ksHm4t
 hBYAUv68Z2OCaoaG2he7rysVaAw7twQY10VmCm35OfXUBnjtvgh7l5O.69uJaq8Ki0J1R407MoLh
 6oFs3Le1GEXthbvz7lVvG_r5tTBMP_x8X5Av3ouJa1nQpurg0mJtRS6t44jw81S9IdGW8VHeuryw
 ZI.FAFQKiPMUnqAlhMJi9isE6hKHRY4g6YiSwVCnWsYLhE6hk7YNqvUPGeaJplIfxwHYFNpVXX.s
 jbwj_rPnjdFS1P9mhFtOSibGvqgZyqGUc847stGsefDkqNbKCmf9Nbhwbuoh4LafpiIpyksszpEx
 6H3XyhViX0RUFc.eWejAM7BXzxHJQq6qLN6O1TrO0mF0Gdr_BOA86GSLPxVm95cbtTy6JR0HzMII
 7.ZONa.CAHOBBaFzsf34RJn2dXXiRXJ8hXLNFQYI2Ery0wq0e98Pp3.o.dJj.zbxgngJuy6NWM4e
 2nGUTwiCom3cacoZ_GgkUXEP_IUS1OB0DA4P6PwVPSIrZD20H04VXOzC4ZFETIjNsdGBdN4fc76L
 x6oRJtPLcAEShPsXY1hk4P9X343Yma27wtP5vmKKTgEA3GyxcPS3SwzFEIqIQKtYD0xrOgaXQX1v
 fzqtpro2hGhKyU7c6DjqxZz3jD4Tp7sZu6MC8oUYwiZu7QPwUyEnTwpW2u3N9oDHZcPcFK7Cke8L
 Load_65cJU91SNFGsbLymoIjQJzo-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic302.consmr.mail.ir2.yahoo.com with HTTP; Sun, 20 Oct 2019 09:06:14 +0000
Received: by smtp418.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 577b8bcb4f95bfb8409ee50d7de85083; 
 Sun, 20 Oct 2019 09:06:12 +0000 (UTC)
Date: Sun, 20 Oct 2019 17:06:05 +0800
To: Pratik Shinde <pratikshinde320@gmail.com>
Subject: Re: [PATCH-v5] erofs-utils:code for calculating crc checksum of
 erofs blocks
Message-ID: <20191020090601.GA19763@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20191019150803.9259-1-pratikshinde320@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191019150803.9259-1-pratikshinde320@gmail.com>
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

I was attending "China Linux Storage and File System (CLSF) Workshop
2019" (with EROFS roadmap discussed) these days, sorry about delaying
... I will take this version with little print messages added this
evening... Don't worry, I will certainly do. :-)

Thanks,
Gao Xiang

On Sat, Oct 19, 2019 at 08:38:03PM +0530, Pratik Shinde wrote:
> Added code for calculating crc of erofs blocks (4K size).for now it calculates
> checksum of first block. but can modified to calculate crc for any no. of blocks
> 
> Fill 'feature_compat' field of erofs_super_block so that it
> can be used on kernel side. also fixing one typo.
> 
> Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
> ---
>  include/erofs/internal.h |  1 +
>  include/erofs/io.h       |  8 ++++++
>  include/erofs_fs.h       |  5 ++--
>  lib/io.c                 | 27 ++++++++++++++++++
>  mkfs/main.c              | 71 ++++++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 110 insertions(+), 2 deletions(-)
> 
> diff --git a/include/erofs/internal.h b/include/erofs/internal.h
> index 5384946..53335bc 100644
> --- a/include/erofs/internal.h
> +++ b/include/erofs/internal.h
> @@ -55,6 +55,7 @@ struct erofs_sb_info {
>  	u32 feature_incompat;
>  	u64 build_time;
>  	u32 build_time_nsec;
> +	u32 feature;
>  };
>  
>  /* global sbi */
> diff --git a/include/erofs/io.h b/include/erofs/io.h
> index 9775047..e0ca8d9 100644
> --- a/include/erofs/io.h
> +++ b/include/erofs/io.h
> @@ -19,6 +19,7 @@
>  int dev_open(const char *devname);
>  void dev_close(void);
>  int dev_write(const void *buf, u64 offset, size_t len);
> +int dev_read(void *buf, u64 offset, size_t len);
>  int dev_fillzero(u64 offset, size_t len, bool padding);
>  int dev_fsync(void);
>  int dev_resize(erofs_blk_t nblocks);
> @@ -31,5 +32,12 @@ static inline int blk_write(const void *buf, erofs_blk_t blkaddr,
>  			 blknr_to_addr(nblocks));
>  }
>  
> +static inline int blk_read(void *buf, erofs_blk_t start,
> +			    u32 nblocks)
> +{
> +	return dev_read(buf, blknr_to_addr(start),
> +			 blknr_to_addr(nblocks));
> +}
> +
>  #endif
>  
> diff --git a/include/erofs_fs.h b/include/erofs_fs.h
> index f29aa25..9eda6c2 100644
> --- a/include/erofs_fs.h
> +++ b/include/erofs_fs.h
> @@ -19,6 +19,7 @@
>   */
>  #define EROFS_FEATURE_INCOMPAT_LZ4_0PADDING	0x00000001
>  #define EROFS_ALL_FEATURE_INCOMPAT		EROFS_FEATURE_INCOMPAT_LZ4_0PADDING
> +#define EROFS_FEATURE_SB_CHKSUM	0x0001
>  
>  /* 128-byte erofs on-disk super block */
>  struct erofs_super_block {
> @@ -39,8 +40,8 @@ struct erofs_super_block {
>  	__u8 uuid[16];          /* 128-bit uuid for volume */
>  	__u8 volume_name[16];   /* volume name */
>  	__le32 feature_incompat;
> -
> -	__u8 reserved2[44];
> +	__le32 chksum_blocks;	/* number of blocks used for checksum */
> +	__u8 reserved2[40];
>  };
>  
>  /*
> diff --git a/lib/io.c b/lib/io.c
> index 7f5f94d..52f9424 100644
> --- a/lib/io.c
> +++ b/lib/io.c
> @@ -207,3 +207,30 @@ int dev_resize(unsigned int blocks)
>  	return dev_fillzero(st.st_size, length, true);
>  }
>  
> +int dev_read(void *buf, u64 offset, size_t len)
> +{
> +	int ret;
> +
> +	if (cfg.c_dry_run)
> +		return 0;
> +
> +	if (!buf) {
> +		erofs_err("buf is NULL");
> +		return -EINVAL;
> +	}
> +	if (offset >= erofs_devsz || len > erofs_devsz ||
> +	    offset > erofs_devsz - len) {
> +		erofs_err("read posion[%" PRIu64 ", %zd] is too large beyond"
> +			  "the end of device(%" PRIu64 ").",
> +			  offset, len, erofs_devsz);
> +		return -EINVAL;
> +	}
> +
> +	ret = pread64(erofs_devfd, buf, len, (off64_t)offset);
> +	if (ret != (int)len) {
> +		erofs_err("Failed to read data from device - %s:[%" PRIu64 ", %zd].",
> +			  erofs_devname, offset, len);
> +		return -errno;
> +	}
> +	return 0;
> +}
> diff --git a/mkfs/main.c b/mkfs/main.c
> index 91a018f..c7cb923 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -22,6 +22,9 @@
>  
>  #define EROFS_SUPER_END (EROFS_SUPER_OFFSET + sizeof(struct erofs_super_block))
>  
> +/* number of blocks for calculating checksum */
> +#define EROFS_CKSUM_BLOCKS	1
> +
>  static void usage(void)
>  {
>  	fprintf(stderr, "usage: [options] FILE DIRECTORY\n\n");
> @@ -85,6 +88,10 @@ static int parse_extended_opts(const char *opts)
>  				return -EINVAL;
>  			cfg.c_force_inodeversion = FORCE_INODE_EXTENDED;
>  		}
> +
> +		if (MATCH_EXTENTED_OPT("nocrc", token, keylen)) {
> +			sbi.feature &= ~EROFS_FEATURE_SB_CHKSUM;
> +		}
>  	}
>  	return 0;
>  }
> @@ -180,6 +187,9 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
>  		.meta_blkaddr  = sbi.meta_blkaddr,
>  		.xattr_blkaddr = 0,
>  		.feature_incompat = cpu_to_le32(sbi.feature_incompat),
> +		.feature_compat = cpu_to_le32(sbi.feature),
> +		.checksum = 0,
> +		.chksum_blocks = cpu_to_le32(EROFS_CKSUM_BLOCKS)
>  	};
>  	const unsigned int sb_blksize =
>  		round_up(EROFS_SUPER_END, EROFS_BLKSIZ);
> @@ -202,6 +212,64 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
>  	return 0;
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
> +	return crc;
> +}
> +
> +/* calculate checksum for first n blocks */
> +u32 erofs_calc_blk_checksum(erofs_blk_t nblks, u32 *crc)
> +{
> +	char *buf;
> +	int err = 0;
> +
> +	buf = malloc(nblks * EROFS_BLKSIZ);
> +	err = blk_read(buf, 0, nblks);
> +	if (err) {
> +		return err;
> +	}
> +	*crc = crc32c(0, (const unsigned char *)buf, nblks * EROFS_BLKSIZ);
> +	free(buf);
> +	return 0;
> +}
> +
> +void erofs_write_sb_checksum()
> +{
> +	struct erofs_super_block *sb;
> +	char buf[EROFS_BLKSIZ];
> +	int ret = 0;
> +	u32 crc;
> +
> +	ret = erofs_calc_blk_checksum(EROFS_CKSUM_BLOCKS, &crc);
> +	if (ret) {
> +		return;
> +	}
> +	ret = blk_read(buf, 0, 1);
> +	if (ret) {
> +		return;
> +	}
> +
> +	sb = (struct erofs_super_block *)((u8 *)buf + EROFS_SUPER_OFFSET);
> +	if (le32_to_cpu(sb->magic) != EROFS_SUPER_MAGIC_V1) {
> +		return;
> +	}
> +	sb->checksum = cpu_to_le32(crc);
> +	ret = blk_write(buf, 0, 1);
> +	if (ret) {
> +		return;
> +	}
> +}
> +
>  int main(int argc, char **argv)
>  {
>  	int err = 0;
> @@ -217,6 +285,7 @@ int main(int argc, char **argv)
>  
>  	cfg.c_legacy_compress = false;
>  	sbi.feature_incompat = EROFS_FEATURE_INCOMPAT_LZ4_0PADDING;
> +	sbi.feature = EROFS_FEATURE_SB_CHKSUM;
>  
>  	err = mkfs_parse_options_cfg(argc, argv);
>  	if (err) {
> @@ -301,6 +370,8 @@ int main(int argc, char **argv)
>  		err = -EIO;
>  	else
>  		err = dev_resize(nblocks);
> +	if (sbi.feature & EROFS_FEATURE_SB_CHKSUM)
> +		erofs_write_sb_checksum();
>  exit:
>  	z_erofs_compress_exit();
>  	dev_close();
> -- 
> 2.9.3
> 
