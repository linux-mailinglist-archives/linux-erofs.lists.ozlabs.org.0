Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8697D600061
	for <lists+linux-erofs@lfdr.de>; Sun, 16 Oct 2022 17:06:04 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Mr3NQ3wMzz3bhh
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Oct 2022 02:05:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=OYCMy3DF;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::434; helo=mail-pf1-x434.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=OYCMy3DF;
	dkim-atps=neutral
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Mr3NG729dz2xWx
	for <linux-erofs@lists.ozlabs.org>; Mon, 17 Oct 2022 02:05:48 +1100 (AEDT)
Received: by mail-pf1-x434.google.com with SMTP id i3so9003283pfk.9
        for <linux-erofs@lists.ozlabs.org>; Sun, 16 Oct 2022 08:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dmYYl0FFmCnwl0KsAmJQDcMF16Y99ygtOLlyuQkR5oE=;
        b=OYCMy3DFE7lVaXiyI5ZELZyEyVfycxTpeZSGDZSa9y0ewZxOjzgMOWmV+dGt4hkdhA
         XNZVEo4AiCpeAUyVvJjI9Bqd7R2l95HmVPRKN/I1JpQgL2l4xdKd8+YcJfN1xK/8+hy8
         wo+sqiWSjwemvjeHIM7p/ju4Oj2x87roDMDysen2ylOQe/1tYMTrJGlJx8H7a4t9lS2i
         rtJYiH0nSDAGbOU93UCDifsEcSA4K/KFRpTT6YIn1ue1fNNVaPmnsuxWryHV6p0ohD6O
         HxnyhoZZHJY3a8OQOYuPBba4S/07m4FQwaIKkHu00xa5/wyHX6Xt5K8OcWqN5uoFkQrB
         TQBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dmYYl0FFmCnwl0KsAmJQDcMF16Y99ygtOLlyuQkR5oE=;
        b=51YWJeQT1MCkdzzxgVRE7pArEg+prHBo0Kji/z3RCq+Yn6wQNQFcLujaukw8aUyaSK
         Q4jh5gnFJ2bbAs/1h9Tmi28h26FMm3enakhOskVeMKgpEU5p+0ork7VBmr7dx5msPFKZ
         EvVdgew6GaG+rklZr/gBGQrUro+kdBQ/2qtz3Y3Zu4G6LKAIGhNDhdJMyT57f2y0Mjy2
         xM01q6JhwGFtsgDM2dFsikYQe/o8RE8ADP1pmg+DSDxUyMSFc9rvw7I58eKVxZJLEne1
         nk4QHNOtBVancOCPYLmsTLo0zg9yD40n3cEPvWfbj303FsRfRW+gCA9JZl+IwNZdN9En
         QkTw==
X-Gm-Message-State: ACrzQf38nmTNdrwwfYd2Bv9vdx7WJW6gsWUarTkliOc8hR5WiEiF2maC
	Gn/vnmRz4AFpW7OBuJ7Ij1b63Q==
X-Google-Smtp-Source: AMsMyM4oey+NsfzkhAme+/KRCBVrkUHGqTIbG+ul3+f8FjK+gmTZXT9d5fudwDd8RYSRCsBB5ru34w==
X-Received: by 2002:a05:6a00:1a07:b0:541:6060:705d with SMTP id g7-20020a056a001a0700b005416060705dmr7983085pfv.61.1665932744304;
        Sun, 16 Oct 2022 08:05:44 -0700 (PDT)
Received: from [10.254.211.51] ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id i6-20020a628706000000b00553b37c7732sm5125757pfe.105.2022.10.16.08.05.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Oct 2022 08:05:43 -0700 (PDT)
Message-ID: <4fc164e8-f307-0217-3977-39f3fa412a21@bytedance.com>
Date: Sun, 16 Oct 2022 23:05:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.3
Subject: Re: [External] [PATCH] erofs: protect s_inodes with s_inode_list_lock
To: Dawei Li <set_pte_at@outlook.com>, xiang@kernel.org, chao@kernel.org
References: <TYCP286MB23237A9993E0FFCFE5C2BDBECA269@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
From: Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <TYCP286MB23237A9993E0FFCFE5C2BDBECA269@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: huyue2@coolpad.com, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

在 2022/10/16 20:37, Dawei Li 写道:
> s_inodes is superblock-specific resource, which should be
> protected by sb's specific lock s_inode_list_lock.
>  > base-commit: 8436c4a57bd147b0bd2943ab499bb8368981b9e1
> 
> Signed-off-by: Dawei Li <set_pte_at@outlook.com>
> ---
>   fs/erofs/fscache.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index 998cd26a1b3b..bbf5268440df 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -589,15 +589,18 @@ struct erofs_fscache *erofs_domain_register_cookie(struct super_block *sb,
>   	struct erofs_domain *domain = EROFS_SB(sb)->domain;
>   	struct super_block *psb = erofs_pseudo_mnt->mnt_sb;
>   
> -	mutex_lock(&erofs_domain_cookies_lock);
Hi Dawei,
Thanks for catching this.

I would suggest holding this mutex lock during inode searches and
inserts to avoid the following case:

P1				P2
lock inode_list lock
traverse sb->s_inodes
unlock inode_list lock
				lock inode_list
				traverse sb->s_inodes
				unlock inode_list
				domain_init_cookie
domain_init_cookie

Thanks,
Jia
> +	spin_lock(&psb->s_inode_list_lock);
>   	list_for_each_entry(inode, &psb->s_inodes, i_sb_list) {
>   		ctx = inode->i_private;
>   		if (!ctx || ctx->domain != domain || strcmp(ctx->name, name))
>   			continue;
>   		igrab(inode);
> -		mutex_unlock(&erofs_domain_cookies_lock);
> +		spin_unlock(&psb->s_inode_list_lock);
>   		return ctx;
>   	}
> +	spin_unlock(&psb->s_inode_list_lock);
> +
> +	mutex_lock(&erofs_domain_cookies_lock);
>   	ctx = erofs_fscache_domain_init_cookie(sb, name, need_inode);
>   	mutex_unlock(&erofs_domain_cookies_lock);
>   	return ctx;
