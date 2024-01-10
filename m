Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9BC829A27
	for <lists+linux-erofs@lfdr.de>; Wed, 10 Jan 2024 13:06:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1704888374;
	bh=l8cKztzv2ZktLOe0dzMuixqOyjC0S8dozIynxhbNLCA=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=BO6mXP+dBBfobg7Tt4yjTL+FQYIoEvlLaa+OJBR//Pm65/BA9fh2s0KbMPfKA9jZl
	 oB0yqz4TYeo6yKfGsJ0q46OFYkr0XZVInR1GDAC0jdGjLOAe420qd309LCrNVoDiTX
	 jJfXF4LUAbDHizQ6aUxrjgSbmLApmX8id/jTVICMBWTMvZr83OxHIMxEK66vSRev0v
	 05QssHUOZGT6kgvg+W9vGHVNZxKkpz6xdxkrmhaFBQXO0OIstieQG3IZG+GQpa5+r9
	 wGOKKlPQlsPijmXuNRtf3+qmxMPe4lUUGitoHDl2jjXn6NDMXfTMK5xuI9gcxmI048
	 aKudezJQF65VQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4T962t67M9z3bnk
	for <lists+linux-erofs@lfdr.de>; Wed, 10 Jan 2024 23:06:14 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Zu8sFLuv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::436; helo=mail-pf1-x436.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4T962n06ygz2yRS
	for <linux-erofs@lists.ozlabs.org>; Wed, 10 Jan 2024 23:06:07 +1100 (AEDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6d9bbf71bc8so2018238b3a.1
        for <linux-erofs@lists.ozlabs.org>; Wed, 10 Jan 2024 04:06:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704888363; x=1705493163;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l8cKztzv2ZktLOe0dzMuixqOyjC0S8dozIynxhbNLCA=;
        b=dBLwuWPK/WE9FCbZU1z9mYep87e/Luu8VZJ+Oy/D/pSwJGcCmNxhiNF/VoWlYpUzLH
         zJMm48Apt11lH/IVyJ8K4aJusqbhibwk9owbvJwhKdphJrd2JShWiWFpnBH9+qqHQK4X
         8l2qVpFTpBens9jVwxjDrKuXtosXqFS0Yn4WxF/kr3btVsFz9Ny8aj/lU6C0x4QcNN6I
         Tcd1hvLugejipp+Qby1sO08Vn6UXGA3yUhPBveEr4y1mZAwv3tSyO18W8W8xxogm95iI
         hNLG+efj2vDcd/brqOO0SO5jaF8OmsKkKy5BFv6RafUYrztzbHjXikRy5Q99USysmknW
         E23g==
X-Gm-Message-State: AOJu0YyvVuOFLnbKmUCxali09XhSsFECJsz0Y1Oe9OFAbjgOHoN3O4GA
	dYRYQKDIvu2fWGy//tCJnP91aPP4IAk+6A==
X-Google-Smtp-Source: AGHT+IFsVj/4XzAFKalFZR2COx2846rqnoRx+GhgwtyxD4J0CYsNkiv/V9CNEvpVyo59dEDH4l9dyw==
X-Received: by 2002:a05:6a00:3204:b0:6da:63a5:3f32 with SMTP id bm4-20020a056a00320400b006da63a53f32mr612723pfb.66.1704888362874;
        Wed, 10 Jan 2024 04:06:02 -0800 (PST)
Received: from [10.255.187.86] ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id i128-20020a625486000000b006d99056c4edsm3470845pfb.187.2024.01.10.04.05.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 04:06:02 -0800 (PST)
Message-ID: <abcc18ec-4006-4c51-96a8-e61d0ec2f092@bytedance.com>
Date: Wed, 10 Jan 2024 20:05:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] [PATCH 5/6] cachefiles: Fix signed/unsigned mixup
To: David Howells <dhowells@redhat.com>,
 Christian Brauner <christian@brauner.io>, Jeff Layton <jlayton@kernel.org>,
 Gao Xiang <hsiangkao@linux.alibaba.com>,
 Dominique Martinet <asmadeus@codewreck.org>
References: <20240109112029.1572463-1-dhowells@redhat.com>
 <20240109112029.1572463-6-dhowells@redhat.com>
In-Reply-To: <20240109112029.1572463-6-dhowells@redhat.com>
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
From: Jia Zhu via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Jia Zhu <zhujia.zj@bytedance.com>
Cc: linux-mm@kvack.org, Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, kernel test robot <lkp@intel.com>, Matthew Wilcox <willy@infradead.org>, Steve French <smfrench@gmail.com>, linux-cachefs@redhat.com, Ilya Dryomov <idryomov@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, ceph-devel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, Yiqun Leng <yqleng@linux.alibaba.com>, Simon Horman <horms@kernel.org>, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Tested-by: Jia Zhu <zhujia.zj@bytedance.com>

在 2024/1/9 19:20, David Howells 写道:
> In __cachefiles_prepare_write(), the start and pos variables were made
> unsigned 64-bit so that the casts in the checking could be got rid of -
> which should be fine since absolute file offsets can't be negative, except
> that an error code may be obtained from vfs_llseek(), which *would* be
> negative.  This breaks the error check.
> 
> Fix this for now by reverting pos and start to be signed and putting back
> the casts.  Unfortunately, the error value checks cannot be replaced with
> IS_ERR_VALUE() as long might be 32-bits.
> 
> Fixes: 7097c96411d2 ("cachefiles: Fix __cachefiles_prepare_write()")
> Reported-by: Simon Horman <horms@kernel.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202401071152.DbKqMQMu-lkp@intel.com/
> Signed-off-by: David Howells <dhowells@redhat.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> cc: Gao Xiang <hsiangkao@linux.alibaba.com>
> cc: Yiqun Leng <yqleng@linux.alibaba.com>
> cc: Jia Zhu <zhujia.zj@bytedance.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: linux-cachefs@redhat.com
> cc: linux-erofs@lists.ozlabs.org
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-mm@kvack.org
> ---
>   fs/cachefiles/io.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
> index 3eec26967437..9a2cb2868e90 100644
> --- a/fs/cachefiles/io.c
> +++ b/fs/cachefiles/io.c
> @@ -522,7 +522,7 @@ int __cachefiles_prepare_write(struct cachefiles_object *object,
>   			       bool no_space_allocated_yet)
>   {
>   	struct cachefiles_cache *cache = object->volume->cache;
> -	unsigned long long start = *_start, pos;
> +	loff_t start = *_start, pos;
>   	size_t len = *_len;
>   	int ret;
>   
> @@ -556,7 +556,7 @@ int __cachefiles_prepare_write(struct cachefiles_object *object,
>   					  cachefiles_trace_seek_error);
>   		return pos;
>   	}
> -	if (pos >= start + *_len)
> +	if ((u64)pos >= (u64)start + *_len)
>   		goto check_space; /* Unallocated region */
>   
>   	/* We have a block that's at least partially filled - if we're low on
> @@ -575,7 +575,7 @@ int __cachefiles_prepare_write(struct cachefiles_object *object,
>   					  cachefiles_trace_seek_error);
>   		return pos;
>   	}
> -	if (pos >= start + *_len)
> +	if ((u64)pos >= (u64)start + *_len)
>   		return 0; /* Fully allocated */
>   
>   	/* Partially allocated, but insufficient space: cull. */
> 
