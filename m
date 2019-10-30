Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1848CE9518
	for <lists+linux-erofs@lfdr.de>; Wed, 30 Oct 2019 03:52:40 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 472tKd17q4zF3kB
	for <lists+linux-erofs@lfdr.de>; Wed, 30 Oct 2019 13:52:37 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga01-in.huawei.com [45.249.212.187])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 472tKX1St3zF3Ts
 for <linux-erofs@lists.ozlabs.org>; Wed, 30 Oct 2019 13:52:29 +1100 (AEDT)
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.57])
 by Forcepoint Email with ESMTP id AF8DF3B04E9154457747
 for <linux-erofs@lists.ozlabs.org>; Wed, 30 Oct 2019 10:52:21 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 30 Oct 2019 10:52:21 +0800
Received: from architecture4 (10.140.130.215) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Wed, 30 Oct 2019 10:52:21 +0800
Date: Wed, 30 Oct 2019 10:55:06 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v8] erofs-utils: support calculating checksum of erofs
 blocks
Message-ID: <20191030025506.GA161610@architecture4>
References: <20191023034957.184711-1-gaoxiang25@huawei.com>
 <20191028142353.123204-1-gaoxiang25@huawei.com>
 <d64d79cd-6e1a-e200-6264-23fe4dfdf895@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d64d79cd-6e1a-e200-6264-23fe4dfdf895@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.140.130.215]
X-ClientProxiedBy: dggeme713-chm.china.huawei.com (10.1.199.109) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
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
Cc: Miao Xie <miaoxie@huawei.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Chao,

