Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 835EE65CC1C
	for <lists+linux-erofs@lfdr.de>; Wed,  4 Jan 2023 04:20:05 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Nmvwz2jnpz3bTs
	for <lists+linux-erofs@lfdr.de>; Wed,  4 Jan 2023 14:20:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=QK6B37k5;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=QK6B37k5;
	dkim-atps=neutral
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Nmvwp4XHvz2xkD
	for <linux-erofs@lists.ozlabs.org>; Wed,  4 Jan 2023 14:19:52 +1100 (AEDT)
Received: by mail-pl1-x62b.google.com with SMTP id c2so7106991plc.5
        for <linux-erofs@lists.ozlabs.org>; Tue, 03 Jan 2023 19:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhP4Cd2WY+fITu2HPo1fzGiOlyGzfgnxjZGMFXwm5tE=;
        b=QK6B37k5Fu56pxWeLYYYsTgur5NY0YhZSI3laAhh5L9+F76JoPqLdXuGEsGOsCtH3w
         TbLGZTz+W/lk9c5lvJoI6p+lVYwKEnW/zOXVyT7fakUQRjwk+tMAqhijFjQmobe9tBgc
         m4HXsNUTUaoCyBdJxNdvJYWqf/OfY+Wk63dTRFlZkX4uwUnuzZ5cwpooVz1Squ1E6MYE
         RG3wSQwDYEkiMsz3ZAmTFjnJWsnj7RhZoPh5uC0UhWNeF2ulO7QfypwtiLkLgLIIAz7N
         lNjn4fq0r5EvWRGasN4mRZ7nMHibGXmJiHjHI/eZ/FARpOAdJ4qGBCtzr5u6lW+bzNLR
         9C4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nhP4Cd2WY+fITu2HPo1fzGiOlyGzfgnxjZGMFXwm5tE=;
        b=yz5uhD9Ay+bIwX7acbV8hSmPv6I5wzL18Y1RaiQHqtY54kO9ijNuIH1rc5kWzJKYWC
         V2Cqdk2SKVptnibJNuxbm7EBP0+vkTIs2NKRuncBFp5Gr5GNO3V62LODCPM750KxM+Lm
         yAIRCivgmr1FGyY2LQUYfNICDvA2xj6HiFq+OY9Y66YsDxcmiqUMg461lvMJQOWLbuRp
         UVNDRYIr0k0dZuCIrze6q928MBuDJfqpTFV0+tde6+ykURaewa8odlMHPAKnOGBHREMa
         TFKi/bR4ki0OeiDHwjBb2APMV9CJpIGDVHRMLh8LYsqdxPo63mkvmUJoB37HFEcVELeI
         TNxA==
X-Gm-Message-State: AFqh2krV5W4f0mzDJHJoI2ApfHzekq4sGqnMvjYiixUBESW09kHMGUi9
	t/HWx06n9RX/Ed4qYiu1c8o=
X-Google-Smtp-Source: AMrXdXuG0oypKHKZsEMqgLea28ml0l8gBCRmgXzadYRKmw8z0RzZ11nHVCbRXOExJvceLgz1rU4zDw==
X-Received: by 2002:a17:902:7404:b0:189:b0fe:d70f with SMTP id g4-20020a170902740400b00189b0fed70fmr48044709pll.60.1672802388839;
        Tue, 03 Jan 2023 19:19:48 -0800 (PST)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id r10-20020a170902c60a00b00178b77b7e71sm23086128plr.188.2023.01.03.19.19.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jan 2023 19:19:48 -0800 (PST)
Date: Wed, 4 Jan 2023 11:24:45 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Xiang Gao <hsiangkao@linux.alibaba.com>
Subject: Re: [RFC PATCH] erofs-utils: fsck: support fragments
Message-ID: <20230104112445.000075d8.zbestahu@gmail.com>
In-Reply-To: <fa1df3e5-9158-4381-5315-d243f77542a6@linux.alibaba.com>
References: <20221224094319.10317-1-zbestahu@gmail.com>
	<fa1df3e5-9158-4381-5315-d243f77542a6@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=GB18030
Content-Transfer-Encoding: 8bit
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
Cc: Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Xiang,

On Wed, 4 Jan 2023 10:48:40 +0800
Xiang Gao <hsiangkao@linux.alibaba.com> wrote:

