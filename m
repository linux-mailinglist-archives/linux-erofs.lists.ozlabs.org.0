Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D202C63A1
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Nov 2020 12:11:55 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CjBlq4qnBzDrdT
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Nov 2020 22:11:51 +1100 (AEDT)
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
 header.s=mimecast20190719 header.b=g49D35LS; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=g49D35LS; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CjBl21zkszDrdR
 for <linux-erofs@lists.ozlabs.org>; Fri, 27 Nov 2020 22:11:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606475467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9QJt8Qd10UyZmH8t4FnOsVpvkiJL1cAwrPi9/DcbQtk=;
 b=g49D35LSMrxI6CQ08npCrWmc152Hr5nI2OkGxVMpAoHG1UPaftF0hOU4MIpfcN6Xw2celq
 2f+h8OLaVPRPJxLMYnwoN3Qjie7ueI5bzufwlKi9r+8riqdWqosYTPWMr+usWrWJItPMRg
 w8wppA6bAMiBtQcGayJIrOL0IifDVmY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606475467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9QJt8Qd10UyZmH8t4FnOsVpvkiJL1cAwrPi9/DcbQtk=;
 b=g49D35LSMrxI6CQ08npCrWmc152Hr5nI2OkGxVMpAoHG1UPaftF0hOU4MIpfcN6Xw2celq
 2f+h8OLaVPRPJxLMYnwoN3Qjie7ueI5bzufwlKi9r+8riqdWqosYTPWMr+usWrWJItPMRg
 w8wppA6bAMiBtQcGayJIrOL0IifDVmY=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-EdFzyLytNzG4O9o16wUPng-1; Fri, 27 Nov 2020 06:11:05 -0500
X-MC-Unique: EdFzyLytNzG4O9o16wUPng-1
Received: by mail-pf1-f197.google.com with SMTP id q22so3758142pfj.20
 for <linux-erofs@lists.ozlabs.org>; Fri, 27 Nov 2020 03:11:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=9QJt8Qd10UyZmH8t4FnOsVpvkiJL1cAwrPi9/DcbQtk=;
 b=U+pJ3IUCqVz3NbsX3QVHHXYM/8459WufJNkkv286gKMc5k2MGk66Ko6Tmf1dlUVAnq
 WVMeNaDkUs3M0qHCTL2r7kFftkneLDKngbKwchWNQmV8+VYh5LFYB8NuJRNDWnbcrB+I
 8BwdeTNaXZexuYfutxoHwDoIapFVZN/Qc4uAvpQ0BlzrYWv+Q3z2a4VBXxX95R/SMRcB
 Pd49mgAASEOajlOfZgdIYB72OF83voQzWmmdXhiRMAk/CEYBywtFX4cwlETpM0M5Pqz8
 0uIuxfGa4QM2DEzYfy0KDoZGeqCdkQ6TwgNfAC9g+Cp8DuXcL4he9pMLMmJizVM93NE0
 +gBw==
X-Gm-Message-State: AOAM530g0eZA1vaROvaOD41poQvQHocxrAJtpi3TXs9SamHplHnCF7X1
 0oJRxOhfa/EKQm7D31BCqfFZKMJbeu7UTB98f36UFzVUPWZkrZizcSfoyrbBTxRFS95MufArsBq
 OuJoHCDePNBdif9QqdjZQIrZy
X-Received: by 2002:aa7:90d2:0:b029:198:39d8:e5b0 with SMTP id
 k18-20020aa790d20000b029019839d8e5b0mr6744049pfk.1.1606475463630; 
 Fri, 27 Nov 2020 03:11:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyi4T97UdyleRj2qhUtI7cQqGPa7tlxJcNovwwe4lMDD+mp55rnklku0sszLlO+cqngACgHXA==
X-Received: by 2002:aa7:90d2:0:b029:198:39d8:e5b0 with SMTP id
 k18-20020aa790d20000b029019839d8e5b0mr6744027pfk.1.1606475463429; 
 Fri, 27 Nov 2020 03:11:03 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id v18sm6954515pfn.35.2020.11.27.03.11.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2020 03:11:03 -0800 (PST)
Date: Fri, 27 Nov 2020 19:10:53 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Huang Jianan <huangjianan@oppo.com>
Subject: Re: [PATCH v2 1/1] erofs-utils: fix use after free in closedir
Message-ID: <20201127111053.GA615630@xiangao.remote.csb>
References: <20201127110616.34232-1-huangjianan@oppo.com>
MIME-Version: 1.0
In-Reply-To: <20201127110616.34232-1-huangjianan@oppo.com>
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
Cc: liufeibao@oppo.com, guoweichao@oppo.com, linux-erofs@lists.ozlabs.org,
 zhangshiming@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Nov 27, 2020 at 07:06:16PM +0800, Huang Jianan wrote:
> No need to closedir _dir again since it has been released.
> 
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> Signed-off-by: Guo Weichao <guoweichao@oppo.com>

Looks good to me,
Reviewed-by: Gao Xiang <hsiangkao@redhat.com>

Will apply it soon.

Thanks,
Gao Xiang

> ---
>  lib/inode.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/inode.c b/lib/inode.c
> index eb2e0f2..388d21d 100644
> --- a/lib/inode.c
> +++ b/lib/inode.c
> @@ -958,11 +958,11 @@ struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
>  
>  	ret = erofs_prepare_dir_file(dir);
>  	if (ret)
> -		goto err_closedir;
> +		goto err;
>  
>  	ret = erofs_prepare_inode_buffer(dir);
>  	if (ret)
> -		goto err_closedir;
> +		goto err;
>  
>  	if (IS_ROOT(dir))
>  		erofs_fixup_meta_blkaddr(dir);
> @@ -988,7 +988,7 @@ struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
>  fail:
>  			d->inode = NULL;
>  			d->type = EROFS_FT_UNKNOWN;
> -			goto err_closedir;
> +			goto err;
>  		}
>  
>  		d->type = erofs_type_by_mode[d->inode->i_mode >> S_SHIFT];
> @@ -1003,6 +1003,7 @@ fail:
>  
>  err_closedir:
>  	closedir(_dir);
> +err:
>  	return ERR_PTR(ret);
>  }
>  
> -- 
> 2.25.1
> 

