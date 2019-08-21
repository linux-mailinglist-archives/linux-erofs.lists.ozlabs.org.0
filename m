Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 260BC980C0
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Aug 2019 18:57:05 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46DDNF4d3RzDqSC
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Aug 2019 02:57:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1566406621;
	bh=soBoaIvCXZ3GM5gqSpQjIWaNE9wbXoiauUAyp9EnQ0M=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=bPuavZ9euvQDl3budA0QntAe/PJiOTd+aZyc0HpxJ6GJZR6a9hEps/VoXDigZAjwL
	 tyhauPC56JYfGYdq3q6xV9aPVwxaiMFiekZFpARjmI8b0UK4yYOnZVVW5vfbiLVutJ
	 qG19cQtk7hu1H1Vqnu8BdE8lcnDhZ5WLT/9Y+O9rM/+mTKUYc0grBExz0ChJppzbXQ
	 ljwXVifpQkZuVJE6rcRBRQfMwXSOU3qyMGNBrZDR7NrFnmwgc9nVAW+jh0SeIETfxQ
	 bjcuc2PmOpGunBonoBQyAHc4L93w607oIhw1R7aw6HFymlInB8E+1iBhJhZ6CD2hgb
	 Dblp/VC7L9wbQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=98.137.68.147; helo=sonic302-21.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="BijDyclk"; 
 dkim-atps=neutral