> Hi Yue,
> 
> ÔÚ 2022/12/24 17:43, Yue Hu Ð´µÀ:
> > From: Yue Hu <huyue2@coolpad.com>
> > 
> > Add compressed fragments support for fsck.erofs.
> > 
> > Signed-off-by: Yue Hu <huyue2@coolpad.com>
> > ---
> >   fsck/main.c | 41 +++++++++++++++++++++++++++++++++++++++--
> >   lib/zmap.c  |  1 +
> >   2 files changed, 40 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fsck/main.c b/fsck/main.c
> > index 2a9c501..9babc61 100644
> > --- a/fsck/main.c
> > +++ b/fsck/main.c
> > @@ -421,6 +421,31 @@ static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd)
> >   		if (!(map.m_flags & EROFS_MAP_MAPPED) || !fsckcfg.check_decomp)
> >   			continue;
> >   
> > +		if (map.m_flags & EROFS_MAP_FRAGMENT) {
> > +			struct erofs_inode packed_inode = {
> > +				.nid = sbi.packed_nid,
> > +			};  
> 
> Sorry for late response.
> 
> a question... why don't we just rely on z_erofs_read_data()?

We may fall back to uncompressed mode for packed inode due to 'ENOSPC'.

> 
> 
> Thanks,
> Gao Xiang
> 
> > +
> > +			ret = erofs_read_inode_from_disk(&packed_inode);
> > +			if (ret) {
> > +				erofs_err("failed to read packed inode from disk");
> > +				goto out;
> > +			}
> > +
> > +			if (!buffer || map.m_llen > buffer_size) {
> > +				buffer_size = map.m_llen;
> > +				buffer = realloc(buffer, map.m_llen);
> > +				BUG_ON(!buffer);
> > +			}
> > +			ret = erofs_pread(&packed_inode, buffer, map.m_llen,
> > +					  inode->fragmentoff);
> > +			if (ret)
> > +				goto out;
> > +
> > +			compressed = true;	/* force using buffer */
> > +			goto write_outfd;
> > +		}
> > +
> >   		if (map.m_plen > raw_size) {
> >   			raw_size = map.m_plen;
> >   			raw = realloc(raw, raw_size);
> > @@ -476,6 +501,7 @@ static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd)
> >   			}
> >   		}
> >   
> > +write_outfd:
> >   		if (outfd >= 0 && write(outfd, compressed ? buffer : raw,
> >   					map.m_llen) < 0) {
> >   			erofs_err("I/O error occurred when verifying data chunk @ nid %llu",
> > @@ -486,8 +512,9 @@ static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd)
> >   	}
> >   
> >   	if (fsckcfg.print_comp_ratio) {
> > -		fsckcfg.logical_blocks += BLK_ROUND_UP(inode->i_size);
> >   		fsckcfg.physical_blocks += BLK_ROUND_UP(pchunk_len);
> > +		if (!erofs_is_packed_inode(inode))
> > +			fsckcfg.logical_blocks += BLK_ROUND_UP(inode->i_size);
> >   	}
> >   out:
> >   	if (raw)
> > @@ -732,6 +759,8 @@ static int erofsfsck_check_inode(erofs_nid_t pnid, erofs_nid_t nid)
> >   			ret = erofs_extract_dir(&inode);
> >   			break;
> >   		case S_IFREG:
> > +			if (erofs_is_packed_inode(&inode))
> > +				goto verify;
> >   			ret = erofs_extract_file(&inode);
> >   			break;
> >   		case S_IFLNK:
> > @@ -767,7 +796,7 @@ verify:
> >   		ret = erofs_iterate_dir(&ctx, true);
> >   	}
> >   
> > -	if (!ret)
> > +	if (!ret && !erofs_is_packed_inode(&inode))
> >   		erofsfsck_set_attributes(&inode, fsckcfg.extract_path);
> >   
> >   	if (ret == -ECANCELED)
> > @@ -822,6 +851,14 @@ int main(int argc, char **argv)
> >   		goto exit_put_super;
> >   	}
> >   
> > +	if (erofs_sb_has_fragments()) {
> > +		err = erofsfsck_check_inode(sbi.packed_nid, sbi.packed_nid);
> > +		if (err) {
> > +			erofs_err("failed to verify packed file");
> > +			goto exit_put_super;
> > +		}
> > +	}
> > +
> >   	err = erofsfsck_check_inode(sbi.root_nid, sbi.root_nid);
> >   	if (fsckcfg.corrupted) {
> >   		if (!fsckcfg.extract_path)
> > diff --git a/lib/zmap.c b/lib/zmap.c
> > index 41e0713..ca65038 100644
> > --- a/lib/zmap.c
> > +++ b/lib/zmap.c
> > @@ -639,6 +639,7 @@ static int z_erofs_do_map_blocks(struct erofs_inode *vi,
> >   		map->m_plen = vi->z_idata_size;
> >   	} else if (fragment && m.lcn == vi->z_tailextent_headlcn) {
> >   		map->m_flags |= EROFS_MAP_FRAGMENT;
> > +		map->m_plen = 0;
> >   	} else {
> >   		map->m_pa = blknr_to_addr(m.pblk);
> >   		err = z_erofs_get_extent_compressedlen(&m, initial_lcn);  

