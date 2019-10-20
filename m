Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id A3742DDEDE
	for <lists+linux-erofs@lfdr.de>; Sun, 20 Oct 2019 16:28:28 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46x2F61NPtzDqNP
	for <lists+linux-erofs@lfdr.de>; Mon, 21 Oct 2019 01:28:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1571581706;
	bh=4STigPER9/xP8puFG0ZaY7OgTKA5amPZZyjPM2BoV/w=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=ko2H76Rx/OW3Pxmf4OzF/jnY8OtT/gSRdHOXcvTBOw19F0gAwWTbMv1bomSSzLDa2
	 5aEnDw14UkiK3mOyqMstEcxlZroqxbVW4OJBoSHfMgVjqBxZTurwzG6q6Lc6BY65QL
	 sDg/Yqs0u/bBuk2rzSZTXIxMuIShNtDrTaeu0dqewi3QHbD9Eza5xybtXX3QZDscSp
	 TPgHKIEj0E4y+wKwsW8a+JETys83bxoYeGp0AAlX9o55SnnJNbSWUltqPCFukpTjS+
	 JuXdph0cFEJN5YtoL1U2m+cXzOlr5QDSFzK2/1zSm9DTDbwPCOrnCESM88LHm0Bxuw
	 NZtu2MFjKPfrA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.65.30; helo=sonic315-54.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="f7x9Fcz8"; 
 dkim-atps=neutral
