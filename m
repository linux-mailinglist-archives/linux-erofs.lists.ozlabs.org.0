Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id BB18F2FF981
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Jan 2021 01:35:07 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DMKzF0BgJzDrTg
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Jan 2021 11:35:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=63.128.21.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=G9T6jZ5I; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=FdtYEAIe; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DMKyd18k4zDrWX
 for <linux-erofs@lists.ozlabs.org>; Fri, 22 Jan 2021 11:34:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611275669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2k3iQwjsurF66zeEFVvUYiy0lFruuI+K2UHgisCinDI=;
 b=G9T6jZ5Iat+RCUmxglF7quIWRpXkd/OoQYuURv6MEYhbo/2/I1M03g2DC2KZFQXcyDjuWK
 vH1oWaPuWaCQxb5FvI7KuOShPSXDjncKPpDEydWpYF2dzSvnBoosqvkxix3l2DjBMq5VqR
 sYWsp7K+yn+4/KBCJKoGhRjFyvUi/NA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611275670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2k3iQwjsurF66zeEFVvUYiy0lFruuI+K2UHgisCinDI=;
 b=FdtYEAIe9RwbP4k2xyJID0J7jKL6YahIbNC/ShdwFf6hdAo+6ulLu1g04XY7GkXvjPNhbo
 Gbx8mqk9WUeolsqdz7N1BlD7x81dELmJgwSxsC9hyD2DsTltabolw8ktAeJCyInN7InZl8
 yJ4IH48OlTa2SBxUvLEsgFT64sxH7tc=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-LzsGHrhBNtOf-d3d-_Fd-A-1; Thu, 21 Jan 2021 19:34:28 -0500
X-MC-Unique: LzsGHrhBNtOf-d3d-_Fd-A-1
Received: by mail-pj1-f72.google.com with SMTP id hg20so2550129pjb.3
 for <linux-erofs@lists.ozlabs.org>; Thu, 21 Jan 2021 16:34:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=2k3iQwjsurF66zeEFVvUYiy0lFruuI+K2UHgisCinDI=;
 b=AGJJCeIAFMLlykB4s2wDHo0g6mhL/5Wx22uibucpohWdLdFdxoqn8/DsMsNYjvPgXg
 7gjUIeTUQbWbuWIo5mRqi8lDgrj/lo+dq80/F+/krAjgj+I+1/ZTgnmKclky+6kWmZiH
 3/XDGyhgIGgzg/DSrmHSe0feWSAX2y97y8rRC7wu2ULEpZnoknxcR7n1jsee7J6BuaKt
 qSdb53niWhFyyb75T5E3A+/CrbtB2c0sCwy8D9yd5jZ8jXNVKtJBI8/WQzoR+IzXdoRe
 TCBsMB8AnkBc6AcsTSQSBrwGGUFzaflxmcULW8FvagYB+akBfFP5+vOqvmu33inQ3HFX
 wv+Q==
X-Gm-Message-State: AOAM530+cPHnNVXHXj703tm8lM8geG8nDvdiSNcmdtucRL2+n+Bo5sgR
 5tUaSX/fMVWBqOpyMmoY5JaXo5zsfRdaSMpittMa7egfUhisAqmdtp1i4JFv5h5vOzwqt2TWffE
 oW6OjsP0HLJEoSA367UpVVIKt
X-Received: by 2002:aa7:9707:0:b029:19d:c5a8:155e with SMTP id
 a7-20020aa797070000b029019dc5a8155emr2025008pfg.62.1611275666908; 
 Thu, 21 Jan 2021 16:34:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwvs8oh8HzJVZinYSVTZfjUeAo4axs22f1501JZ81ALhfoTgx2I8BiDNlX51FgJZrvrl/zCdA==
X-Received: by 2002:aa7:9707:0:b029:19d:c5a8:155e with SMTP id
 a7-20020aa797070000b029019dc5a8155emr2024983pfg.62.1611275666502; 
 Thu, 21 Jan 2021 16:34:26 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id m8sm7232175pjr.39.2021.01.21.16.34.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Jan 2021 16:34:26 -0800 (PST)
Date: Fri, 22 Jan 2021 08:34:16 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Hu Weiwen <sehuww@mail.scut.edu.cn>
Subject: Re: [PATCH] erofs-utils: fuse: fix random readlink error
Message-ID: <20210122003416.GF2996701@xiangao.remote.csb>
References: <20210121112702.GA2918836@xiangao.remote.csb>
 <20210121163143.9481-1-sehuww@mail.scut.edu.cn>
MIME-Version: 1.0
In-Reply-To: <20210121163143.9481-1-sehuww@mail.scut.edu.cn>
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

Hi Weiwen,

On Fri, Jan 22, 2021 at 12:31:43AM +0800, Hu Weiwen wrote:
> readlink should fill a **null terminated** string in buffer.
> 
> Also, read should return number of bytes remaining on EOF.
> 
> Link: https://lore.kernel.org/linux-erofs/20210121101233.GC6680@DESKTOP-N4CECTO.huww98.cn/
> Signed-off-by: Hu Weiwen <sehuww@mail.scut.edu.cn>

Thanks for catching this!

> ---
>  fuse/main.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/fuse/main.c b/fuse/main.c
> index c162912..bc1e496 100644
> --- a/fuse/main.c
> +++ b/fuse/main.c
> @@ -71,6 +71,12 @@ static int erofsfuse_read(const char *path, char *buffer,
>  	if (ret)
>  		return ret;
>  
> +	if (offset >= vi.i_size)
> +		return 0;
> +
> +	if (offset + size > vi.i_size)
> +		size = vi.i_size - offset;
> +

It would be better to call erofs_pread() with the original offset
and size (also I think there is some missing memset(0) for
!EROFS_MAP_MAPPED), and fix up the return value to the needed value.

Thanks,
Gao Xiang

>  	ret = erofs_pread(&vi, buffer, size, offset);
>  	if (ret)
>  		return ret;
> @@ -79,10 +85,16 @@ static int erofsfuse_read(const char *path, char *buffer,
>  
>  static int erofsfuse_readlink(const char *path, char *buffer, size_t size)
>  {
> -	int ret = erofsfuse_read(path, buffer, size, 0, NULL);
> +	int ret;
> +	size_t path_len;
> +
> +	erofs_dbg("path:%s size=%zd", path, size);
> +	ret = erofsfuse_read(path, buffer, size, 0, NULL);
>  
>  	if (ret < 0)
>  		return ret;
> +	path_len = min(size - 1, (size_t)ret);
> +	buffer[path_len] = '\0';
>  	return 0;
>  }
>  
> -- 
> 2.30.0
> 

