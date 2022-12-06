Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E06643D12
	for <lists+linux-erofs@lfdr.de>; Tue,  6 Dec 2022 07:18:48 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NR9GY658Zz3bX4
	for <lists+linux-erofs@lfdr.de>; Tue,  6 Dec 2022 17:18:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=C9WGBIcA;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=C9WGBIcA;
	dkim-atps=neutral
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NR9GR0BhXz306l
	for <linux-erofs@lists.ozlabs.org>; Tue,  6 Dec 2022 17:18:36 +1100 (AEDT)
Received: by mail-pl1-x62b.google.com with SMTP id k7so12986545pll.6
        for <linux-erofs@lists.ozlabs.org>; Mon, 05 Dec 2022 22:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y2DddouEQKfe5T1HPT/o0Lvg9osxHkFVaTa2j8bSG2k=;
        b=C9WGBIcADVx5WxbQuiycCiuFkyWSPSIJiFzY157WCnH+dsSXS5Y///0Xd8j3BvHF6z
         T4zcCEx+nLcHdxv8DH4oVu0NZlyNlGnSMbYj/IJccrz/lk/TiZUBVwoh3q+xllkaAlz6
         2zfoKYdgoU7MITUXmSc4UC2F4DTwhuM6U7UOiIZREHtwlo9MF5NVgZ2tBoCIyhW6NAnv
         L1NYGgleRCDUjVf1Up21uxmodRV5MkRkMtMX6JbuAVzhngTXk78mz2u1FmFYUXPnmRja
         7F+uHdS3mL7Wa54KykG7QWCUddnkwoL1BMQx2ZjUlLX6J5hF9p9b0c/ZuxWlaMLQ7qXy
         akvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y2DddouEQKfe5T1HPT/o0Lvg9osxHkFVaTa2j8bSG2k=;
        b=3N1/sWFwvAyM6qTxRRcShREJe3mU7zIXK2f5rmPWlWbikVHm3j8glFjx8g1AiYeFjL
         mIwnchsPqbopOyMYxjQdUu6dytwB75vMo4veex1LKZ4pfflkH/sOKNdy0MyE361MYGH8
         iDugi8oFHYh4WcZDKwJ7T9Sr6f7ASwNoNiXQcgM0n5sozQV8ltSzs+c3uDgyesWlhm7d
         0qZuWWKoS+0JQ5jIYno754kXSNx/Obwp9sUJhgZrK2yLzuytPMygFqzPz3fI3CxFMctD
         zjoikAzQjRLapXnIh52IFYfBnWcqsqSzE9DaVI4BOf5JKDUDiaLQn3+B/0MF2sgp7DeF
         OkqQ==
X-Gm-Message-State: ANoB5pkUIk1OEgUBOxNsj7p0GZV0/rMLKaj37xpPQuqxb6Mbixx3kWWz
	gVkHqhMjDa5icsp0nVB8xP8=
X-Google-Smtp-Source: AA0mqf5wxtCVesu9mY9IFcfl8szGXpgSADbr5LDn5xdnCZXE2JllW6Hek5ZLQ6Xi5jvDGUgduV8lpg==
X-Received: by 2002:a17:90a:9402:b0:219:6c4d:ba9d with SMTP id r2-20020a17090a940200b002196c4dba9dmr28116826pjo.175.1670307514015;
        Mon, 05 Dec 2022 22:18:34 -0800 (PST)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id e13-20020a17090a280d00b00218a7808ec9sm3489737pjd.8.2022.12.05.22.18.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Dec 2022 22:18:33 -0800 (PST)
Date: Tue, 6 Dec 2022 14:22:51 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH 1/2] erofs: fix missing unmap if
 z_erofs_get_extent_compressedlen() fails
Message-ID: <20221206142251.00001fb4.zbestahu@gmail.com>
In-Reply-To: <20221205150050.47784-1-hsiangkao@linux.alibaba.com>
References: <20221205150050.47784-1-hsiangkao@linux.alibaba.com>
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon,  5 Dec 2022 23:00:49 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Otherwise, meta buffers could be leaked.
> 
> Fixes: cec6e93beadf ("erofs: support parsing big pcluster compress indexes")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>

> ---
>  fs/erofs/zmap.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
> index 749a5ac943f4..98eff1259de4 100644
> --- a/fs/erofs/zmap.c
> +++ b/fs/erofs/zmap.c
> @@ -694,7 +694,7 @@ static int z_erofs_do_map_blocks(struct inode *inode,
>  		map->m_pa = blknr_to_addr(m.pblk);
>  		err = z_erofs_get_extent_compressedlen(&m, initial_lcn);
>  		if (err)
> -			goto out;
> +			goto unmap_out;
>  	}
>  
>  	if (m.headtype == Z_EROFS_VLE_CLUSTER_TYPE_PLAIN) {
> @@ -718,14 +718,12 @@ static int z_erofs_do_map_blocks(struct inode *inode,
>  		if (!err)
>  			map->m_flags |= EROFS_MAP_FULL_MAPPED;
>  	}
> +
>  unmap_out:
>  	erofs_unmap_metabuf(&m.map->buf);
> -
> -out:
>  	erofs_dbg("%s, m_la %llu m_pa %llu m_llen %llu m_plen %llu m_flags 0%o",
>  		  __func__, map->m_la, map->m_pa,
>  		  map->m_llen, map->m_plen, map->m_flags);
> -
>  	return err;
>  }
>  

