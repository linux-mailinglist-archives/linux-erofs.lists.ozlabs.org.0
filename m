Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id A502FD6C29
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Oct 2019 01:45:47 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46sZtx0w3rzDqvx
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Oct 2019 10:45:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1571096745;
	bh=DiHkKMDijJ1Rux0kcs5G35JpO78m7r/xtdCNH9Wll0I=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=J4GsQbz6jvsdh08mqKobqql711aFRQ0wehOW6d13+N++1QDS+DME3cEhgr63MO1Mi
	 nJ4GW+SErySi+SX7rzM5gM79iSyOwdnhmuVEVs/mSdaqr9jx5vKPOo1R11OQ2i9lkp
	 ZeGwgJDSjXIt0S7wFatB6ml02LVL0WYfcB6bmG8QSibGoYE146zYeLrseA5LciSYvM
	 Xw7ckSRsGTxZ0cjNYUOA6V/tkhv843lrTDpEhJoOyOKeobA4dDLuYajfcJfPT54i6X
	 wpR2OWBc83uIW6Eb+d+VFpSsrTf/MVquKVGzHKRJijjSk8KRFe0knOEgHze/CM3fxN
	 we49Ix5wbV9uA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=98.137.68.206; helo=sonic304-25.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="oWG+/0k/"; 
 dkim-atps=neutral
Received: from sonic304-25.consmr.mail.gq1.yahoo.com
 (sonic304-25.consmr.mail.gq1.yahoo.com [98.137.68.206])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46sZtk5f0YzDqml
 for <linux-erofs@lists.ozlabs.org>; Tue, 15 Oct 2019 10:45:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1571096727; bh=NyYrAG/9tsEjWBPTS6g7rMcaLiJ/XO/Ipu9KiXGL1K4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=oWG+/0k/Ts6MmWJZOqrJXNha3H8l8nJq4tpltVttV9m330KkiwH43vn+YbsBKGl6tmWFFNI09SJc1varCiY3QZREelGP5awyN/weSZSOG8MkP5TLav8+bxo8sSfDb4lRjP427alExNQj5HfpqYCzJvoowH5nf8nBaQFMjnWPqgZmoGxrh5OirQcNrg8FtaQJD77L9oqcDbTxRoewyP7rjJP3q26yd0YJnz/GiTQiT6Zu8ft7u2XXldtG7ALuuyCx0iDb+LlzthyKwIUpQBdtQ7ZydgNkyT4E9+Wtb4vWoPhGEWKXvI8GUv2pk1RxmBu63QEx46VFPBa1vKUP+xOh2Q==
X-YMail-OSG: RSrpXwMVM1kmE_aWqs8DD5fl_ZhWIPuVoSECwEofCiz31bp7.WX0ZpGjVGUnuPZ
 _bN7U.cfCuJDprRQLxz_V.n_INwJdK3qai0Dm7p3F3CFcrNGBow3EHr0jZb2v.XvVNqQJQDxLNPc
 fjjSMQT_4ZL6YQvT9oRrUCz3Gc6d2.35IK03MMwIKtIGsAkqnOxayovarIaHgcTGVYyMol9HmGAx
 GnRn_3cJyP_hI.mWBb3AcApO6k46KBZpvWfSI9k5oA8GpViKjgvbIIS2kcvnzubQiD6fDEfybvY6
 1wz3ptgyAmzT5OIAtEQb2jj3GeyKSwMfOGfZ.uBQ01MDUPApxo6bU2t8FC1WEHVpWZ5hM82e8ICB
 DogCGDme9qR5.IpQ.EUIuoSB8mqAS5iTjWB4B6odLF6N5gRyFP94ukok_HenQ21RPfoyJvxqaieH
 Z869ln_OwFuxqUt8Q5SNVpUIT2W.8AYMvDq8jdkNyzEhAuIxpp99PQqwyy1qNzwGfvCttL6RITan
 C9qSUyknVUCR7cdrbs1Z4rFvbW0WIZKC.TJZVOHzQmjg1jWgW5bZCxIjPusIPr4TWY1HV8Cve5SZ
 vMjktq5IXKqP0gK6s5dPktCCKdLevjSz5QOdWOIrpvvRNYQO7qiJBvjQkTKRRAEPxXk_ZtdJDA1L
 aSJtZgAEK6XS26D5OzheaN6wHBXaRrfHx1g7lwu0Q.7mgpqZRwrCQg4HkUwh1SIAn75zhkzEPKqx
 daGW4wYRCFjbZcuQWdeGHCO.fIn728BaZNX3TLxIaavtVyG_g.D9Os5AtHSbyIUOwvOKhbOTxaWO
 xy2.goxNAVmiRiT4VMZ6TyWmNbn7DA7su4k7XWeQu91SDZJ4MV_S2WYf7Sewc2FA3a7sVjDhEBAB
 qyxv4DaGuZxWziGt6rXsQoKLJQYxQIV9RYZYlneMdSJlO236zW7JjUnxSsnmUY14h34WPe7aYsaw
 fT7dV1FH_VgHztEnW1fLXROqC8SXXEj03IQDm_CNX7z4QMvjeG.uSaN_cMh9ANK.BlhtH0rWXOTS
 SK7VyotipoHWxYu.fBQ6spUdj4FLBve0uoVB551FG6Gy7_Ol_7SjYhyc_NmOS2aOlyPJLtt5gxie
 5A4VgQNy0MMp8LCZLEebSCGGAxdfJrssL5yyr6IJ9bs7wOQZxzfY2cApeC8QmcW88x7oCs1XraBv
 iYgD6u171kWu0tSvJ5nrH3v4hWl6ZAhAdg9CtTR7lGX4Ub5IGmVisut.hiQ41fjPQuzL_gZgb1vP
 mi12Q8ObR198jqWbwhGQJzEYj8pBzQzqF7encIwIsVix88cRy3uRpDi3PVUQ6.COLQ1wccwBQ80D
 6bObyg497Dfb1MYE-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic304.consmr.mail.gq1.yahoo.com with HTTP; Mon, 14 Oct 2019 23:45:27 +0000
