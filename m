Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1407E08FB
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Oct 2019 18:34:39 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46yJxm6RLpzDqMK
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Oct 2019 03:34:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1571762076;
	bh=AdvHOeSU5D3EMJMaubxgF2d2kNQScpCGVq+0oWEHJ9Y=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Gi0BU9T/lrxj9HEIdk1MDW5SZu46F1+df2X2L0ohWy9Nrc1h5mLzAtKaBK6Q5iRzt
	 SdFJ1yQgTkfSTNp4xsWm9SSYw8fr4WAmW8al7VxN/4zZKdv/pJoecw/PAB7oYo2iDx
	 9VCOhDVjXMX8sUOhKjda9MO/MfTOMhBkv9dySNwqDMPk868K3SwtWa09Eqh9dEjkC7
	 O/xySr/Z7R/UDtj4jZlnEpKrxysdHG/VT45c8p86j19AbL/dnx1m5E1t2U4833e+t2
	 guo3VWbkbcwVe3m5Zkej7h9Z1Yuw0H+kPlDbGppC9jd6RkpLpcn3zvksoLfP3EEUqJ
	 FhpwyFZjltLaQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=77.238.179.187; helo=sonic313-20.consmr.mail.ir2.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="EyVFajeU"; 
 dkim-atps=neutral
Received: from sonic313-20.consmr.mail.ir2.yahoo.com
 (sonic313-20.consmr.mail.ir2.yahoo.com [77.238.179.187])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46yJxd2jJNzDqLx
 for <linux-erofs@lists.ozlabs.org>; Wed, 23 Oct 2019 03:34:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1571762063; bh=A1vX4VWQPMbJ7Dk8UtwOVAMMg74z40Il0hGsPeYA4/s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=EyVFajeUeZ+PE/ud3G7Xyqe3DHS4TmKrkNq3vlfn71bf3TCIRaYIDbgnjpptaQuNgim5Gf3m4LXp11h3hfXVshRId9+Ih++03WP0vLO8LC70RH+0Ros5gB6aYzK7rf6WMn4lPTudsHDN/eFpizbZrJx4jGWQ6MbVl89QnMVBONyYlSuvDPPY3wf3pBaj4Ei2SV2p2UKbeJrQhwJ/DiRhHsd5uqRRQnAogUOu4FPxQL78VyB8nbIULXy7z1MucoP4q+q9qDJHI2hKZU+uSGOOd5ccdPDP+dFR84UZjws8spAiNx6DaT2QirnMyg/ya22SywBUqVczHl9TWxrdJkdTgg==
X-YMail-OSG: oekYUEoVM1mD_cCU8AsDerKUQS8vRHCBQQ9Yvxm4alyR5jvdurJPxgGPX344cNx
 u9vcTRWnd.FrEJTKSTykoql.edZi.YxUHVu4c0jZHzLQ3Mj1T7Wj8RClQIUSpOmf35tgRD8GqAjd
 .EuwchCYfpG0i0NVbeHdtWlVkgo21_wvFKsbLI2kIjX049MlrlwrgHBOSmfwRQEwKuP1K3UfZmhj
 NDix1Fq4W_7YPVmH613AqU6LaRArbitEDIL03_ofuza6Pb5Tm.dZfmc18wOCjs3P1gR8TLE6wzoi
 0qeVQ_D6j2k12rlE7v2c6DgmJ7_d1MKF9_xDhX9rUb4W5FXGupVudhgPVc8.AydOTDxr2GCLJ9ym
 5FD61.HKg.jtGP_Xejq5gp3HhFzs89jFtMXzNUktw.IOKyOaezIZF7JSv_QobHUPj8p1.ehn7Bam
 INWxYRbhwWInjUMspMQ2jzk7ZCd7tGdPN_xwEdDZllU_imGsZXfwKM9vd84cQ8VjtnS2yvjIOHmy
 8Qm.KiUXL8KraT3VYILrE_KKArLQtDskc9KrKBH2GfklgCJtob8ISgvY3jLMgblSo9Xb6HcLA6tj
 ZRr8El32jciUTKYuhMmMTNiQAzzQdoUBf6soT8_qHwr0SrmOxDJN57yIC7ldnx5FpButky7CtYc2
 yqZnsYg58I7EzzZ5YEe8UXucr2uLpKBgZ88X.9NdAzn1vFU8o_6.uCGHlCktcG5XKV3SmtlfCLwr
 awt9QogzPPTdKJQsPz6ms64VRre4_F.Wr1m0GJifvnLlHmWRCZmBlWev9MxxRV36EzRnjmxLhEYq
 dek84Ck7CFUnlOsK__uSVm__jS.ad9eLn9tdX2VtCdL7usPZr2hJqO8K4lKUjMXSEDUAAxYf_z2z
 Xttk61dDiYz.GQX48nVBkEkFhU9UZqOYmsoGwc5nsjdSwkK7j5_G8AZ6P2s4sJQ_jevBCDQl5sHJ
 U6hfDKM7.5xK86pvxWTIUsc.qnCJuCNBnxWBlbGFEK.2xd4SzLcoIkJlrfMC1kWAH_LrET9ROKed
 Ou9jP1r5p4OA.y1X2B2.4DTAhD0u0J2MDLf3P38M.P1.sWl8pBNTx4GLi5sXaDFW13TlzMBQzVQX
 LTW8v133gxDpqLVPbMcOEbd2F2RuGbo0ZLeAcX4o0xQl6IF_vpIJQdnqly21qBfE.GqrFZr_bJhS
 OYBvsLfUnX0uz1kwSx6jmrjRAL679WoRpexYGSKjRSKxHbAzKQPlTv9Fka5JP14MoFzWfAP2v9hi
 5kIFxJEE_.AfQ9tbNZod3JukLAohBo0JiSKnGWtbv1Am7OD2dEUS4crpnwxqKuibjy5vYXBD6q0o
 9jRRgNfc30zt1PnUorfnQEQIcglJ5zMpPgFAt
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic313.consmr.mail.ir2.yahoo.com with HTTP; Tue, 22 Oct 2019 16:34:23 +0000
Received: by smtp405.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID af731488e5dabafbb7badc3449baeb13; 
 Tue, 22 Oct 2019 16:34:22 +0000 (UTC)