Received: from sonic315-54.consmr.mail.gq1.yahoo.com
 (sonic315-54.consmr.mail.gq1.yahoo.com [98.137.65.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46x2Dv67bbzDqN9
 for <linux-erofs@lists.ozlabs.org>; Mon, 21 Oct 2019 01:28:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1571581690; bh=9HI9FuTA4CkVTlLmcP66B7miBRiCC1kJCPMirOasTSY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=f7x9Fcz8nJ9y7ceB0Yinmk9i/1aYZutE3YGbnc1HyBtTUUFywfpkRJLJHCfO2nKUirzMrqmk2JMKgxS7Z4OSmZhUGdOiA692RJIk5Av69IKYYpZ5Ly70JmyntyE/SteY2gdK2XxJLgvQsB3e/OkiSgVCYcz1ygxPkFbEEMOccy0tqK5RWUjTWpZ8Pa+zpTRwIuHoYkCS42pZ4Pt7Fb+JYxYYgm8EZWPpRCQuxNdlHJiWN9uL2/7L7m3+CwZDDZPU9AvBSljKrgseusLQoEvlpbMA8gSnKZMbjTNzj/lde+Bfwxzg2nYvUkhDJiXswoi2IUGV3eU2NAOZm7/OfIQc+w==
X-YMail-OSG: vGmgYlkVM1lLuTflqb4h79JohVRVenJUENN.mX8adsD1A127zpSbTKcq5kw11DI
 gKfwbT1r.gow9pHUcNil4ilvPJQdYi84lEhdEqXIHr.saF8LO2AAdhIzM9kdW.ZwOdt41A_P5ChK
 2YQYuQZCN_GYAmUWVMpbP6y6EdivPKgGdBTDe87ftxex57EBAR1PykIT..zbfTyi3bRLfKHqgprQ
 JchI17vg4HUs.YaKcr.Tiqu51ac1H0rgKR93VPQdwor2hwjDcZ5AH5K.Mvd3bdeV_GGdV..m7Fa7
 2abcSivYRYsd47yT4MjtLIEtvi6muoTwpn.rKJGzMIrBBkuf.NefAIoAJqgkdKU324toGhLSuPhj
 CO2TA1PwnzUuFYczyFySXdA4InJ8aqbZlqeTtjmuD0M0A17KnccZe8yyPhMKVQtdHpq8vfzT9JFs
 vXqxX.X4UMnJAZ8gajlPmZbV62De7p_Am0gqlXBG9ef6PGPTKxthbbHlvhhgkDMG7FqkwbWHGVMp
 3XOlXS6IaMd4eylZcnv97CyHl8vkwFtP7NRDFo2Yq0n2fWerAoRZOclEMXC3nIMxzW7100iqgO_x
 136X5g93wtQOvmNBwzz9JgW3YGNq0ltFaOaKNLF6AS350PI1AEcV.RoP__J5o3vssNAlrrGjQ0jr
 sPw_xGlC5c7kjdr4TwD4hkzHgGH1rhLXfodhtDF3ZaJj4hJs5tntgbhR7lRQUjFROoRCb4.tym3j
 Ya1huVKvht_0eqrzn8bBztU27MSfujHzTtSTSy0KxmWVIQr3o06CnFqnlFY2txAmEMpq1hhpv4BO
 dZYWHmF1G4wqZuyqSd8_R1UEazlB3alaUghk0DoPewLl74TxTXRchlPtqUROkmGwKwSvjy6eFIed
 NVBCeuxmys6oRC.e5.gLnGxdVlU0uRYCNEX3ajA_t9urfHIBtBlF6QaCTPFSJuzIbfuQICDcDtpV
 NnBYvavtpKWnYZWQpaTg.wGMHQeU09kGsUlOyXwdFz1cAijJKpS86OCsJ0J4FrJCdlWUXGNXrbEe
 d2KBAPpTnlcCCLz9X1ABZLrcYZCereXFvfzlTyJKaWnRDJ6dXnjF5j0hutSMTqoPSw_IhtykqAub
 ND0pZ8zSwgVEGh_xMuj07GRLxobo16zbzAp1tuHJ3iZkVQLQ8tf3cZUtIlT8q87zIUgen5XOTzlp
 Vk9Whxbi7x8gYgugOAK5xSDGEm50Npxy_hBHBbKV3xxfLrXaB2Rs6rxexZ07N.KSbDD6VSGneSGL
 EFIvnpAsRCcmyyyxOa2U2gt65HOYIQMTt5ojw.HzhaBptHKpzebNKB8Rf.eXN2xCHcxfF0zZsBxj
 FOuSErtkXcPeRaMOuWpYbfpvt4.l57dw0sA--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic315.consmr.mail.gq1.yahoo.com with HTTP; Sun, 20 Oct 2019 14:28:10 +0000
Received: by smtp418.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID f1a1dd6de85c866bc0f4aef17101619e; 
 Sun, 20 Oct 2019 14:28:05 +0000 (UTC)
Date: Sun, 20 Oct 2019 22:28:00 +0800
To: Pratik Shinde <pratikshinde320@gmail.com>
Subject: Re: [PATCH] erofs: code for verifying superblock checksum of an
 erofs image.
Message-ID: <20191020142745.GB30399@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20191020130320.10193-1-pratikshinde320@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191020130320.10193-1-pratikshinde320@gmail.com>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Pritik,

On Sun, Oct 20, 2019 at 06:33:20PM +0530, Pratik Shinde wrote:
> Patch for kernel side changes of checksum feature.I used kernel's
> crc32c library for calculating the checksum.
> 
> Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
> ---
>  fs/erofs/erofs_fs.h |  5 +++--
>  fs/erofs/internal.h |  2 +-
>  fs/erofs/super.c    | 50 ++++++++++++++++++++++++++++++++++++++++++++++----
>  3 files changed, 50 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
> index b1ee565..bab5506 100644
> --- a/fs/erofs/erofs_fs.h
> +++ b/fs/erofs/erofs_fs.h
> @@ -17,6 +17,7 @@
>   */
>  #define EROFS_FEATURE_INCOMPAT_LZ4_0PADDING	0x00000001
>  #define EROFS_ALL_FEATURE_INCOMPAT		EROFS_FEATURE_INCOMPAT_LZ4_0PADDING
> +#define EROFS_FEATURE_SB_CHKSUM 0x0001

Thanks for your patch :) I will comment this patch tomorrow,
but when you decide to send a kernel patch (it is a common
practice), don't forget to run scripts/get_maintainer.pl and
generally Cc all of them
(It is really needed to Cc LKML mailing list linux-kernel@vger.kernel.org.)

However, no rush to update and resend this patch.
I will do detailed comments tomorrow, it needs some
changes (especially stuffs in erofs_validate_sb_chksum()).

Thanks,
Gao Xiang

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
> index 544a453..cd3af45 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -86,7 +86,7 @@ struct erofs_sb_info {
>  	u8 uuid[16];                    /* 128-bit uuid for volume */
>  	u8 volume_name[16];             /* volume name */
>  	u32 feature_incompat;
> -
> +	u32 features;
>  	unsigned int mount_opt;
>  };
>  
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 0e36949..94e1d6a 100644
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
> @@ -46,6 +47,45 @@ void _erofs_info(struct super_block *sb, const char *function,
>  	va_end(args);
>  }
>  
> +static int erofs_validate_sb_chksum(struct erofs_super_block *dsb,
> +				       struct super_block *sb)
> +{
> +	u32 disk_chksum = le32_to_cpu(dsb->checksum);
> +	u32 nblocks = le32_to_cpu(dsb->chksum_blocks);
> +	u32 crc;
> +	struct erofs_super_block *dsb2;
> +	char *buf;
> +	unsigned int off = 0;
> +	void *kaddr;
> +	struct page *page;
> +	int i, ret = -EINVAL;
> +
> +	buf = kmalloc(nblocks * EROFS_BLKSIZ, GFP_KERNEL);
> +	if (!buf)
> +		goto out;
> +	for (i = 0; i < nblocks; i++) {
> +		page = erofs_get_meta_page(sb, i);
> +		if (IS_ERR(page))
> +			goto out;
> +		kaddr = kmap_atomic(page);
> +		(void) memcpy(buf + off, kaddr, EROFS_BLKSIZ);
> +		kunmap_atomic(kaddr);
> +		unlock_page(page);
> +		/* first page will be released by erofs_read_superblock */
> +		if (i != 0)
> +			put_page(page);
> +		off += EROFS_BLKSIZ;
> +	}
> +	dsb2 = (struct erofs_super_block *)(buf + EROFS_SUPER_OFFSET);
> +	dsb2->checksum = 0;
> +	crc = crc32c(0, buf, nblocks * EROFS_BLKSIZ);
> +	if (crc != disk_chksum)
> +		goto out;
> +	ret = 0;
> +out:	kfree(buf);
> +	return ret;
> +}
> +
>  static void erofs_inode_init_once(void *ptr)
>  {
>  	struct erofs_inode *vi = ptr;
> @@ -109,18 +149,20 @@ static int erofs_read_superblock(struct super_block *sb)
>  		erofs_err(sb, "cannot read erofs superblock");
>  		return PTR_ERR(page);
>  	}
> -
>  	sbi = EROFS_SB(sb);
> -
>  	data = kmap_atomic(page);
>  	dsb = (struct erofs_super_block *)(data + EROFS_SUPER_OFFSET);
> -
>  	ret = -EINVAL;
>  	if (le32_to_cpu(dsb->magic) != EROFS_SUPER_MAGIC_V1) {
>  		erofs_err(sb, "cannot find valid erofs superblock");
>  		goto out;
>  	}
> -
> +	if (dsb->feature_compat & EROFS_FEATURE_SB_CHKSUM) {
> +		if (erofs_validate_sb_chksum(dsb, sb)) {
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
