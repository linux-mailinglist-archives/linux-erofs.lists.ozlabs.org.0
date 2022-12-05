Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E43766422CA
	for <lists+linux-erofs@lfdr.de>; Mon,  5 Dec 2022 06:37:08 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NQXNy620Tz3bbD
	for <lists+linux-erofs@lfdr.de>; Mon,  5 Dec 2022 16:37:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=dOEx4YK/;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=dOEx4YK/;
	dkim-atps=neutral
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NQXNq2pRvz3bT0
	for <linux-erofs@lists.ozlabs.org>; Mon,  5 Dec 2022 16:36:58 +1100 (AEDT)
Received: by mail-pl1-x635.google.com with SMTP id p24so9837870plw.1
        for <linux-erofs@lists.ozlabs.org>; Sun, 04 Dec 2022 21:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SdzchblXoZwUvD3xpYvgxo8UUz9Y8yBlv4ETk+uk1T4=;
        b=dOEx4YK/b7I2bwdB6L+NvLbB0HkWQ9qtGRWQVBIhQgaIE5EqDjGOfkYNGMmMpKlBK+
         cS7ELPOud/i9bIMCBtkoVD4LhjwV/dO562heivoHwNxZEoytFehXoyYI+DYdCl0hhOxj
         O4QZ/Dt8HSBVS+6ZTAoPt9nKVhldCg/+BawBaaaJhhUdvBUWOkZzRAaV5dCxTHhxoALr
         YH2JG6us3IGbdSvjReEhRfNo8lbj1YDoKkjBUA1CNegtxjQwu66PoMu26zqZzRiRnlU7
         AW2LED0qkL23jSWpgq5GamyDdbDgU5PYSxucOvxNPsEwrL8YGDnTrpoODFWuRfsjfNr2
         n44A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SdzchblXoZwUvD3xpYvgxo8UUz9Y8yBlv4ETk+uk1T4=;
        b=BoVPTtpPjyQow1PIy3kIfUN4XvUBJXa9vapHyQ0Kdg5cGWnWz5kSfefsx0x6E0u9tD
         bAd9jvmoaQATzrDbnOUo7mhd53Sa9/z/ScGfxLcb4MrQ+ztZi0zmJYrICImeDay5c1gr
         17PzleN9dkm/WoP/HxBzjwsqm1ZIQrzsQs/bnYJXozFVIO+CfyKT/BuVtuh98N/d+iGN
         ZKGAEnvgRKEBXKUhhctipX1iJIEGBAQ8AH2MskzQWp1V9RchADRmhO8ijZLJkT7ZN7TV
         nsfEyA7AZvUnr9g6SRAwNEPIw0A/jIbjkwFBfGY3kwknpvPQ1sn3o8KbvWhhkvG3SzX2
         ggew==
X-Gm-Message-State: ANoB5pkWq8UJ/LOuUyl84Ipm4Oas9di9LLI7gXXmTuIpUCyNWAHLLQ4B
	ewmMWzlogpMaaCmxS3myJXg=
X-Google-Smtp-Source: AA0mqf6EOFcQ308Qx6fwTUhkM4VAQ/6VCJZ/G4WtMTPbsyMPdYmVO2PvOb91RDlSLyAHBIu5N+ZmtQ==
X-Received: by 2002:a17:902:f095:b0:189:b352:a236 with SMTP id p21-20020a170902f09500b00189b352a236mr19268112pla.75.1670218614380;
        Sun, 04 Dec 2022 21:36:54 -0800 (PST)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id b9-20020a170902d40900b0018703bf42desm9573235ple.159.2022.12.04.21.36.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 04 Dec 2022 21:36:54 -0800 (PST)
Date: Mon, 5 Dec 2022 13:41:10 +0800
From: Yue Hu <zbestahu@gmail.com>
To: chenzhongjin@huawei.com, huyue2@coolpad.com
Subject: Re: [PATCH -next v3] erofs: Fix pcluster memleak when its block
 address is zero
Message-ID: <20221205134110.000031d1.zbestahu@gmail.com>
In-Reply-To: <20221205034957.90362-1-chenzhongjin@huawei.com>
References: <20221205034957.90362-1-chenzhongjin@huawei.com>
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
Cc: linux-erofs@lists.ozlabs.org, syzbot+6f8cd9a0155b366d227f@syzkaller.appspotmail.com, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, 5 Dec 2022 11:49:57 +0800
Chen Zhongjin via Linux-erofs <linux-erofs@lists.ozlabs.org> wrote:

> syzkaller reported a memleak:
> https://syzkaller.appspot.com/bug?id=62f37ff612f0021641eda5b17f056f1668aa9aed
> 
> unreferenced object 0xffff88811009c7f8 (size 136):
>   ...
>   backtrace:
>     [<ffffffff821db19b>] z_erofs_do_read_page+0x99b/0x1740
>     [<ffffffff821dee9e>] z_erofs_readahead+0x24e/0x580
>     [<ffffffff814bc0d6>] read_pages+0x86/0x3d0
>     ...
> 
> syzkaller constructed a case: in z_erofs_register_pcluster(),
> ztailpacking = false and map->m_pa = zero. This makes pcl->obj.index be
> zero although pcl is not a inline pcluster.
> 
> Then following path adds refcount for grp, but the refcount won't be put
> because pcl is inline.
> 
> z_erofs_readahead()
>   z_erofs_do_read_page() # for another page
>     z_erofs_collector_begin()
>       erofs_find_workgroup()
>         erofs_workgroup_get()
> 
> Since it's illegal for the block address of a pcluster to be zero, add
> check here to avoid registering the pcluster which would be leaked.
> 
> Fixes: cecf864d3d76 ("erofs: support inline data decompression")
> Reported-by: syzbot+6f8cd9a0155b366d227f@syzkaller.appspotmail.com
> Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>

Thanks.

> ---
> v1 -> v2:
> As Gao's advice, we should fail to register pcluster if m_pa is zero.
> Maked it this way and changed the commit message.
> 
> v2 -> v3:
> Slightly fix commit message and add -next tag.
> ---
>  fs/erofs/zdata.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index b792d424d774..7826634f4f51 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -488,7 +488,8 @@ static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
>  	struct erofs_workgroup *grp;
>  	int err;
>  
> -	if (!(map->m_flags & EROFS_MAP_ENCODED)) {
> +	if (!(map->m_flags & EROFS_MAP_ENCODED) ||
> +		!(map->m_pa >> PAGE_SHIFT)) {
>  		DBG_BUGON(1);
>  		return -EFSCORRUPTED;
>  	}