Date: Wed, 23 Oct 2019 00:34:15 +0800
To: Pratik Shinde <pratikshinde320@gmail.com>
Subject: Re: [PATCH-v2] erofs: code for verifying superblock checksum of an
 erofs image.
Message-ID: <20191022163403.GA3201@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20191022153956.16867-1-pratikshinde320@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022153956.16867-1-pratikshinde320@gmail.com>
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Pratik,

Some comments as below...

On Tue, Oct 22, 2019 at 09:09:56PM +0530, Pratik Shinde wrote:
> Patch for kernel side changes of checksum feature.Used kernel's
> crc32c library for calculating the checksum.
> 
> Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
> ---
>  fs/erofs/erofs_fs.h |  5 +++--
>  fs/erofs/internal.h |  3 ++-
>  fs/erofs/super.c    | 33 +++++++++++++++++++++++++++++++++
>  3 files changed, 38 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
> index b1ee565..4d8097a 100644
> --- a/fs/erofs/erofs_fs.h
> +++ b/fs/erofs/erofs_fs.h
> @@ -17,6 +17,7 @@
>   */
>  #define EROFS_FEATURE_INCOMPAT_LZ4_0PADDING	0x00000001
>  #define EROFS_ALL_FEATURE_INCOMPAT		EROFS_FEATURE_INCOMPAT_LZ4_0PADDING
> +#define EROFS_FEATURE_COMPAT_SB_CHKSUM 		0x00000001
>  
>  /* 128-byte erofs on-disk super block */
>  struct erofs_super_block {
> @@ -37,8 +38,8 @@ struct erofs_super_block {
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
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 544a453..cec27ca 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -86,7 +86,7 @@ struct erofs_sb_info {
>  	u8 uuid[16];                    /* 128-bit uuid for volume */
>  	u8 volume_name[16];             /* volume name */
>  	u32 feature_incompat;
> -
> +	u32 feature_compat;
>  	unsigned int mount_opt;
>  };
>  
> @@ -426,6 +426,7 @@ static inline void z_erofs_exit_zip_subsystem(void) {}
>  #endif	/* !CONFIG_EROFS_FS_ZIP */
>  
>  #define EFSCORRUPTED    EUCLEAN         /* Filesystem is corrupted */
> +#define EFSBADCRC	EBADMSG		/* Bad crc found */
>  
>  #endif	/* __EROFS_INTERNAL_H */
>  
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 0e36949..9cda72d 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -9,6 +9,7 @@
>  #include <linux/statfs.h>
>  #include <linux/parser.h>
>  #include <linux/seq_file.h>
> +#include <linux/crc32c.h>
>  #include "xattr.h"
>  
>  #define CREATE_TRACE_POINTS
> @@ -46,6 +47,31 @@ void _erofs_info(struct super_block *sb, const char *function,
>  	va_end(args);
>  }
>  
> +static int erofs_validate_sb_chksum(struct erofs_super_block *dsb,
> +				       struct super_block *sb)
> +{
> +	u32 disk_chksum, nblocks, crc = 0;
> +	void *kaddr;
> +	struct page *page;
> +	int i;
> +
> +	disk_chksum = le32_to_cpu(dsb->checksum);
> +	nblocks = le32_to_cpu(dsb->chksum_blocks);

We cannot write the page data directly since the page cache should be kept in
sync with ondisk data (or for read-write fs, if it's claimed as uptodated, and
it is modified later,  you should mark it dirty, and do writeback then, but
that is not the erofs case.)

> +	dsb->checksum = 0;
> +	for (i = 0; i < nblocks; i++) {
> +		page = erofs_get_meta_page(sb, i);
> +		if (IS_ERR(page))
> +			return PTR_ERR(page);
> +		kaddr = kmap(page);

Here kmap_atomic(page) is better. what I mean is kmap_atomic() in the caller
erofs_read_superblock(), it should be replaced to kmap() instead.

> +		crc = crc32c(crc, kaddr, EROFS_BLKSIZ);
> +		kunmap(page);
> +		unlock_page(page);

need
		put_page(page);


I'm not sure whether I explained quite well, but this patch needs something
to do. I'm now working on demonstrating new XZ algorithm and releasing
erofs-utils v1.0.

You can give more tries or I will help later. :-)

Thanks,
Gao Xiang


> +	}
> +	if (crc != disk_chksum)
> +		return -EFSBADCRC;
> +	return 0;
> +}
> +
>  static void erofs_inode_init_once(void *ptr)
>  {
>  	struct erofs_inode *vi = ptr;
> @@ -121,6 +147,13 @@ static int erofs_read_superblock(struct super_block *sb)
>  		goto out;
>  	}
>  
> +	if (dsb->feature_compat & EROFS_FEATURE_COMPAT_SB_CHKSUM) {
> +		ret = erofs_validate_sb_chksum(dsb, sb);
> +		if (ret < 0) {
> +			erofs_err(sb, "super block checksum incorrect");
> +			goto out;
> +		}
> +	}
>  	blkszbits = dsb->blkszbits;
>  	/* 9(512 bytes) + LOG_SECTORS_PER_BLOCK == LOG_BLOCK_SIZE */
>  	if (blkszbits != LOG_BLOCK_SIZE) {
> -- 
> 2.9.3
> 
