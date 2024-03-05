Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A7087137A
	for <lists+linux-erofs@lfdr.de>; Tue,  5 Mar 2024 03:17:57 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=RRQJe5yV;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TpfNf6vBPz3c12
	for <lists+linux-erofs@lfdr.de>; Tue,  5 Mar 2024 13:17:54 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=RRQJe5yV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=zbestahu@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TpfNb61BBz2yt0
	for <linux-erofs@lists.ozlabs.org>; Tue,  5 Mar 2024 13:17:51 +1100 (AEDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1dbd32cff0bso43630515ad.0
        for <linux-erofs@lists.ozlabs.org>; Mon, 04 Mar 2024 18:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709605069; x=1710209869; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vf7ga+69rktGnQ6MLiBZYdtLAPO5MhkKVAzEKIflNBs=;
        b=RRQJe5yVPx9Oz3yY+7pZZ4U6ix5bAdAs6uD/Gg0NcG4WeEWNlliZMSfKLiOmx8Cs6N
         Mp3Pt/v8kcLKLQngEIVRuoi2Va/nLQKXIChbS5cBT9NBEOkRzb/tBENA0rrQyOU7IgM9
         SpUYHGJlTfG5nTpauqpe6LTrdcBZ2wplYPg8pcJE57TAzVK/VqowJ2ogqRz5rcwIzWo8
         yPfHkm0lIh4Chci+vPYkNhYV27rJBrG4x3zsRepNCLPj4UAQpdpm+iEtal3XbtDb1puW
         qCTAOeBIBx89ZoLZJrg/LGXezQxLgbJIxea5llaXGxWjj3esjJWwmOYQTP/U4eGUt8qj
         B9cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709605069; x=1710209869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vf7ga+69rktGnQ6MLiBZYdtLAPO5MhkKVAzEKIflNBs=;
        b=kX8f5es4cwY2QPa21Fia5X20Py8iFA64/NEiXMvg9Kwm5+e8omth8pyWSN3dAUSlK4
         EMBjEeyUwk+HfreN8SX60y+a04O+FSe5H/lMA+0HJTYNNwyNI1YMINFIeiULtSLJ1yb7
         rmlHLZJerpb7qtbD3vhum15T4PPkhEwlp7bLHCC4J+MVub+R+C2+/a91MfAEa+OimDvv
         znE7JgSDtuYHrkuUZoVa2hphKAq9s5HL/YUbodErP1w/1AuE0q6mkcRDofHa29a5YtW3
         oNbraQG4/bh0vsGSCcCBKa0sJMGm/05LhWMvpDw5xy+CpqQcXPGlwNTi1z2r1hcWRLjd
         5Phg==
X-Gm-Message-State: AOJu0Ywf+pzHB8S+mnXPifWmS73B38QzcrPpUx6mIdrg1edakDmrNDCJ
	j3+2gSR4oIHSVONd+4Au2odf7k2xMlxjotjeAmJvDw8Axc2aYXK9
X-Google-Smtp-Source: AGHT+IGj91Tjm/MnkW5aSDTuzFIKSk2jQBVxLcoidGuaAUEyy+/l3qywApWVvfEwjCDRFw40NxhyAQ==
X-Received: by 2002:a17:903:120e:b0:1dc:ca74:7018 with SMTP id l14-20020a170903120e00b001dcca747018mr656911plh.36.1709605069283;
        Mon, 04 Mar 2024 18:17:49 -0800 (PST)
Received: from localhost ([156.236.96.164])
        by smtp.gmail.com with ESMTPSA id y9-20020a1709027c8900b001db717d2dbbsm9153781pll.210.2024.03.04.18.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 18:17:49 -0800 (PST)
Date: Tue, 5 Mar 2024 10:17:42 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH] erofs: fix uninitialized page cache reported by KMSAN
Message-ID: <20240305101742.00000a0a.zbestahu@gmail.com>
In-Reply-To: <20240304035339.425857-1-hsiangkao@linux.alibaba.com>
References: <ab2a337d-c2dd-437d-9ab8-e3b837f1ff1a@I-love.SAKURA.ne.jp>
	<20240304035339.425857-1-hsiangkao@linux.alibaba.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-w64-mingw32)
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
Cc: syzbot+7bc44a489f0ef0670bd5@syzkaller.appspotmail.com, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, syzkaller-bugs@googlegroups.com, LKML <linux-kernel@vger.kernel.org>, Roberto Sassu <roberto.sassu@huaweicloud.com>, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon,  4 Mar 2024 11:53:39 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> syzbot reports a KMSAN reproducer [1] which generates a crafted
> filesystem image and causes IMA to read uninitialized page cache.
> 
> Later, (rq->outputsize > rq->inputsize) will be formally supported
> after either large uncompressed pclusters (> block size) or big
> lclusters are landed.  However, currently there is no way to generate
> such filesystems by using mkfs.erofs.
> 
> Thus, let's mark this condition as unsupported for now.
> 
> [1] https://lore.kernel.org/r/0000000000002be12a0611ca7ff8@google.com
> 
> Reported-by: syzbot+7bc44a489f0ef0670bd5@syzkaller.appspotmail.com
> Fixes: 1ca01520148a ("erofs: refine z_erofs_transform_plain() for sub-page block support")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/erofs/decompressor.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> index d4cee95af14c..2ec9b2bb628d 100644
> --- a/fs/erofs/decompressor.c
> +++ b/fs/erofs/decompressor.c
> @@ -323,7 +323,8 @@ static int z_erofs_transform_plain(struct z_erofs_decompress_req *rq,
>  	unsigned int cur = 0, ni = 0, no, pi, po, insz, cnt;
>  	u8 *kin;
>  
> -	DBG_BUGON(rq->outputsize > rq->inputsize);
> +	if (rq->outputsize > rq->inputsize)
> +		return -EOPNOTSUPP;
>  	if (rq->alg == Z_EROFS_COMPRESSION_INTERLACED) {
>  		cur = bs - (rq->pageofs_out & (bs - 1));
>  		pi = (rq->pageofs_in + rq->inputsize - cur) & ~PAGE_MASK;

Reviewed-by: Yue Hu <huyue2@coolpad.com>