Received: from sonic302-21.consmr.mail.gq1.yahoo.com
 (sonic302-21.consmr.mail.gq1.yahoo.com [98.137.68.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46DDN66mYlzDqJP
 for <linux-erofs@lists.ozlabs.org>; Thu, 22 Aug 2019 02:56:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1566406608; bh=mTXAYfhh5QsVAgqELrzODuzoi2GIOuaEd3PwCxNnD0o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=BijDyclkza5dxdkk0vl8wQtXI61gugTGcwMTaJW5La1YD4D1Aa39opoXM2aSv5RZpWL/8uowDOvrVWZm4nE0XshwUYJXy4Wz0AI6h0FgQ4emuMc0idnXCFujebpGUlFqGt8JQyadUIUslt7Jrf2MVTH4R6xzjJ4ggvt1nuK4l7LlYD0E17+C9Wf8dgbpvML5Vh169qTN5zWY0N7DkWNHyLsfAop4kF+ccd7MQfkBHgfv1+riojxXScL7AUL0dTFnj4q9kv+A1rmBmcMF89HSyXOCzGDM6uN4AcQMyqKYHDjuC2YPQPVV4pDviETovPz3TrKdbDOEpzi04Xx7pvkpyw==
X-YMail-OSG: xZBScZwVM1ltUMReE8mgi6nV01wmXsBYgprrx4rx2HDAd4TtUndLIkhC0U9KatZ
 ymAp4Xf6fTs7YW5RKYDmUEym9oSLd7hnXqjk5iNpYixL_pbLJIvfrSZ_T1tsiNGCSI_AE8MHLKw5
 MmhCaVkgVDw6VxyU1SVymGYRoqtJjwepMC4C2dGhM5KkvC4DqzHi.aMW0im_dBgldJWL7oWyVIeU
 PwaSwOwLupIDi9I6WIQ98MoQ_6xY2IDfUxorNjiA5LFhuqwdU0TTgq27ZEsZqyqXCNoqGvk1xFSs
 OsAjBWDXpEdnoalsrTIZvvqv7VKWL2lgvl7vy8ZSrTYeoo0TRTz1w5Z2rKm6olevTrY81jg2nEAS
 qI4JLdPSokP.17VdL0znJ_hD2YMb_9c2LTPNbHKH8P.SO8X7DalvSXWOo5AHYfBSdp4ibJtqJ0y7
 Y.re.mEiRYN0RgJA21McYJ2F_lFZWd9Ew0_SC8ljzVhEKD2deLOIrvQGuE7bBTHQ53HzM8TwxTVO
 CHmxtBwKRNiz67KgAObNoQUhBns9byMoz61clUuOFsEEeirbg.BlvW1Zh8h013n2X.sYoB7xb.P9
 A.BFApJxt_PWyPWMt0UbBKE4tgGVRiS__fo2tQgRjGZG4qrdilV4GT8SHxYhcZiVDkfSyia.0tRL
 IIUoJLocQLphUsaqBCq95lnglHzrV1RUCOQec9.OUUp4IHQ8bxvqmqT2A6HtREmWPWkbt8BS4BY5
 xN9p0VUzp1e47AMXd.8eZeao0LTHmCFhwaDrVqT.RdrsDrI28MhLgLRClTdjK1LNWw0gb2puKVow
 oknZ70ZPP9tj9A0dl.jymXHxsjkx_ODlF5sZ23UfixlgO9FSuH4qjJ9sIu4ENlEI_yA46VA_JsXU
 0u_rVpGvWJcMFKZx.HVYioueihb36tgFZwGUr7oO4Gt1e22b4za6RTqQBkI4vdJCne0SpKGH0zb7
 z_XkJ9ZEKeLuNpA6FDkqkRveSUQc3iyCkzxB3B7vuFPZopcEWXA3DMBjQAk2_NMz.stCmCljDlZi
 JBZdPp7hDSS1FZjlGs4Dx17b7.GVRvXmEOM2faDNrQqdstnaInLVxhisEJ6oBAlb3rASZGSxj_Rp
 dRhsIVzEaJ0hqaJWMN6Yf5_d.l94wHcmcssi38IX3pDqhTyEhRZJrBzl_xK7Az1yFNJqYD3gwYZC
 N4684wbIzgw6c__oMIL7QvPY7JLaBnuGTX9ylESG26L1wz9SVlf5HMwWn8LhEay2Pd8jNCGLWsCZ
 eoaLDfCvp7MSw5l4O09u_DWDIj8ikpQ--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic302.consmr.mail.gq1.yahoo.com with HTTP; Wed, 21 Aug 2019 16:56:48 +0000
Received: by smtp406.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 1339d3c55fa2921b661957f723c74d33; 
 Wed, 21 Aug 2019 16:56:44 +0000 (UTC)
Date: Thu, 22 Aug 2019 00:56:38 +0800
To: Pratik Shinde <pratikshinde320@gmail.com>
Subject: Re: [PATCH] erofs-utils: erofs debug utility.
Message-ID: <20190821165633.GA30750@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20190821163808.6643-1-pratikshinde320@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821163808.6643-1-pratikshinde320@gmail.com>
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

On Wed, Aug 21, 2019 at 10:08:08PM +0530, Pratik Shinde wrote:
> Hello Maintainers,
> 
> After going through the recent mail thread between linux's filesystem folks
> on erofs channel, I felt erofs needs an interactive debug utility (like xfs_db)
> which can be used to examine erofs images & can also be used to inject errors OR
> fuzzing for testing purpose & dumping different erofs meta data structures
> for debugging.
> In order to demonstrate above I wrote an experimental patch that simply dumps
> the superblock of an image after mkfs completes.the full fletch utility will run
> independently and be able to seek / print / modify any byte of an erofs image,
> dump structures/lists/directory content of an image.

Yes, I think we really need that interactive tools, actually I'm stuggling in
modifing Guifu's erofs-fuse now, we need to add the parsing ability to "lib/"
first.

I mean, first, I will add a "fuse" field to "cfg". If it is false, it will
generate a image, or it will parse a image...
And then we need to add parsing logic into "lib/" as well, and use 
"if (cfg.fuse)" to differnate whether it should read or write data.

That is my prelimitary thought.. I will work on this framework in this weekend.
and then we can work together on it. :)

p.s. Pratik, if you have some time, could you take some extra time adding the
super checksum calulation to EROFS? I mean we can add EROFS_FEATURE_SB_CHKSUM
to the compat superblock field ("features"), and do crc32_le on kernel and mkfs...
If you dont have time, I will do it later instead... (since we are using EROFS
on the top of dm-verity, but completing the superblock chksum is also a good idea.)

And then we can add block-based verification layer to EROFS, it can be seen
as a hash tree like dm-verity or just simply CRC32 arrays for user to choise.

Thanks,
Gao Xiang

> 
> NOTE:This is an experimental patch just to demonstrate the purpose. The patch
> lacks a lot of things like coding standard, and new code runs in the context
> of mkfs itself.kindly ignore it.
> 
> kindly provide your feedback on this.
> 
> Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
> ---
>  include/erofs/io.h |  8 ++++++++
>  lib/io.c           | 27 +++++++++++++++++++++++++++
>  mkfs/main.c        | 36 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 71 insertions(+)
> 
> diff --git a/include/erofs/io.h b/include/erofs/io.h
> index 4b574bd..e91d6ee 100644
> --- a/include/erofs/io.h
> +++ b/include/erofs/io.h
> @@ -18,6 +18,7 @@
>  
>  int dev_open(const char *devname);
>  void dev_close(void);
> +int dev_read(void *buf, u64 offset, size_t len);
>  int dev_write(const void *buf, u64 offset, size_t len);
>  int dev_fillzero(u64 offset, size_t len, bool padding);
>  int dev_fsync(void);
> @@ -30,5 +31,12 @@ static inline int blk_write(const void *buf, erofs_blk_t blkaddr,
>  			 blknr_to_addr(nblocks));
>  }
>  
> +static inline int blk_read(void *buf, erofs_blk_t blkaddr,
> +			   u32 nblocks)
> +{
> +	return dev_read(buf, blknr_to_addr(blkaddr),
> +			blknr_to_addr(nblocks));
> +}
> +
>  #endif
>  
> diff --git a/lib/io.c b/lib/io.c
> index 15c5a35..87d7d6c 100644
> --- a/lib/io.c
> +++ b/lib/io.c
> @@ -109,6 +109,33 @@ u64 dev_length(void)
>  	return erofs_devsz;
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
> +		erofs_err("read posion[%" PRIu64 ", %zd] is too large beyond the end of device(%" PRIu64 ").",
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
> +
>  int dev_write(const void *buf, u64 offset, size_t len)
>  {
>  	int ret;
> diff --git a/mkfs/main.c b/mkfs/main.c
> index f127fe1..109486e 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -182,6 +182,41 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
>  	return 0;
>  }
>  
> +void erofs_dump_super(char *img_path)
> +{
> +	struct erofs_super_block *sb;
> +	char buf[EROFS_BLKSIZ];
> +	unsigned int blksz;
> +	int ret = 0;
> +
> +	if (img_path == NULL) {
> +		erofs_err("image path cannot be null");
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
> +		erofs_err("not a erofs image");
> +		return;
> +	}
> +
> +	erofs_dump("magic: 0x%x\n", le32_to_cpu(sb->magic));
> +	blksz = 1 << sb->blkszbits;
> +	erofs_dump("block size: %d\n", blksz);
> +	erofs_dump("root inode: %d\n", le32_to_cpu(sb->root_nid));
> +	erofs_dump("inodes: %llu\n", le64_to_cpu(sb->inos));
> +	erofs_dump("build time: %u\n", le32_to_cpu(sb->build_time));
> +	erofs_dump("blocks: %u\n", le32_to_cpu(sb->blocks));
> +	erofs_dump("meta block: %u\n", le32_to_cpu(sb->meta_blkaddr));
> +	erofs_dump("xattr block: %u\n", le32_to_cpu(sb->xattr_blkaddr));
> +	erofs_dump("requirements: 0x%x\n", le32_to_cpu(sb->requirements));
> +}
> +
>  int main(int argc, char **argv)
>  {
>  	int err = 0;
> @@ -268,6 +303,7 @@ int main(int argc, char **argv)
>  		err = -EIO;
>  exit:
>  	z_erofs_compress_exit();
> +	erofs_dump_super("dummy");
>  	dev_close();
>  	erofs_exit_configure();
>  
> -- 
> 2.9.3
> 
