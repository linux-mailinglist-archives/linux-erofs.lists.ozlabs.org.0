Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0872C6352
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Nov 2020 11:41:52 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CjB591GRczDrdh
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Nov 2020 21:41:49 +1100 (AEDT)
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
 header.s=mimecast20190719 header.b=CCyffxS/; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=NFMUwBt1; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CjB4z1bplzDrdG
 for <linux-erofs@lists.ozlabs.org>; Fri, 27 Nov 2020 21:41:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606473694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7mXeoada366alTjnqeC2hz06MX8qyQCkP+RNEzU546E=;
 b=CCyffxS/JHSvREUazx7REzpr+3kSmBpZOXiWmnvDdi3wRWeAZmYyFYLi3tT/DzvcUTvR9u
 POMfovon/2CNvGID3pVASYrknAdmdnKRRpf6G2/KEFEuDYSTIR3ct3BlU8RCdKD6J758XM
 NYdlFIK1yzWDXuJWnPBMDyOY0cMfyZE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606473695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7mXeoada366alTjnqeC2hz06MX8qyQCkP+RNEzU546E=;
 b=NFMUwBt14fB2PGLf/q7MIdRn2hDC5sxeiPEq4PHfrgLcncCuzg/tv8jwM59zLjfzKAvJ/b
 79GzRGoMP/xUdkSkKv0dXVj+ev1wrKjzC6FwQGKEHQS8TusqiCOYl/diNsLdh+ktA3SIfG
 cBqwrXwS9m6nc1C8LhYmVBLIZ6gKewM=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-eSwRjmmdNQ6WzTGL5_4H0g-1; Fri, 27 Nov 2020 05:41:32 -0500
X-MC-Unique: eSwRjmmdNQ6WzTGL5_4H0g-1
Received: by mail-pf1-f198.google.com with SMTP id u3so3720448pfm.22
 for <linux-erofs@lists.ozlabs.org>; Fri, 27 Nov 2020 02:41:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=7mXeoada366alTjnqeC2hz06MX8qyQCkP+RNEzU546E=;
 b=ughm/dFdw40OxqSCh4hd/heIB9zBQtKaKc7OTsmsxRINj5WIyPgB+EtPn5UsgmvjQY
 Mcj/exu3oaFKoV41Jc+4C/M1jRhoDX5WmY21yi3OPY7B9HSsB7RUyYRu83BfOquyVPgh
 405cR+EQNGou9sKb3Lp2EPKI7jqR3VeX0YighcFLGL7E19lUSHKsYFp4QDnKr1MdVq3C
 xSfGoqo43vRtWWiPVcc+5vp2KT4bcQUGiw6ADkkKPioNzkR624pSvTzogAhAmXnh7+AF
 YlQd+UkSgpYZ2CZui9uJXscakVit0JYctxG16CgIHaU6oKkIMauI8hNdty7xKvIb7I22
 zRGw==
X-Gm-Message-State: AOAM530P1nPklE/sCa77kFniiluAPbOxhG0FjIYS9Pc/5wiTj/cuEKZa
 +8xPGaQ2WFf876yzoSKtzAuVR7FSdR5NFyV/GzOzzkQ6a2eZv0oabxM7tSxu22YyAV8ESOHeMN9
 gI3uHW/SBPHuxHBFPBNTWVqQ8
X-Received: by 2002:a63:d50a:: with SMTP id c10mr6248487pgg.217.1606473691623; 
 Fri, 27 Nov 2020 02:41:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzqVQGM0b/0YavuyTJOyIZWVx2tXt1fPjfFDSPl07OraDdMal/y++SHBRlCZiThIpQ95vkajA==
X-Received: by 2002:a63:d50a:: with SMTP id c10mr6248466pgg.217.1606473691327; 
 Fri, 27 Nov 2020 02:41:31 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id b29sm7549206pff.194.2020.11.27.02.41.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2020 02:41:30 -0800 (PST)
Date: Fri, 27 Nov 2020 18:41:19 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Huang Jianan <huangjianan@oppo.com>
Subject: Re: [PATCH] erofs-utils: use hash_for_each_safe in erofs_cleanxattrs
Message-ID: <20201127104119.GB598572@xiangao.remote.csb>
References: <20201127101613.33435-1-huangjianan@oppo.com>
MIME-Version: 1.0
In-Reply-To: <20201127101613.33435-1-huangjianan@oppo.com>
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

On Fri, Nov 27, 2020 at 06:16:13PM +0800, Huang Jianan wrote:
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> Signed-off-by: Guo Weichao <guoweichao@oppo.com>

Reviewed-by: Gao Xiang <hsiangkao@redhat.com>

Thanks,
Gao Xiang

> ---
>  lib/xattr.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/xattr.c b/lib/xattr.c
> index f9ec78c..2596601 100644
> --- a/lib/xattr.c
> +++ b/lib/xattr.c
> @@ -506,8 +506,9 @@ static void erofs_cleanxattrs(bool sharedxattrs)
>  {
>  	unsigned int i;
>  	struct xattr_item *item;
> +	struct hlist_node *tmp;
>  
> -	hash_for_each(ea_hashtable, i, item, node) {
> +	hash_for_each_safe(ea_hashtable, i, tmp, item, node) {
>  		if (sharedxattrs && item->shared_xattr_id >= 0)
>  			continue;
>  
> -- 
> 2.25.1
> 

