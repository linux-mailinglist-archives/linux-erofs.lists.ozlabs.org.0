Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 479A1D79A4
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Oct 2019 17:22:17 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46szgV0MTZzDqsh
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Oct 2019 02:22:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1571152934;
	bh=i6UcMO9To7xn4Fbfwe3sWtcwrJSjlIKxb/pC3nKCIeg=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=dwMlSDEc77Q1I+3cJZCkNGqd2PvwVJJdWZNxrjQejeJkbwPmNmrF+97xWlQeYAL+g
	 qighE061yXdiGLk7uhhFXhcuWBmBNPuNofJVKvlbVcOZVHANZEkgbwnc3KGqeJ5AQi
	 8MY8vYmhVC0pTdBsG8J2ex30RYbLS3fwgYJrNzV8rvqLCrc/VDOFQAmzS59giwmha7
	 KQFVh0S6PEC2pSakszAqpn7gYoZiPnvnPyk6b7vq7ElKTsa/4DHHni7ymkF7c7hI2b
	 TFfnNk5ans/nqza+icm41BAOFWiZp1vQEIvD0AUw2aQN/EyfLXWdR0KvEN/2YQtzeX
	 z1eeBttsM/IGQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=87.248.110.31; helo=sonic307-54.consmr.mail.ir2.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="biy3FJPh"; 
 dkim-atps=neutral