On Wed, Oct 30, 2019 at 10:39:18AM +0800, Chao Yu wrote:
> On 2019/10/28 22:23, Gao Xiang wrote:
> > From: Pratik Shinde <pratikshinde320@gmail.com>
> > 
> > Added code for calculating crc of erofs blocks (4K size).
> > For now it calculates checksum of first block. but it can
> > be modified to calculate crc for any no. of blocks.
> > 
> > Note that the first 1024 bytes are not checksumed to allow
> > for the installation of x86 boot sectors and other oddities.
> > 
> > Fill 'feature_compat' field of erofs_super_block so that it
> > can be used on kernel side. also fixing one typo.
> > 
> > Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
> > Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> > ---
> > 
> > changes since v7:
> >  - get rid of `chksum_blocks' pointed out by Chao.
> > 
> > 
> >  include/erofs/internal.h |  1 +
> >  include/erofs/io.h       |  8 +++++
> >  include/erofs_fs.h       |  3 +-
> >  lib/io.c                 | 27 ++++++++++++++++
> >  mkfs/main.c              | 68 ++++++++++++++++++++++++++++++++++++++++
> >  5 files changed, 106 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/erofs/internal.h b/include/erofs/internal.h
> > index 25ce7b54442d..9e2bb9ce33b6 100644
> > --- a/include/erofs/internal.h
> > +++ b/include/erofs/internal.h
> > @@ -52,6 +52,7 @@ struct erofs_sb_info {
> >  	erofs_blk_t meta_blkaddr;
> >  	erofs_blk_t xattr_blkaddr;
> >  
> > +	u32 feature_compat;
> >  	u32 feature_incompat;
> >  	u64 build_time;
> >  	u32 build_time_nsec;
> > diff --git a/include/erofs/io.h b/include/erofs/io.h
> > index 97750478b5ab..e0ca8d949130 100644
> > --- a/include/erofs/io.h
> > +++ b/include/erofs/io.h
> > @@ -19,6 +19,7 @@
> >  int dev_open(const char *devname);
> >  void dev_close(void);
> >  int dev_write(const void *buf, u64 offset, size_t len);
> > +int dev_read(void *buf, u64 offset, size_t len);
> >  int dev_fillzero(u64 offset, size_t len, bool padding);
> >  int dev_fsync(void);
> >  int dev_resize(erofs_blk_t nblocks);
> > @@ -31,5 +32,12 @@ static inline int blk_write(const void *buf, erofs_blk_t blkaddr,
> >  			 blknr_to_addr(nblocks));
> >  }
> >  
> > +static inline int blk_read(void *buf, erofs_blk_t start,
> > +			    u32 nblocks)
> > +{
> > +	return dev_read(buf, blknr_to_addr(start),
> > +			 blknr_to_addr(nblocks));
> > +}
> > +
> >  #endif
> >  
> > diff --git a/include/erofs_fs.h b/include/erofs_fs.h
> > index f29aa2516a99..bcc4f0c630ad 100644
> > --- a/include/erofs_fs.h
> > +++ b/include/erofs_fs.h
> > @@ -13,6 +13,8 @@
> >  #define EROFS_SUPER_MAGIC_V1    0xE0F5E1E2
> >  #define EROFS_SUPER_OFFSET      1024
> >  
> > +#define EROFS_FEATURE_COMPAT_SB_CHKSUM		0x00000001
> > +
> >  /*
> >   * Any bits that aren't in EROFS_ALL_FEATURE_INCOMPAT should
> >   * be incompatible with this kernel version.
> > @@ -39,7 +41,6 @@ struct erofs_super_block {
> >  	__u8 uuid[16];          /* 128-bit uuid for volume */
> >  	__u8 volume_name[16];   /* volume name */
> >  	__le32 feature_incompat;
> > -
> >  	__u8 reserved2[44];
> >  };
> >  
> > diff --git a/lib/io.c b/lib/io.c
> > index 7f5f94dd6b1e..52f9424d201b 100644
> > --- a/lib/io.c
> > +++ b/lib/io.c
> > @@ -207,3 +207,30 @@ int dev_resize(unsigned int blocks)
> >  	return dev_fillzero(st.st_size, length, true);
> >  }
> >  
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
> 
> Minor thing, I notice caller wrap this errno to EIO, so we'd better print errno
> here or by caller? Other part looks good to me anyway.

Oops, I didn't notice that... that's a good point,
let me resend with fix later...

> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks for taking time on utils as well :-)

Thanks,
Gao Xiang

> 
> Thanks,
> 
> > +	}
> > +	return 0;
> > +}
> > diff --git a/mkfs/main.c b/mkfs/main.c
> > index ab57896e9ca8..eeb6ccc55b82 100644
> > --- a/mkfs/main.c
> > +++ b/mkfs/main.c
> > @@ -109,6 +109,12 @@ static int parse_extended_opts(const char *opts)
> >  				return -EINVAL;
> >  			cfg.c_force_inodeversion = FORCE_INODE_EXTENDED;
> >  		}
> > +
> > +		if (MATCH_EXTENTED_OPT("nosbcrc", token, keylen)) {
> > +			if (vallen)
> > +				return -EINVAL;
> > +			sbi.feature_compat &= ~EROFS_FEATURE_COMPAT_SB_CHKSUM;
> > +		}
> >  	}
> >  	return 0;
> >  }
> > @@ -218,6 +224,8 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
> >  		.meta_blkaddr  = sbi.meta_blkaddr,
> >  		.xattr_blkaddr = sbi.xattr_blkaddr,
> >  		.feature_incompat = cpu_to_le32(sbi.feature_incompat),
> > +		.feature_compat = cpu_to_le32(sbi.feature_compat &
> > +					      ~EROFS_FEATURE_COMPAT_SB_CHKSUM),
> >  	};
> >  	const unsigned int sb_blksize =
> >  		round_up(EROFS_SUPER_END, EROFS_BLKSIZ);
> > @@ -240,6 +248,62 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
> >  	return 0;
> >  }
> >  
> > +#define CRC32C_POLY_LE	0x82F63B78
> > +static inline u32 crc32c(u32 crc, const u8 *in, size_t len)
> > +{
> > +	int i;
> > +
> > +	while (len--) {
> > +		crc ^= *in++;
> > +		for (i = 0; i < 8; i++)
> > +			crc = (crc >> 1) ^ ((crc & 1) ? CRC32C_POLY_LE : 0);
> > +	}
> > +	return crc;
> > +}
> > +
> > +static int erofs_superblock_csum_set(void)
> > +{
> > +	int ret;
> > +	u8 buf[EROFS_BLKSIZ];
> > +	u32 crc;
> > +	struct erofs_super_block *sb;
> > +
> > +	ret = blk_read(buf, 0, 1);
> > +	if (ret) {
> > +		erofs_err("failed to read superblock to fill checksum");
> > +		return -EIO;
> > +	}
> > +
> > +	/*
> > +	 * skip the first 1024 bytes, to allow for the installation
> > +	 * of x86 boot sectors and other oddities.
> > +	 */
> > +	sb = (struct erofs_super_block *)(buf + EROFS_SUPER_OFFSET);
> > +
> > +	if (le32_to_cpu(sb->magic) != EROFS_SUPER_MAGIC_V1) {
> > +		erofs_err("internal error: not an erofs valid image");
> > +		return -EFAULT;
> > +	}
> > +
> > +	/* turn on checksum feature */
> > +	sb->feature_compat = cpu_to_le32(le32_to_cpu(sb->feature_compat) |
> > +					 EROFS_FEATURE_COMPAT_SB_CHKSUM);
> > +	crc = crc32c(~0, (u8 *)sb, EROFS_BLKSIZ - EROFS_SUPER_OFFSET);
> > +
> > +	/* set up checksum field to erofs_super_block */
> > +	sb->checksum = cpu_to_le32(crc);
> > +
> > +	ret = blk_write(buf, 0, 1);
> > +	if (ret) {
> > +		erofs_err("failed to write checksumed superblock: %s",
> > +			  erofs_strerror(ret));
> > +		return ret;
> > +	}
> > +
> > +	erofs_info("superblock checksum 0x%08x written", crc);
> > +	return 0;
> > +}
> > +
> >  int main(int argc, char **argv)
> >  {
> >  	int err = 0;
> > @@ -255,6 +319,7 @@ int main(int argc, char **argv)
> >  
> >  	cfg.c_legacy_compress = false;
> >  	sbi.feature_incompat = EROFS_FEATURE_INCOMPAT_LZ4_0PADDING;
> > +	sbi.feature_compat = EROFS_FEATURE_COMPAT_SB_CHKSUM;
> >  
> >  	err = mkfs_parse_options_cfg(argc, argv);
> >  	if (err) {
> > @@ -337,6 +402,9 @@ int main(int argc, char **argv)
> >  		err = -EIO;
> >  	else
> >  		err = dev_resize(nblocks);
> > +
> > +	if (!err && (sbi.feature_compat & EROFS_FEATURE_COMPAT_SB_CHKSUM))
> > +		err = erofs_superblock_csum_set();
> >  exit:
> >  	z_erofs_compress_exit();
> >  	dev_close();
> > 
