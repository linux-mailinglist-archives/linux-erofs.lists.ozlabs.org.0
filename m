Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB9A2D6E2A
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Dec 2020 03:38:08 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CsZhY4c3TzDqpy
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Dec 2020 13:38:05 +1100 (AEDT)
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
 header.s=mimecast20190719 header.b=Y6DQ4cq9; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Y6DQ4cq9; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CsZhR0WshzDqDl
 for <linux-erofs@lists.ozlabs.org>; Fri, 11 Dec 2020 13:37:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607654272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Byp7iZ6NHZQooCnBKYwU+k9x6tIhf8/eUINyICNylzk=;
 b=Y6DQ4cq9HBmYGJ7929CAmSre7d30jwp6aXis8RwEIwicz9kL6XRMikICwp6aNbDi0nqS51
 BGFT/ZjaeJSUQU0/AVwWKYXW/IcMCvEYIuK50V5CnaV6bQPCMX2AP84ZtHXgbpDaw2GWVo
 nCQa8FVu4CReb0SLA1vtEQQI6MPyrBg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607654272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Byp7iZ6NHZQooCnBKYwU+k9x6tIhf8/eUINyICNylzk=;
 b=Y6DQ4cq9HBmYGJ7929CAmSre7d30jwp6aXis8RwEIwicz9kL6XRMikICwp6aNbDi0nqS51
 BGFT/ZjaeJSUQU0/AVwWKYXW/IcMCvEYIuK50V5CnaV6bQPCMX2AP84ZtHXgbpDaw2GWVo
 nCQa8FVu4CReb0SLA1vtEQQI6MPyrBg=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-Og9LnD9NPyCgeuSCuFGt4Q-1; Thu, 10 Dec 2020 21:37:48 -0500
X-MC-Unique: Og9LnD9NPyCgeuSCuFGt4Q-1
Received: by mail-pg1-f198.google.com with SMTP id f19so5491483pgm.4
 for <linux-erofs@lists.ozlabs.org>; Thu, 10 Dec 2020 18:37:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Byp7iZ6NHZQooCnBKYwU+k9x6tIhf8/eUINyICNylzk=;
 b=gQwIn+vHyf49kmBlYAW7MlHu3RBicfokrRHK0n/SB7weU/b7SsX0KdTb/RnnI8e3FK
 4lBuIMiBzOpTlu77LiMIKLe0hXvEe+XCgx0suJr6ZSX4tR1gSMfaf16vfdil9FVEzESg
 yhvzJ708rmxVRfK7HGDZwGJhvBGELlDkrCt/ivchyWS73LMRN5+1CQVaxwUgt0orf4Xn
 U5/ov35p0Qot9ngn7VgGEOW7fDPxViLsnMCi17FZUUsA5KbbbSvCl8pkZWbMqQ5kwdon
 y2bNhinkmc2ZIqm/3v8TwVlEV5LzUMcNZGDqN0EHLtcnZiQc3Nf3BdaIJOx6tldtmUZ2
 LeMw==
X-Gm-Message-State: AOAM530ckJHXPI65prvN9x2roc6ViKg02Zqm3KzHzGfwF0NY7P4KVj1S
 JIcE7dF1OZCQ8cXYAnmaGQL3zR0yMvmAUV7IMpri1/pb7uXJy+vL61BaVYnbaMXCPeVZjPerVaU
 N1+FUBpde3+Mi0ERDTCCs4p8a
X-Received: by 2002:a62:8c97:0:b029:19e:56cc:b025 with SMTP id
 m145-20020a628c970000b029019e56ccb025mr9388927pfd.77.1607654267650; 
 Thu, 10 Dec 2020 18:37:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyEpFhzGaOEJ2OfJtxcxrX8auedS/dfv+KmKV6yXTe17Aw3QOm8PJHCPzsnsXR0VzQiO5CHyA==
X-Received: by 2002:a62:8c97:0:b029:19e:56cc:b025 with SMTP id
 m145-20020a628c970000b029019e56ccb025mr9388910pfd.77.1607654267355; 
 Thu, 10 Dec 2020 18:37:47 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id t131sm7806645pgc.55.2020.12.10.18.37.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Dec 2020 18:37:47 -0800 (PST)
Date: Fri, 11 Dec 2020 10:37:36 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: David Michael <fedora.dm0@gmail.com>
Subject: Re: [PATCH] erofs-utils: fuse: fix linking when using --with-selinux
Message-ID: <20201211023736.GA493797@xiangao.remote.csb>
References: <87360dnkh4.fsf@gmail.com>
MIME-Version: 1.0
In-Reply-To: <87360dnkh4.fsf@gmail.com>
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
Cc: gaoxiang25@huawei.com, miaoxie@huawei.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi David,

On Thu, Dec 10, 2020 at 09:29:43PM -0500, David Michael wrote:
> The libselinux functions selabel_open and selabel_close are called
> by lib/config.c, so include libselinux in CFLAGS and LIBS to fix
> building erofsfuse.
> 
> Signed-off-by: David Michael <fedora.dm0@gmail.com>
> ---
> 
> Hi,
> 
> Trying to build both mkfs.erofs with SELinux and erofsfuse at the same
> time (with both --enable-fuse and --with-selinux) results in the
> following linking errors:
> 
> /usr/bin/ld: ../lib/.libs/liberofs.a(liberofs_la-config.o): in function `erofs_selabel_open':
> /home/dm0/rpmbuild/BUILD/erofs-utils-1.2/lib/config.c:75: undefined reference to `selabel_open'
> /usr/bin/ld: ../lib/.libs/liberofs.a(liberofs_la-config.o): in function `erofs_exit_configure':
> /home/dm0/rpmbuild/BUILD/erofs-utils-1.2/lib/config.c:42: undefined reference to `selabel_close'

Many thanks for your patch! I tested with limited compilation options
before, that is why I'm now worrying about compile error after 1.2 release :(
(I may need to release some 1.2.1 when these build errors are all gone.)

> 
> Are these programs supposed to be configured separately?  If this build
> configuration is supposed to work, this change fixes linking.

It shouldn't supposed to be configured separately, but I'm not sure how
to add them to liberofs as a whole decently (I mean with automake/libtool
infrastructure)... (and there was a trick to staticly build lz4-1.8.x
correctly which should work fine as well :(....)

Thanks,
Gao Xiang

> 
> Thanks.
> 
> David
> 
>  fuse/Makefile.am | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fuse/Makefile.am b/fuse/Makefile.am
> index f14f6fd..e7757bc 100644
> --- a/fuse/Makefile.am
> +++ b/fuse/Makefile.am
> @@ -5,6 +5,6 @@ AUTOMAKE_OPTIONS = foreign
>  bin_PROGRAMS     = erofsfuse
>  erofsfuse_SOURCES = dir.c main.c
>  erofsfuse_CFLAGS = -Wall -Werror -I$(top_srcdir)/include
> -erofsfuse_CFLAGS += -DFUSE_USE_VERSION=26 ${libfuse_CFLAGS}
> -erofsfuse_LDADD = $(top_builddir)/lib/liberofs.la ${libfuse_LIBS} ${liblz4_LIBS}
> +erofsfuse_CFLAGS += -DFUSE_USE_VERSION=26 ${libfuse_CFLAGS} ${libselinux_CFLAGS}
> +erofsfuse_LDADD = $(top_builddir)/lib/liberofs.la ${libfuse_LIBS} ${liblz4_LIBS} ${libselinux_LIBS}
>  
> -- 
> 2.29.2
> 

