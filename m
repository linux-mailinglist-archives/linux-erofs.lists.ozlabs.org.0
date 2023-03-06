Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8EA6AB98E
	for <lists+linux-erofs@lfdr.de>; Mon,  6 Mar 2023 10:19:39 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PVY1g5gM1z3cFr
	for <lists+linux-erofs@lfdr.de>; Mon,  6 Mar 2023 20:19:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=S5Z0qdwW;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42f; helo=mail-pf1-x42f.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=S5Z0qdwW;
	dkim-atps=neutral
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PVY1W4d2kz3bym
	for <linux-erofs@lists.ozlabs.org>; Mon,  6 Mar 2023 20:19:25 +1100 (AEDT)
Received: by mail-pf1-x42f.google.com with SMTP id a7so5254926pfx.10
        for <linux-erofs@lists.ozlabs.org>; Mon, 06 Mar 2023 01:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678094362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uyAoOVBgvrRZ8o47EfBbfO9DwxNDPSR6c2gpZFB3WTY=;
        b=S5Z0qdwWwkUzee0XNOAgLk8tMC3F9aeYb9PeTD6CsBxfxMVZ0zlp3x1mZ2cTdKfznN
         pS2ngFWge/3UReTBrPSe6yzce5/lz8T6nLhInUTuKJqTjgF0H8kJOXI0Oc9IsG3GIYCb
         8NHTYcEZPqsELgDIyqZMKPF5zSngMtfqO1QIkNixqBLITL76t+apyarfBypbNGJR7+mJ
         X7yHvx0b10nGSVXLVazKu1g1LJQ4A8KJKt/DHgwyiw/a4+Mj8p8aRoRjUIu7qwhHEmgv
         Ow5OJlUIzKlKxcNi/dLGIFevVUQAul6ypokkjzdQL3t34MiAq/igS0OZ/JJXgW+wt789
         /hvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678094362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uyAoOVBgvrRZ8o47EfBbfO9DwxNDPSR6c2gpZFB3WTY=;
        b=Ru9tLOJ8cYWzmYRDIjtTIp17frotSoURL6Zu3JcrMfdTQSb6hQ2nUKzR1alXlybqVN
         xZCce2cNAErisG9S1aGu7wBpLLG7sqvkfx+OydzYNgPNHH9Mx5zfToeOWEqlH+Q3ePcO
         9qFEWXa34lnQW3ebtWjQzs2rhsemgdrXJEqi3Z1pbk0GDnqhjFGNn3QCEU9cB1Clo8AC
         tzkn+11VTs4ZtIYj2Nx5pW/u0cyltYvAZ9BAGnQY1toQseRQzLn0LgAyItajgJOOEj1P
         jN+2OWY3VfHtY0fm9RgHh9caQrD45QB1wQJV02VvkKl4n2Ywbw0B6rqwqmPg+vi2/5CL
         WeWQ==
X-Gm-Message-State: AO0yUKWois2ek1Eu88uxSlS5mCtiR4zYoLpGfnisdDCv+qPHrTN3ZRBF
	KwhucBIULFXn3aPXIuFat33DZJcaZXc=
X-Google-Smtp-Source: AK7set95d29n79EZ/1xWSmVlwm2by1tUWUL+sh/27jkR/bpHxGaYcN+jCgEgZnW0U5paub2u7J/ZYg==
X-Received: by 2002:a62:1ad4:0:b0:5a8:d407:60f9 with SMTP id a203-20020a621ad4000000b005a8d40760f9mr7796649pfa.29.1678094362312;
        Mon, 06 Mar 2023 01:19:22 -0800 (PST)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id f6-20020aa782c6000000b005a8db4e3ecesm5883675pfn.69.2023.03.06.01.19.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Mar 2023 01:19:22 -0800 (PST)
Date: Mon, 6 Mar 2023 17:25:39 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH 1/2] erofs-utils: get rid of z_erofs_do_map_blocks()
 forward declaration
Message-ID: <20230306172539.00001276.zbestahu@gmail.com>
In-Reply-To: <6d65a6fa-869d-8259-b271-7e20332188f6@linux.alibaba.com>
References: <e90f4dc828bb45b1a3ccbd1769a590410f3a82da.1678092797.git.huyue2@coolpad.com>
	<6d65a6fa-869d-8259-b271-7e20332188f6@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: huyue2@coolpad.com, linux-erofs@lists.ozlabs.org, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, 6 Mar 2023 17:00:25 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> On 2023/3/6 16:54, Yue Hu wrote:
