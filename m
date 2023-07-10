Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DE974CEA8
	for <lists+linux-erofs@lfdr.de>; Mon, 10 Jul 2023 09:39:24 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=OZV5e6X8;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Qzwqt0GJtz3c1B
	for <lists+linux-erofs@lfdr.de>; Mon, 10 Jul 2023 17:39:22 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=OZV5e6X8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::22d; helo=mail-oi1-x22d.google.com; envelope-from=zbestahu@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Qzwqj300kz3bvy
	for <linux-erofs@lists.ozlabs.org>; Mon, 10 Jul 2023 17:39:12 +1000 (AEST)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3a337ddff16so3220081b6e.0
        for <linux-erofs@lists.ozlabs.org>; Mon, 10 Jul 2023 00:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688974747; x=1691566747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nylNd4bJypqjy2p+mIjX7+lH56E0VvWsXGVw57XSk4s=;
        b=OZV5e6X85cMz8lstlN5z4lDR4f9EVfhUISluyAD1bMUMFNGBNEe2n/U1bxS+AnNDN/
         Tb2JYyz1IyFaCCnPpVnCpvk5jVwaGpDInbvV0mIuaI+M4vTvWTcnuyEqyiEMVkNyXTZD
         3Tz3BHIKy0uFm4Rhqh2X+ZWquLnT8ZVk6ELdS4RJtNpxWrcPpKjE3M++9Wwkg6GikQjx
         CW+HmyaO9PMaJlS7G7xQrrhExKMWpP3/ROvzwUAMBxv97jlGuUSLG92QhUU32DoYkql+
         28sGW10aQBzkhFqPR3Eq0Zs3TdZD1I+FaVWN0nmg+QgUk+DmRZfaHvtRhIAxEh8Vt33l
         wYIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688974747; x=1691566747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nylNd4bJypqjy2p+mIjX7+lH56E0VvWsXGVw57XSk4s=;
        b=c6I62VFL2Uy61EgPhjdNWowG3dF/yQDYMsnawV8303NnPN/NrMTXzMiumBWwxw0Sxc
         nGAN841WukSSmyW8rsO+m+ezuiOTllUpcmdgiMFxvph1zYjD9+9mckTRG7u+H2oV+6u6
         OFnGCQtiT6g5t41Cur03/ou0kyr5ZYmjMJZtA5nedQgP7a3yETsl1zOJO38GdaH96+W8
         O6JHFI/Yt6aXnceHps4wPZ/pBO9cj/+a9HZfFFPXHFnN7UC7e4Nb/vsbJut1TSV/jPHO
         6VuclJ5eNG68HLIWsTve9kZInI1VR/SHKZRtL3le/LN/UveuLH+VL8HOYBFhZKWj/F/Q
         pngg==
X-Gm-Message-State: ABy/qLblD3guMWo5PG/zNJmfdLicwaUd3dmg3kY2Xwczix2S9vhtLbM5
	NKjWf3HUGRj4kDuukw5yP/w=
X-Google-Smtp-Source: APBJJlHbIXs5YdWo0jHlQBb/TaAyGsm319HHwbaGco+P3H2xoPcTXP9B03R5HOdngBmrnSQ7KhrYmA==
X-Received: by 2002:a05:6358:2794:b0:133:7c4:e752 with SMTP id l20-20020a056358279400b0013307c4e752mr13392849rwb.26.1688974747335;
        Mon, 10 Jul 2023 00:39:07 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id c1-20020aa781c1000000b0067eb174cb9asm6488392pfn.136.2023.07.10.00.39.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Jul 2023 00:39:07 -0700 (PDT)
Date: Mon, 10 Jul 2023 15:48:03 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Chunhai Guo <guochunhai@vivo.com>
Subject: Re: [PATCH] erofs: avoid unnecessary loops in
 z_erofs_pcluster_readmore() when read page beyond EOF
Message-ID: <20230710154803.00004047.zbestahu@gmail.com>
In-Reply-To: <20230710042531.28761-1-guochunhai@vivo.com>
References: <20230710042531.28761-1-guochunhai@vivo.com>
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, huyue2@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, 10 Jul 2023 12:25:31 +0800
Chunhai Guo <guochunhai@vivo.com> wrote:

> z_erofs_pcluster_readmore() may take a long time to loop when the page
> offset is large enough, which is unnecessary should be prevented.
> For example, when the following case is encountered, it will loop 4691368
> times, taking about 27 seconds.
>     - offset = 19217289215
>     - inode_size = 1442672
> 
> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
> ---
>  fs/erofs/zdata.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 5f1890e309c6..d9a0763f4595 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -1841,7 +1841,7 @@ static void z_erofs_pcluster_readmore(struct z_erofs_decompress_frontend *f,
>  	}
>  
>  	cur = map->m_la + map->m_llen - 1;
> -	while (cur >= end) {
> +	while ((cur >= end) && (cur < i_size_read(inode))) {
>  		pgoff_t index = cur >> PAGE_SHIFT;
>  		struct page *page;
>  

Reviewed-by: Yue Hu <huyue2@coolpad.com>
