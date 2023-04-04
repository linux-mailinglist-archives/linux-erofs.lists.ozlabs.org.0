Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E2B6D70D0
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Apr 2023 01:40:49 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Prklz2X2lz3f3t
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Apr 2023 09:40:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1680651647;
	bh=M/r2yyBxa2UjizT7DIESb3jdVn4T1vcr3JZCxz3Un80=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=K246zfbBNqjNsD1EJDf8wG9jkxYFMg0SDdsePliVwq/2Q41rnMqnPWChddliRGfkS
	 tINklEWN1RBZdoV8uuL769jGN5vur5qEn0dT2X8FwVBgfhk+hoyzu5kzfmG8QumI2f
	 qF+Xk3dAI3OJ4X20NoWp7quYMt+uypz8Ez502vihZpd6ClHJVrAtKGhiXi7m3762kA
	 CqY7O7cUiHaP06CHESHfnuSwZamiS6y2FGMamyONwNtYPbMgqKF/VbZmuK4TUGsavn
	 wDsq0tQ2Yc7O67cDICf5RmMvkYOg402t39OizkcNL1FJH7Zhl+rvTwz+lpkf8VIs9V
	 jG/dEMbkAF/Xg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=fromorbit.com (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=david@fromorbit.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=fromorbit-com.20210112.gappssmtp.com header.i=@fromorbit-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=dQLF1Fgl;
	dkim-atps=neutral
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Prkls3qZfz3cdn
	for <linux-erofs@lists.ozlabs.org>; Wed,  5 Apr 2023 09:40:39 +1000 (AEST)
Received: by mail-pj1-x1033.google.com with SMTP id ml21so10290867pjb.4
        for <linux-erofs@lists.ozlabs.org>; Tue, 04 Apr 2023 16:40:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680651636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M/r2yyBxa2UjizT7DIESb3jdVn4T1vcr3JZCxz3Un80=;
        b=Zq6Ri5+OH/Wm4ZjZS4XsSkWbRSle0M4eeoVyTBp3yZlpNgdoaOG3VRKPIDICq/5Qna
         AjVXfsAwmO2RlgmKODfpBmzgskdHslwOCyZFJHYwvguRrlBaqFMdeW1aoaZ0ydupuSGB
         8I5fRK6xJqWfrpzv3wykY8SS+ZfyUa92NmZlSAkBAVWhADqGD1vBVmoSiWZDErQ4nPJV
         4fIvG+gfhdkf3RoLpb+XpSbaD5HhcfmamNcOOzAG45LNpFfnvXTg3ZDGhoRbtaUJIZx7
         76ZNwO0VeoR0r6Zzn/1HB8dPZhJAgUpFJgN+5wFbFceUDXHV/D5WT3THzm9Kbb3JALRV
         9MNQ==
X-Gm-Message-State: AAQBX9cfzqZFHVlggWYJQLgmlp9cfisA5U6S0NtM5eut1TrMBgDbcBUm
	oGQYVD/aO7CU1HzrG1lDHAP4rg==
X-Google-Smtp-Source: AKy350aGtUyDc7dXm54tao9SO1Z52DtK7YHUJoaBCaBA1TXOYmz5/48+4yE+r2PZyPM8LNhcT3l0sw==
X-Received: by 2002:a17:902:fb8c:b0:1a1:c945:4b23 with SMTP id lg12-20020a170902fb8c00b001a1c9454b23mr3916070plb.65.1680651635730;
        Tue, 04 Apr 2023 16:40:35 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-91-157.pa.nsw.optusnet.com.au. [49.181.91.157])
        by smtp.gmail.com with ESMTPSA id q18-20020a170902b11200b001a216d44440sm8856651plr.200.2023.04.04.16.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 16:40:29 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
	(envelope-from <david@fromorbit.com>)
	id 1pjqGB-00H7Og-Tt; Wed, 05 Apr 2023 09:40:19 +1000
Date: Wed, 5 Apr 2023 09:40:19 +1000
To: Andrey Albershteyn <aalbersh@redhat.com>
Subject: Re: [PATCH v2 06/23] fsverity: add drop_page() callout
Message-ID: <20230404234019.GM3223426@dread.disaster.area>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
 <20230404145319.2057051-7-aalbersh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404145319.2057051-7-aalbersh@redhat.com>
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
From: Dave Chinner via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Dave Chinner <david@fromorbit.com>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, agruenba@redhat.com, hch@infradead.org, djwong@kernel.org, damien.lemoal@opensource.wdc.com, linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com, dchinner@redhat.com, rpeterso@redhat.com, jth@kernel.org, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Apr 04, 2023 at 04:53:02PM +0200, Andrey Albershteyn wrote:
> Allow filesystem to make additional processing on verified pages
> instead of just dropping a reference. This will be used by XFS for
> internal buffer cache manipulation in further patches. The btrfs,
> ext4, and f2fs just drop the reference.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> ---
>  fs/btrfs/verity.c         | 12 ++++++++++++
>  fs/ext4/verity.c          |  6 ++++++
>  fs/f2fs/verity.c          |  6 ++++++
>  fs/verity/read_metadata.c |  4 ++--
>  fs/verity/verify.c        |  6 +++---
>  include/linux/fsverity.h  | 10 ++++++++++
>  6 files changed, 39 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
> index c5ff16f9e9fa..4c2c09204bb4 100644
> --- a/fs/btrfs/verity.c
> +++ b/fs/btrfs/verity.c
> @@ -804,10 +804,22 @@ static int btrfs_write_merkle_tree_block(struct inode *inode, const void *buf,
>  			       pos, buf, size);
>  }
>  
> +/*
> + * fsverity op that releases the reference obtained by ->read_merkle_tree_page()
> + *
> + * @page:  reference to the page which can be released
> + *
> + */
> +static void btrfs_drop_page(struct page *page)
> +{
> +	put_page(page);
> +}
> +
>  const struct fsverity_operations btrfs_verityops = {
>  	.begin_enable_verity     = btrfs_begin_enable_verity,
>  	.end_enable_verity       = btrfs_end_enable_verity,
>  	.get_verity_descriptor   = btrfs_get_verity_descriptor,
>  	.read_merkle_tree_page   = btrfs_read_merkle_tree_page,
>  	.write_merkle_tree_block = btrfs_write_merkle_tree_block,
> +	.drop_page		 = &btrfs_drop_page,
>  };

Ok, that's a generic put_page() call.

....
> diff --git a/fs/verity/verify.c b/fs/verity/verify.c
> index f50e3b5b52c9..c2fc4c86af34 100644
> --- a/fs/verity/verify.c
> +++ b/fs/verity/verify.c
> @@ -210,7 +210,7 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
>  		if (is_hash_block_verified(vi, hpage, hblock_idx)) {
>  			memcpy_from_page(_want_hash, hpage, hoffset, hsize);
>  			want_hash = _want_hash;
> -			put_page(hpage);
> +			inode->i_sb->s_vop->drop_page(hpage);
>  			goto descend;

			fsverity_drop_page(hpage);

static inline void
fsverity_drop_page(struct inode *inode, struct page *page)
{
	if (inode->i_sb->s_vop->drop_page)
		inode->i_sb->s_vop->drop_page(page);
	else
		put_page(page);
}

And then you don't need to add the functions to each of the
filesystems nor make an indirect call just to run put_page().

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