Received: by smtp403.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID ad31bc93f755f83c8a299bdb5c02aced; 
 Mon, 14 Oct 2019 23:45:24 +0000 (UTC)
Date: Tue, 15 Oct 2019 07:45:17 +0800
To: Pratik Shinde <pratikshinde320@gmail.com>
Subject: Re: [PATCH-v2] erofs-utils:code for calculating crc checksum of
 erofs blocks.
Message-ID: <20191014234504.GA31674@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20191014145943.2653-1-pratikshinde320@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014145943.2653-1-pratikshinde320@gmail.com>
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

Some nitpick comments... Let me know if you have other thoughts

On Mon, Oct 14, 2019 at 08:29:43PM +0530, Pratik Shinde wrote:
> Added code for calculating crc of erofs blocks (4K size).for now it calculates
> checksum of first block. but can modified to calculate crc for any no. of blocks
> 
> modified patch based on review comments.
> 
> Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
> ---
>  include/erofs/internal.h |  1 +
>  include/erofs/io.h       |  8 +++++
>  lib/io.c                 | 27 +++++++++++++++++
>  mkfs/main.c              | 76 ++++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 112 insertions(+)
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
> index 91a018f..baaf02a 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -22,6 +22,10 @@
>  
>  #define EROFS_SUPER_END (EROFS_SUPER_OFFSET + sizeof(struct erofs_super_block))
>  
> +/* number of blocks for calculating checksum */
> +#define EROFS_CKSUM_BLOCKS	1
> +#define EROFS_FEATURE_SB_CHKSUM	0x0001

How about Moving EROFS_FEATURE_SB_CHKSUM to erofs_fs.h since it's
an on-disk definition,

> +
>  static void usage(void)
>  {
>  	fprintf(stderr, "usage: [options] FILE DIRECTORY\n\n");
> @@ -85,6 +89,10 @@ static int parse_extended_opts(const char *opts)
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
> @@ -180,6 +188,7 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
>  		.meta_blkaddr  = sbi.meta_blkaddr,
>  		.xattr_blkaddr = 0,
>  		.feature_incompat = cpu_to_le32(sbi.feature_incompat),
> +		.checksum = 0
>  	};
>  	const unsigned int sb_blksize =
>  		round_up(EROFS_SUPER_END, EROFS_BLKSIZ);
> @@ -202,6 +211,70 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
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
> +		erofs_err("Failed to calculate erofs checksum - %s",
> +			  erofs_strerror(err));
> +		return err;
> +	}
> +	*crc = crc32c(0, (const unsigned char *)buf, nblks * EROFS_BLKSIZ);
> +	free(buf);
> +	return 0;
> +}
> +
> +void erofs_write_checksum()

How about naming write_sb_checksum?
My idea is that this is a checksum in super block (rather than
a checksum only for super block [0th block])

Let me know if you have another thought...

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
> +		erofs_err("error reading super-block structure");
> +		return;
> +	}
> +
> +	sb = (struct erofs_super_block *)((u8 *)buf + EROFS_SUPER_OFFSET);
> +	if (le32_to_cpu(sb->magic) != EROFS_SUPER_MAGIC_V1) {
> +		erofs_err("not an erofs image");

As the previous comments, I am little care about these print messages
since users will only see this and "error reading super-block structure"
"not an erofs image" makes confused for them... (They don't know what
the internal process is doing)

BTW, it looks good to me as a whole... Do you have some time on
kernel side as well? :)

Thanks,
Gao Xiang

> +		return;
> +	}
> +	sb->checksum = cpu_to_le32(crc);
> +	ret = blk_write(buf, 0, 1);
> +	if (ret) {
> +		erofs_err("error writing 0th block to disk - %s",
> +			  erofs_strerror(ret));
> +		return;
> +	}
> +}
> +
>  int main(int argc, char **argv)
>  {
>  	int err = 0;
> @@ -217,6 +290,7 @@ int main(int argc, char **argv)
>  
>  	cfg.c_legacy_compress = false;
>  	sbi.feature_incompat = EROFS_FEATURE_INCOMPAT_LZ4_0PADDING;
> +	sbi.feature = EROFS_FEATURE_SB_CHKSUM;
>  
>  	err = mkfs_parse_options_cfg(argc, argv);
>  	if (err) {
> @@ -301,6 +375,8 @@ int main(int argc, char **argv)
>  		err = -EIO;
>  	else
>  		err = dev_resize(nblocks);
> +	if (sbi.feature & EROFS_FEATURE_SB_CHKSUM)
> +		erofs_write_checksum();
>  exit:
>  	z_erofs_compress_exit();
>  	dev_close();
> -- 
> 2.9.3
> 