Received: from sonic307-54.consmr.mail.ir2.yahoo.com
 (sonic307-54.consmr.mail.ir2.yahoo.com [87.248.110.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46szcP4Nb0zDr3y
 for <linux-erofs@lists.ozlabs.org>; Wed, 16 Oct 2019 02:19:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1571152745; bh=1t0AH3fimeWY76hMGKwcABbH69BbRClitrJHRtkk5X8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=biy3FJPh5TCJDjvYhE2tZ4+UhxGncnwNKkN28LSeEe9vfSlWzJi+ZHbODXpuBwjteHoQ9hHNrPu6Y7Wa8TwOnop0ENEpOYz3EfWx1EFoPjAc8/yWEz5jccgQxidRtLjD1ATHctw/wwKfG6OOlxY74LBTiXDHXqGulWVC8NkeTyMxlaJFl9tvUSQ7/kVjnWdJsuUC51YX/c3kwExppAi/l6IL0xZ877b7MfjKxe5pMdqoMS7Ycd+GRAmF8DDzKLa8S4Qh+F/Eu0fqnzCuuXRtjwG/qxGOlqKAeWA1y+ZCKNiXvI+LJFMjH3V0cRdD1BjUlc6Qqg8sNbwPkpgbsmPAGw==
X-YMail-OSG: 5d4LzRUVM1kzy9u.CXoNtc7SNIn3xy0gmJMAcQEMY9T6nHa93C39ObO2o.m.VNS
 FxVtFf4shVg_DhuIqXuyBcH23qn3Rpiyc9SIRq2.7XdqxK7kqaYnSYgzvAPyEduOtSKnCdkEa.ED
 nFRtptXmHQA_SyE9KpUZgf_CAn7rR9velSj0.xfrWsSsz0.KGHATn04bYSVpDsKxKgsKg09TUd1z
 mEvk_L_Z37vPLdvALNV7Aq78Z3zAjWJefY1grhZ0VSvnL97K31rad1.B9LGpPTSVmd_V5JkqaDKR
 pT9jg91eg3BxNFPzaAV09kQxoxyhECpPZpC2IgWC.1.JPDw_E_UF7iHFOwsJGN.4iOy5f_q2ZBQq
 t5J1vhpaYL0uJHpfa8yX1RwfWgHARc3TUBjRKWkPoFlaTnmML89hp9MpLtrHRxV3EcyoVgQqXs0s
 Dg5s5zp6Wj04xhq5yr7W4EAd.7fp3ycabyFGhfJr3HuPriUTGwLGnFGtpEnslDwlGL.8L2Vu4IlY
 Nl88g6TgBsz7LpfwnIp7gd4p6K427T9amZQddXuVmZ7ZjJ3uVt1VFrGggup.IwhGWI8lkhf8jvUa
 SpQQb1PDzv1zMbD.B1_sBOz.lHHgBs0ojZ0y6jk9VkSRxGoUwokgN.2OQ5LK22XLAGswxQJKejzj
 u2pyy9aOVUZ8DYp9zdXqVZ_Z9EceZxO.xgbcCqpewlV4tBMN5aKMfOFHPa22wJy91PZKfB1r.720
 MfwqEXknKvQBnl54JhvKYpaX88MLnzIYRnM2N1Ir69zD17CJeVPRLA2VmLq.3H7NY.r_kxSvl7fR
 58PRe.19ZHTY9ZL95CCNQWwGVvPf3UffUaCJvUdB_f_0a16O_J2PwlMAFzZ3ikspjut_HLC5kBNX
 9xF7cHejlfDkLrOS.YS85rjzuIJhVIlm.yuJCFOrVPrd24zGlpb1Vz6nGWlR3Ga5.YZK6q_nfo6z
 xkubeKE3wUjFHhhKDb2JD5tkJG.898IvnYUS8y_8riRdhQ4lS4_0Lyepvq4xUA87G5oJV1Rn56XH
 4L0OCjMfhqPf1oaPKjtfLrq5sW5ZeNIkWaMeyClVZRccjjRw_2wkCFAZ3aNS4S.WAJga_dn0R_Jg
 Z4cCXq3PyrB5PCPU6ntCJG8JO3UyS5lLrORxh.cG.kJIjDfqQCuWcjNF5DMJT_UDkWu03gaMSDL0
 BXFfyi6nsOiDYQuE1NfEIq8Nq3qC0arjefDOLGPcVacIFTRjjdnpjcibrFty0J.0hCWLscn8Kmry
 joWndZuLxQqo8R52X3KNSCLq.24hIjk_qSVr6ptT0ore4c3JFShNRdN_wnpayhLzs5iSRlPHiQYI
 FiWTOhiFo0_nvig--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic307.consmr.mail.ir2.yahoo.com with HTTP; Tue, 15 Oct 2019 15:19:05 +0000
Received: by smtp416.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID fb9e5517d9e31647ef3bd4d025d580bf; 
 Tue, 15 Oct 2019 15:19:01 +0000 (UTC)
Date: Tue, 15 Oct 2019 23:18:47 +0800
To: Li Guifu <blucerlee@gmail.com>
Subject: Re: [PATCH-v3] erofs-utils:code for calculating crc checksum of
 erofs blocks.
Message-ID: <20191015151844.GA11098@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20191015051830.7756-1-pratikshinde320@gmail.com>
 <2e0cf8fd-4b60-d8a4-e7ed-17e9f7674826@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e0cf8fd-4b60-d8a4-e7ed-17e9f7674826@gmail.com>
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

Hi Guifu,

On Tue, Oct 15, 2019 at 11:11:43PM +0800, Li Guifu wrote:
> Hi Pratik, Gao Xiang
> 
> Can sbi.fearture merge into sbi.feature_incompat ?
> If not, it will has two feature parameter

Nope, please refer to
https://lore.kernel.org/r/20190822142142.GB2730@mit.edu/

> 
> It has the blocks field in the super block, chksum_blocks duplicates it.
> and chksum may be used to check whole erofs image file.

Nope, chksum_blocks is used for checksuming given blocks, blocks field is
designed to be used for statfs.

Thanks,
Gao Xiang

> 
> > Added code for calculating crc of erofs blocks (4K size).for now it calculates
> > checksum of first block. but can modified to calculate crc for any no. of blocks
> > 
> > 1) Added 'chksum_blocks' field to erofs_super_block
> > 2) removed unnecessary prints
> > 3) moved EROFS_FEATURE_SB_CHKSUM include/erofs_fs.h
> > 
> > Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
> > ---
> >   include/erofs/internal.h |  1 +
> >   include/erofs/io.h       |  8 ++++++
> >   include/erofs_fs.h       |  3 ++-
> >   lib/io.c                 | 27 +++++++++++++++++++
> >   mkfs/main.c              | 70 ++++++++++++++++++++++++++++++++++++++++++++++++
> >   5 files changed, 108 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/erofs/internal.h b/include/erofs/internal.h
> > index 5384946..53335bc 100644
> > --- a/include/erofs/internal.h
> > +++ b/include/erofs/internal.h
> > @@ -55,6 +55,7 @@ struct erofs_sb_info {
> >   	u32 feature_incompat;
> >   	u64 build_time;
> >   	u32 build_time_nsec;
> > +	u32 feature;
> >   };
> >   /* global sbi */
> > diff --git a/include/erofs/io.h b/include/erofs/io.h
> > index 9775047..e0ca8d9 100644
> > --- a/include/erofs/io.h
> > +++ b/include/erofs/io.h
> > @@ -19,6 +19,7 @@
> >   int dev_open(const char *devname);
> >   void dev_close(void);
> >   int dev_write(const void *buf, u64 offset, size_t len);
> > +int dev_read(void *buf, u64 offset, size_t len);
> >   int dev_fillzero(u64 offset, size_t len, bool padding);
> >   int dev_fsync(void);
> >   int dev_resize(erofs_blk_t nblocks);
> > @@ -31,5 +32,12 @@ static inline int blk_write(const void *buf, erofs_blk_t blkaddr,
> >   			 blknr_to_addr(nblocks));
> >   }
> > +static inline int blk_read(void *buf, erofs_blk_t start,
> > +			    u32 nblocks)
> > +{
> > +	return dev_read(buf, blknr_to_addr(start),
> > +			 blknr_to_addr(nblocks));
> > +}
> > +
> >   #endif
> > diff --git a/include/erofs_fs.h b/include/erofs_fs.h
> > index f29aa25..8bd29d6 100644
> > --- a/include/erofs_fs.h
> > +++ b/include/erofs_fs.h
> > @@ -19,6 +19,7 @@
> >    */
> >   #define EROFS_FEATURE_INCOMPAT_LZ4_0PADDING	0x00000001
> >   #define EROFS_ALL_FEATURE_INCOMPAT		EROFS_FEATURE_INCOMPAT_LZ4_0PADDING
> > +#define EROFS_FEATURE_SB_CHKSUM	0x0001
> >   /* 128-byte erofs on-disk super block */
> >   struct erofs_super_block {
> > @@ -39,7 +40,7 @@ struct erofs_super_block {
> >   	__u8 uuid[16];          /* 128-bit uuid for volume */
> >   	__u8 volume_name[16];   /* volume name */
> >   	__le32 feature_incompat;
> > -
> > +	__le32 chksum_blocks;	/* number of blocks used for checksum */
> >   	__u8 reserved2[44];
> >   };
> > diff --git a/lib/io.c b/lib/io.c
> > index 7f5f94d..52f9424 100644
> > --- a/lib/io.c
> > +++ b/lib/io.c
> > @@ -207,3 +207,30 @@ int dev_resize(unsigned int blocks)
> >   	return dev_fillzero(st.st_size, length, true);
> >   }
> > +int dev_read(void *buf, u64 offset, size_t len)
> > +{
> > +	int ret;
> > +
> > +	if (cfg.c_dry_run)
> > +		return 0;
> > +
> > +	if (!buf) {
> > +		erofs_err("buf is NULL");
> > +		return -EINVAL;
> > +	}
> > +	if (offset >= erofs_devsz || len > erofs_devsz ||
> > +	    offset > erofs_devsz - len) {
> > +		erofs_err("read posion[%" PRIu64 ", %zd] is too large beyond"
> > +			  "the end of device(%" PRIu64 ").",
> > +			  offset, len, erofs_devsz);
> > +		return -EINVAL;
> > +	}
> > +
> > +	ret = pread64(erofs_devfd, buf, len, (off64_t)offset);
> > +	if (ret != (int)len) {
> > +		erofs_err("Failed to read data from device - %s:[%" PRIu64 ", %zd].",
> > +			  erofs_devname, offset, len);
> > +		return -errno;
> > +	}
> > +	return 0;
> > +}
> > diff --git a/mkfs/main.c b/mkfs/main.c
> > index 91a018f..0633e83 100644
> > --- a/mkfs/main.c
> > +++ b/mkfs/main.c
> > @@ -22,6 +22,9 @@
> >   #define EROFS_SUPER_END (EROFS_SUPER_OFFSET + sizeof(struct erofs_super_block))
> > +/* number of blocks for calculating checksum */
> > +#define EROFS_CKSUM_BLOCKS	1
> > +
> >   static void usage(void)
> >   {
> >   	fprintf(stderr, "usage: [options] FILE DIRECTORY\n\n");
> > @@ -85,6 +88,10 @@ static int parse_extended_opts(const char *opts)
> >   				return -EINVAL;
> >   			cfg.c_force_inodeversion = FORCE_INODE_EXTENDED;
> >   		}
> > +
> > +		if (MATCH_EXTENTED_OPT("nocrc", token, keylen)) {
> > +			sbi.feature &= ~EROFS_FEATURE_SB_CHKSUM;
> > +		}
> >   	}
> >   	return 0;
> >   }
> > @@ -180,6 +187,8 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
> >   		.meta_blkaddr  = sbi.meta_blkaddr,
> >   		.xattr_blkaddr = 0,
> >   		.feature_incompat = cpu_to_le32(sbi.feature_incompat),
> > +		.checksum = 0,
> > +		.chksum_blocks = cpu_to_le32(EROFS_CKSUM_BLOCKS)
> >   	};
> >   	const unsigned int sb_blksize =
> >   		round_up(EROFS_SUPER_END, EROFS_BLKSIZ);
> > @@ -202,6 +211,64 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
> >   	return 0;
> >   }
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
> > +	return crc;
> > +}
> > +
> > +/* calculate checksum for first n blocks */
> > +u32 erofs_calc_blk_checksum(erofs_blk_t nblks, u32 *crc)
> > +{
> > +	char *buf;
> > +	int err = 0;
> > +
> > +	buf = malloc(nblks * EROFS_BLKSIZ);
> > +	err = blk_read(buf, 0, nblks);
> > +	if (err) {
> > +		return err;
> > +	}
> > +	*crc = crc32c(0, (const unsigned char *)buf, nblks * EROFS_BLKSIZ);
> > +	free(buf);
> > +	return 0;
> > +}
> > +
> > +void erofs_write_sb_checksum()
> > +{
> > +	struct erofs_super_block *sb;
> > +	char buf[EROFS_BLKSIZ];
> > +	int ret = 0;
> > +	u32 crc;
> > +
> > +	ret = erofs_calc_blk_checksum(EROFS_CKSUM_BLOCKS, &crc);
> > +	if (ret) {
> > +		return;
> > +	}
> > +	ret = blk_read(buf, 0, 1);
> > +	if (ret) {
> > +		return;
> > +	}
> > +
> > +	sb = (struct erofs_super_block *)((u8 *)buf + EROFS_SUPER_OFFSET);
> > +	if (le32_to_cpu(sb->magic) != EROFS_SUPER_MAGIC_V1) {
> > +		return;
> > +	}
> > +	sb->checksum = cpu_to_le32(crc);
> > +	ret = blk_write(buf, 0, 1);
> > +	if (ret) {
> > +		return;
> > +	}
> > +}
> > +
> >   int main(int argc, char **argv)
> >   {
> >   	int err = 0;
> > @@ -217,6 +284,7 @@ int main(int argc, char **argv)
> >   	cfg.c_legacy_compress = false;
> >   	sbi.feature_incompat = EROFS_FEATURE_INCOMPAT_LZ4_0PADDING;
> > +	sbi.feature = EROFS_FEATURE_SB_CHKSUM;
> >   	err = mkfs_parse_options_cfg(argc, argv);
> >   	if (err) {
> > @@ -301,6 +369,8 @@ int main(int argc, char **argv)
> >   		err = -EIO;
> >   	else
> >   		err = dev_resize(nblocks);
> > +	if (sbi.feature & EROFS_FEATURE_SB_CHKSUM)
> > +		erofs_write_sb_checksum();
> >   exit:
> >   	z_erofs_compress_exit();
> >   	dev_close();
> > 
