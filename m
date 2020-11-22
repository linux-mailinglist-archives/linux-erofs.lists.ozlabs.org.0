Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 093F72BC3E8
	for <lists+linux-erofs@lfdr.de>; Sun, 22 Nov 2020 06:38:03 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CdzZv4wW6zDqYB
	for <lists+linux-erofs@lfdr.de>; Sun, 22 Nov 2020 16:37:59 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=216.205.24.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=SSCXxMO3; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=gQCIbbQN; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CdzZd5wvnzDqWv
 for <linux-erofs@lists.ozlabs.org>; Sun, 22 Nov 2020 16:37:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606023460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8uGjHeZ8FWJVDGmE0NzBXvoU/y1lCuBdFYb86DhuGJk=;
 b=SSCXxMO3lG+Vo6/0lAGLr5pAjRuzBGEEShfApyJG+gT4xYy+hrIhH5niE/XyZPTcpILdic
 tRYyjfQnl7HVzKf7EPURipmINm3xMbRkf/Yh77x/pN1t5hhaxkEhKaUthueCC1HbYPEKv7
 PHbpr2bwKsJRwnLWZ21203YpI/9prQM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606023461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8uGjHeZ8FWJVDGmE0NzBXvoU/y1lCuBdFYb86DhuGJk=;
 b=gQCIbbQNPKm4ncGzP9I25Jp+rbUkWTEWHMbnjcRtY30dMd8dTl6RFSak/6F1P4c6k1hqX1
 hPJGvIwyD3f4L/+jhI9C053HxN5YPHundeDM8C7jyAC4Y8lUlFDqT/fd5S2RSnLAO2oImX
 L2JZIc4nsq5Yau1OTK4H3wYY60J/13M=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-Do_9cFMoMVyGgKubbN9JLA-1; Sun, 22 Nov 2020 00:37:39 -0500
X-MC-Unique: Do_9cFMoMVyGgKubbN9JLA-1
Received: by mail-pl1-f200.google.com with SMTP id u14so9291665plq.5
 for <linux-erofs@lists.ozlabs.org>; Sat, 21 Nov 2020 21:37:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=8uGjHeZ8FWJVDGmE0NzBXvoU/y1lCuBdFYb86DhuGJk=;
 b=fny9BFslh170rIEs+kvZg6xACECEi9a3nPgj7uFMa268pl/kcFTSIleVQ7iHpVHxQ6
 VOG5E19nLhLsP5VEO/cGRSWwna4E0BOgT91rWS7FDgxG7WrHXE1b1VfVfksLMfxJVaQC
 oirF6he7DNsWYT03sbrqrLaiPJZD/APqiSiX/0xt472QjufwdbXQtx6zkVpKZXvM1+at
 9+nbUsG92y/GijCrli9P4jv5Q7XMnUWbg4aZYhBqhkLvCfwoNyuEoiEXokMi5LSnv7fB
 0cW+qwYwAxT+8rev9CcrYgNyP8SQDZbHiw2DBiOh51HNKrMuxW3eL+Bs1evJSJgs0pry
 tl/w==
X-Gm-Message-State: AOAM532HLpIdcykxvzPNLxMmmomv+L+wFaXz8qcTzZ60MdF3zw1YiXyR
 ZNPJvHWQrv3H++zs5OzMAsH+B/J+dEzWyI5M4StZBEP8RiyPJ3vidx6Uqyje+UAeX81VGYmMZEU
 oF2F8DuFsIPnNxBldda7iq1YG
X-Received: by 2002:a17:90a:9504:: with SMTP id
 t4mr19378105pjo.82.1606023457913; 
 Sat, 21 Nov 2020 21:37:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz9wyiYVFVFmbtNMZhq0pKJSaqqqmvV+2Nxy83iYwKgbWoHoIfKb0RUD1BlgkjFMwNLgvunNA==
X-Received: by 2002:a17:90a:9504:: with SMTP id
 t4mr19378096pjo.82.1606023457755; 
 Sat, 21 Nov 2020 21:37:37 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id 22sm9703034pjb.40.2020.11.21.21.37.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2020 21:37:37 -0800 (PST)
Date: Sun, 22 Nov 2020 13:37:27 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Li Guifu <bluce.lee@aliyun.com>, Li Guifu <bluce.liguifu@huawei.com>
Subject: Re: [PATCH] erofs-utils: stop mkfs when access permission denied
Message-ID: <20201122053727.GA2722730@xiangao.remote.csb>
References: <20201122042759.33623-1-bluce.lee@aliyun.com>
MIME-Version: 1.0
In-Reply-To: <20201122042759.33623-1-bluce.lee@aliyun.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hsiangkao@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Guifu,

I'd suggest the following subject...

erofs-utils: stop building tree if file fails to open

On Sun, Nov 22, 2020 at 12:27:59PM +0800, Li Guifu via Linux-erofs wrote:
> It would not has the permission to access one file when mkfs.erofs
> was not run in the root mode, eg run without sudo, So stop and
> exit immediately

stop and exit immediately if it fails to open a file, e.g mkfs.erofs
doesn't run under the root user (e.g. run without sudo.)

> 
> Signed-off-by: Li Guifu <bluce.lee@aliyun.com>
> ---
>  lib/inode.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/inode.c b/lib/inode.c
> index fee5c96..4641561 100644
> --- a/lib/inode.c
> +++ b/lib/inode.c
> @@ -364,6 +364,7 @@ int erofs_write_file(struct erofs_inode *inode)
>  	}
>  
>  	/* fallback to all data uncompressed */
> +	errno = 0;

Why is it necessary, -errno is only used and returned if (fd < 0)

Could you update and resend this?

Thanks,
Gao Xiang

>  	fd = open(inode->i_srcpath, O_RDONLY | O_BINARY);
>  	if (fd < 0)
>  		return -errno;
> @@ -908,7 +909,9 @@ struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
>  			if (ret)
>  				return ERR_PTR(ret);
>  		} else {
> -			erofs_write_file(dir);
> +			ret = erofs_write_file(dir);
> +			if (ret)
> +				return ERR_PTR(ret);
>  		}
>  
>  		erofs_prepare_inode_buffer(dir);
> @@ -982,10 +985,11 @@ struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
>  
>  		d->inode = erofs_mkfs_build_tree_from_path(dir, buf);
>  		if (IS_ERR(d->inode)) {
> +			ret = PTR_ERR(d->inode);
>  fail:
>  			d->inode = NULL;
>  			d->type = EROFS_FT_UNKNOWN;
> -			continue;
> +			goto err_closedir;
>  		}
>  
>  		d->type = erofs_type_by_mode[d->inode->i_mode >> S_SHIFT];
> -- 
> 2.17.1
> 

