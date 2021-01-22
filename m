Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id C12C12FFA41
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Jan 2021 03:00:40 +0100 (CET)
Received: from bilbo.ozlabs.org (unknown [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DMMsy05tdzDrWk
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Jan 2021 13:00:38 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=216.205.24.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=R9u+5u1i; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=R9u+5u1i; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DMMsg1MR9zDrTP
 for <linux-erofs@lists.ozlabs.org>; Fri, 22 Jan 2021 13:00:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611280819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UXqPRyFGzT0VT8KEhWhVH2cp/CZ+lAiAhRDxiARo/ps=;
 b=R9u+5u1i3rSQ40DAHC/pbtc6HdidZITcvA4bFjzqywZPRAJQSbxlVYlSnMSr5sZsm5qxHa
 qjSYQrQgiZXLunz9+RZYQk+BIKl9PdnT5VZAPjIBo4puD9+z4vGeBXSLCGl1CTA/Fx5P3A
 c7vsmEpNZTyeJQ5valzxtigJMYfKDYE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611280819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UXqPRyFGzT0VT8KEhWhVH2cp/CZ+lAiAhRDxiARo/ps=;
 b=R9u+5u1i3rSQ40DAHC/pbtc6HdidZITcvA4bFjzqywZPRAJQSbxlVYlSnMSr5sZsm5qxHa
 qjSYQrQgiZXLunz9+RZYQk+BIKl9PdnT5VZAPjIBo4puD9+z4vGeBXSLCGl1CTA/Fx5P3A
 c7vsmEpNZTyeJQ5valzxtigJMYfKDYE=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293--iDqrnV8MyeXHfu3X1xysw-1; Thu, 21 Jan 2021 21:00:16 -0500
X-MC-Unique: -iDqrnV8MyeXHfu3X1xysw-1
Received: by mail-pj1-f70.google.com with SMTP id t10so2941459pjw.4
 for <linux-erofs@lists.ozlabs.org>; Thu, 21 Jan 2021 18:00:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=UXqPRyFGzT0VT8KEhWhVH2cp/CZ+lAiAhRDxiARo/ps=;
 b=hUaTADU6CbSe8AdpVBKlC0xzfnH0Fbnf30ZRB9YyE9EPWnyjdiPjxk2ChIJg0Z7Gf7
 mUZzWMP+MYTcApKk/Wo08hXeeg3yFfKmNvHwq2h31V0hvt6BFcD+xdIG0gxWY0MQpGPI
 KpPHxHYtnbh8D+Ik9mJ7mwKJDmdtO1O8kL9+rFagAlGNJTB6DI2Nn59ritAXKlNhtUfA
 cpMlTqCuc43xg0hToefRpH6S8mnkeloP7RWGhOYaXd9+3+XvM18Obzz37KgfPRTO4PrB
 ldIg0gdejY0AOEaGbEva+mIwDuYONdBAc6iaNNBH93KHBby5gWWGaVV4h+bTxwDA43UY
 /g6g==
X-Gm-Message-State: AOAM533+wMdlJJh9TX440t8oqX5XxWyVuLUv7fvQOGQXTOHSQCwYn2RO
 hU27wB5/POCdf2lpsaEovwfao+vrglVFlxaOy80SVPtYwLUuRpff6ego3CmdkUYoitk7pxv5lWe
 upyYhlJOEh/n1lWBKXBZk0Q/W
X-Received: by 2002:aa7:8d12:0:b029:1ae:4344:3b4f with SMTP id
 j18-20020aa78d120000b02901ae43443b4fmr2397573pfe.16.1611280815542; 
 Thu, 21 Jan 2021 18:00:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwas35oLmYF/dlQHAKUcHa5FR9RzNxRWKg8xY0YifOSdKJebAvmkmng4j3MAaMtIloWKFBYjg==
X-Received: by 2002:aa7:8d12:0:b029:1ae:4344:3b4f with SMTP id
 j18-20020aa78d120000b02901ae43443b4fmr2397504pfe.16.1611280814784; 
 Thu, 21 Jan 2021 18:00:14 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id j17sm6475519pfh.183.2021.01.21.18.00.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Jan 2021 18:00:14 -0800 (PST)
Date: Fri, 22 Jan 2021 10:00:04 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Hu Weiwen <sehuww@mail.scut.edu.cn>
Subject: Re: [PATCH v3] erofs-utils: fix memory leak when erofs_fill_inode()
 fails
Message-ID: <20210122020004.GC2918836@xiangao.remote.csb>
References: <20210119153620.GA2601261@xiangao.remote.csb>
 <20210121162101.7093-1-sehuww@mail.scut.edu.cn>
MIME-Version: 1.0
In-Reply-To: <20210121162101.7093-1-sehuww@mail.scut.edu.cn>
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

On Fri, Jan 22, 2021 at 12:21:01AM +0800, Hu Weiwen wrote:
> Signed-off-by: Hu Weiwen <sehuww@mail.scut.edu.cn>

Reviewed-by: Gao Xiang <hsiangkao@aol.com>

Thanks,
Gao Xiang

> ---
>  lib/inode.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/inode.c b/lib/inode.c
> index d6a64cc..73a7e69 100644
> --- a/lib/inode.c
> +++ b/lib/inode.c
> @@ -867,8 +867,10 @@ struct erofs_inode *erofs_iget_from_path(const char *path, bool is_src)
>  		return inode;
>  
>  	ret = erofs_fill_inode(inode, &st, path);
> -	if (ret)
> +	if (ret) {
> +		free(inode);
>  		return ERR_PTR(ret);
> +	}
>  
>  	return inode;
>  }
> -- 
> 2.30.0
> 

