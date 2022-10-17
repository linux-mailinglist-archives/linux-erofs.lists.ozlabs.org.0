Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE916005A4
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Oct 2022 05:15:18 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MrMYs26Whz3blY
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Oct 2022 14:15:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=zzva/m9m;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=zzva/m9m;
	dkim-atps=neutral
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MrMYj31TNz2xWx
	for <linux-erofs@lists.ozlabs.org>; Mon, 17 Oct 2022 14:15:02 +1100 (AEDT)
Received: by mail-pj1-x1031.google.com with SMTP id p3-20020a17090a284300b0020a85fa3ffcso13010814pjf.2
        for <linux-erofs@lists.ozlabs.org>; Sun, 16 Oct 2022 20:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2yjvq6ezitsrSNTf32OzUxI3sqOLN/GKGXF5ya2pTxI=;
        b=zzva/m9mkPAow1cTOKd0/1bN6IXydDAidItnSBz64dBJGx3AiZmzDKfDJ8ds0zhF08
         nc3ZqgByhUstI9PV3SZ3JQfhQLgiSVrsZBJx/Tgy+MBvdMvL1vYQPtnd/Kjy5Kj6wjX4
         4Zf6ngwEIHYPr5y6lgmGGv3dWC+L5oUnSgcuC7+wStwi38zrAMea/Xc5Ku3mfti2uG8W
         Hvp4QyioIjxrKLCziAd2eSJc7HKDqfl+1MpcvlxRGeFu6DkZwFA6eZERFt514EuOWpWP
         WD0CDKIxMiRf2Osd8sWqVZhl6cOtJmC0/mCNQRjP23LfRCmINnEEdwW6ljnunNjDQw/w
         o1HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2yjvq6ezitsrSNTf32OzUxI3sqOLN/GKGXF5ya2pTxI=;
        b=nb5gHFnElov9PdkdAOXC+k8JTv/kEyrf4TUbX2t8ILndUJjE/N3yad+mUKX/ORECyG
         Y1qB+QehPHSYZ0w/+c4tBDpHMKfdOcJB0p4p8ZOabq+TXp37/v0BGinEq2G3vy6LpZSc
         1XJyLwY6jSGoqfPXYIWlcWliJ6gumc/uiWbBRGtn/EQRNH6HPc7w2HeTjwTH8s1zFnnz
         JcLb0u1Vmb0VjvCuP3mbnwvAevLXXzbcMSkwspdMbBHryvbeegjQ7OEl6Upv/kCT2a4I
         9ZtpGZLowVLGstYwX97QVPWTDR6LU7mfcjxiqVVxEy4gdCMFfubpYbKeugGc/YtBX/L5
         T7TQ==
X-Gm-Message-State: ACrzQf2qsQfa/2fo6oC7dB6DJvrISolTCsQIQ08OSyP9crLxlqvy040i
	1tY1rkT4Kigbn9a4lXgwfbY2dg==
X-Google-Smtp-Source: AMsMyM4d/EMY4URnAhNGwukqPgoOU94si0M55eodhKPC+1e8j+6xryVsz0EEtEF11YBnHEoP9JhoqA==
X-Received: by 2002:a17:90b:19d0:b0:20b:1d66:8a17 with SMTP id nm16-20020a17090b19d000b0020b1d668a17mr11431532pjb.2.1665976498701;
        Sun, 16 Oct 2022 20:14:58 -0700 (PDT)
Received: from [10.3.156.122] ([63.216.146.185])
        by smtp.gmail.com with ESMTPSA id oj5-20020a17090b4d8500b001f262f6f717sm8918341pjb.3.2022.10.16.20.14.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Oct 2022 20:14:58 -0700 (PDT)
Message-ID: <80e1f65f-e051-adbf-946f-ef2a27ff55f9@bytedance.com>
Date: Mon, 17 Oct 2022 11:14:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.3
Subject: Re: [External] [PATCH v2] erofs: protect s_inodes with
 s_inode_list_lock
To: Dawei Li <set_pte_at@outlook.com>, xiang@kernel.org, chao@kernel.org
References: <TYCP286MB23238380DE3B74874E8D78ABCA299@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
From: Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <TYCP286MB23238380DE3B74874E8D78ABCA299@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
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



在 2022/10/17 09:55, Dawei Li 写道:
> s_inodes is superblock-specific resource, which should be
> protected by sb's specific lock s_inode_list_lock.
> 
> v2: update the locking mechanisim to protect mutual-exclusive access
> both for s_inode_list_lock & erofs_fscache_domain_init_cookie(), as the
> reviewing comments from Jia Zhu.
> 
> v1: https://lore.kernel.org/all/TYCP286MB23237A9993E0FFCFE5C2BDBECA269@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM/
> 
> base-commit: 8436c4a57bd147b0bd2943ab499bb8368981b9e1
> 
> Signed-off-by: Dawei Li <set_pte_at@outlook.com>
> ---
>   fs/erofs/fscache.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index 998cd26a1b3b..fe05bc51f9f2 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -590,14 +590,17 @@ struct erofs_fscache *erofs_domain_register_cookie(struct super_block *sb,
>   	struct super_block *psb = erofs_pseudo_mnt->mnt_sb;
>   
>   	mutex_lock(&erofs_domain_cookies_lock);
> +	spin_lock(&psb->s_inode_list_lock);
>   	list_for_each_entry(inode, &psb->s_inodes, i_sb_list) {
>   		ctx = inode->i_private;
>   		if (!ctx || ctx->domain != domain || strcmp(ctx->name, name))
>   			continue;
>   		igrab(inode);
> +		spin_unlock(&psb->s_inode_list_lock);
>   		mutex_unlock(&erofs_domain_cookies_lock);
>   		return ctx;
>   	}
> +	spin_unlock(&psb->s_inode_list_lock);
>   	ctx = erofs_fscache_domain_init_cookie(sb, name, need_inode);
>   	mutex_unlock(&erofs_domain_cookies_lock);
>   	return ctx;
LGTM
Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>