> > From: Yue Hu <huyue2@coolpad.com>
> > 
> > Keep in sync with the kernel commit 999f2f9a63f4 ("erofs: get rid of
> > z_erofs_do_map_blocks() forward declaration").  
> 
> Does z_erofs_do_map_blocks() already keep in sync with the kernel
> implementation?  Anyway, it's just another question indepentently
> to this patch.

Ok, let me correct the message in v2.

> 
> > 
> > Signed-off-by: Yue Hu <huyue2@coolpad.com>
> > ---
> >   lib/zmap.c | 156 ++++++++++++++++++++++++++---------------------------
> >   1 file changed, 76 insertions(+), 80 deletions(-)
> > 
> > diff --git a/lib/zmap.c b/lib/zmap.c
> > index 69b468d..3c665f8 100644
> > --- a/lib/zmap.c
> > +++ b/lib/zmap.c
> > @@ -10,10 +10,6 @@
> >   #include "erofs/io.h"
> >   #include "erofs/print.h"
> >   
> > -static int z_erofs_do_map_blocks(struct erofs_inode *vi,
> > -				 struct erofs_map_blocks *map,
> > -				 int flags);
> > -
> >   int z_erofs_fill_inode(struct erofs_inode *vi)
> >   {
> >   	if (!erofs_sb_has_big_pcluster() &&
> > @@ -29,82 +25,6 @@ int z_erofs_fill_inode(struct erofs_inode *vi)
> >   	return 0;
> >   }
> >   
> > -static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
> > -{
> > -	int ret;
> > -	erofs_off_t pos;
> > -	struct z_erofs_map_header *h;
> > -	char buf[sizeof(struct z_erofs_map_header)];
> > -
> > -	if (vi->flags & EROFS_I_Z_INITED)
> > -		return 0;
> > -
> > -	pos = round_up(iloc(vi->nid) + vi->inode_isize + vi->xattr_isize, 8);
> > -	ret = dev_read(0, buf, pos, sizeof(buf));
> > -	if (ret < 0)
> > -		return -EIO;
> > -
> > -	h = (struct z_erofs_map_header *)buf;
> > -	/*
> > -	 * if the highest bit of the 8-byte map header is set, the whole file
> > -	 * is stored in the packed inode. The rest bits keeps z_fragmentoff.
> > -	 */
> > -	if (h->h_clusterbits >> Z_EROFS_FRAGMENT_INODE_BIT) {
> > -		vi->z_advise = Z_EROFS_ADVISE_FRAGMENT_PCLUSTER;
> > -		vi->fragmentoff = le64_to_cpu(*(__le64 *)h) ^ (1ULL << 63);
> > -		vi->z_tailextent_headlcn = 0;
> > -		goto out;
> > -	}
> > -
> > -	vi->z_advise = le16_to_cpu(h->h_advise);
> > -	vi->z_algorithmtype[0] = h->h_algorithmtype & 15;
> > -	vi->z_algorithmtype[1] = h->h_algorithmtype >> 4;
> > -
> > -	if (vi->z_algorithmtype[0] >= Z_EROFS_COMPRESSION_MAX) {
> > -		erofs_err("unknown compression format %u for nid %llu",
> > -			  vi->z_algorithmtype[0], (unsigned long long)vi->nid);
> > -		return -EOPNOTSUPP;
> > -	}
> > -
> > -	vi->z_logical_clusterbits = LOG_BLOCK_SIZE + (h->h_clusterbits & 7);
> > -	if (vi->datalayout == EROFS_INODE_FLAT_COMPRESSION &&
> > -	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1) ^
> > -	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_2)) {
> > -		erofs_err("big pcluster head1/2 of compact indexes should be consistent for nid %llu",
> > -			  vi->nid * 1ULL);
> > -		return -EFSCORRUPTED;
> > -	}
> > -
> > -	if (vi->z_advise & Z_EROFS_ADVISE_INLINE_PCLUSTER) {
> > -		struct erofs_map_blocks map = { .index = UINT_MAX };
> > -
> > -		vi->idata_size = le16_to_cpu(h->h_idata_size);
> > -		ret = z_erofs_do_map_blocks(vi, &map,
> > -					    EROFS_GET_BLOCKS_FINDTAIL);
> > -		if (!map.m_plen ||
> > -		    erofs_blkoff(map.m_pa) + map.m_plen > EROFS_BLKSIZ) {
> > -			erofs_err("invalid tail-packing pclustersize %llu",
> > -				  map.m_plen | 0ULL);
> > -			return -EFSCORRUPTED;
> > -		}
> > -		if (ret < 0)
> > -			return ret;
> > -	}
> > -	if (vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER &&
> > -	    !(h->h_clusterbits >> Z_EROFS_FRAGMENT_INODE_BIT)) {
> > -		struct erofs_map_blocks map = { .index = UINT_MAX };
> > -
> > -		vi->fragmentoff = le32_to_cpu(h->h_fragmentoff);
> > -		ret = z_erofs_do_map_blocks(vi, &map,
> > -					    EROFS_GET_BLOCKS_FINDTAIL);
> > -		if (ret < 0)
> > -			return ret;
> > -	}
> > -out:
> > -	vi->flags |= EROFS_I_Z_INITED;
> > -	return 0;
> > -}
> > -
> >   struct z_erofs_maprecorder {
> >   	struct erofs_inode *inode;
> >   	struct erofs_map_blocks *map;
> > @@ -675,6 +595,82 @@ out:
> >   	return err;
> >   }
> >   
> > +static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
> > +{
> > +	int ret;
> > +	erofs_off_t pos;
> > +	struct z_erofs_map_header *h;
> > +	char buf[sizeof(struct z_erofs_map_header)];
> > +
> > +	if (vi->flags & EROFS_I_Z_INITED)
> > +		return 0;
> > +
> > +	pos = round_up(iloc(vi->nid) + vi->inode_isize + vi->xattr_isize, 8);
> > +	ret = dev_read(0, buf, pos, sizeof(buf));
> > +	if (ret < 0)
> > +		return -EIO;
> > +
> > +	h = (struct z_erofs_map_header *)buf;
> > +	/*
> > +	 * if the highest bit of the 8-byte map header is set, the whole file
> > +	 * is stored in the packed inode. The rest bits keeps z_fragmentoff.
> > +	 */
> > +	if (h->h_clusterbits >> Z_EROFS_FRAGMENT_INODE_BIT) {
> > +		vi->z_advise = Z_EROFS_ADVISE_FRAGMENT_PCLUSTER;
> > +		vi->fragmentoff = le64_to_cpu(*(__le64 *)h) ^ (1ULL << 63);
> > +		vi->z_tailextent_headlcn = 0;
> > +		goto out;
> > +	}
> > +
> > +	vi->z_advise = le16_to_cpu(h->h_advise);
> > +	vi->z_algorithmtype[0] = h->h_algorithmtype & 15;
> > +	vi->z_algorithmtype[1] = h->h_algorithmtype >> 4;
> > +
> > +	if (vi->z_algorithmtype[0] >= Z_EROFS_COMPRESSION_MAX) {
> > +		erofs_err("unknown compression format %u for nid %llu",
> > +			  vi->z_algorithmtype[0], (unsigned long long)vi->nid);
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	vi->z_logical_clusterbits = LOG_BLOCK_SIZE + (h->h_clusterbits & 7);
> > +	if (vi->datalayout == EROFS_INODE_FLAT_COMPRESSION &&
> > +	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1) ^
> > +	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_2)) {
> > +		erofs_err("big pcluster head1/2 of compact indexes should be consistent for nid %llu",
> > +			  vi->nid * 1ULL);
> > +		return -EFSCORRUPTED;
> > +	}
> > +
> > +	if (vi->z_advise & Z_EROFS_ADVISE_INLINE_PCLUSTER) {
> > +		struct erofs_map_blocks map = { .index = UINT_MAX };
> > +
> > +		vi->idata_size = le16_to_cpu(h->h_idata_size);
> > +		ret = z_erofs_do_map_blocks(vi, &map,
> > +					    EROFS_GET_BLOCKS_FINDTAIL);
> > +		if (!map.m_plen ||
> > +		    erofs_blkoff(map.m_pa) + map.m_plen > EROFS_BLKSIZ) {
> > +			erofs_err("invalid tail-packing pclustersize %llu",
> > +				  map.m_plen | 0ULL);
> > +			return -EFSCORRUPTED;
> > +		}
> > +		if (ret < 0)
> > +			return ret;
> > +	}
> > +	if (vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER &&
> > +	    !(h->h_clusterbits >> Z_EROFS_FRAGMENT_INODE_BIT)) {
> > +		struct erofs_map_blocks map = { .index = UINT_MAX };
> > +
> > +		vi->fragmentoff = le32_to_cpu(h->h_fragmentoff);
> > +		ret = z_erofs_do_map_blocks(vi, &map,
> > +					    EROFS_GET_BLOCKS_FINDTAIL);
> > +		if (ret < 0)
> > +			return ret;
> > +	}
> > +out:
> > +	vi->flags |= EROFS_I_Z_INITED;
> > +	return 0;
> > +}
> > +
> >   int z_erofs_map_blocks_iter(struct erofs_inode *vi,
> >   			    struct erofs_map_blocks *map,
> >   			    int flags)  

