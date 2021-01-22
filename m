Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4FB2FF95C
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Jan 2021 01:22:06 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DMKhC28zszDrWR
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Jan 2021 11:22:03 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=63.128.21.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=E2O+/PCi; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=gxNyz3IU; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DMKh55DgTzDrTC
 for <linux-erofs@lists.ozlabs.org>; Fri, 22 Jan 2021 11:21:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611274913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xArGlEBATC4FBMfxUc7lH33aCqS4k4uJUVX7nlXoC/0=;
 b=E2O+/PCixV3D8527WkW/M7Oci3nMmd4/Q0oZQG2vusDe+l5b9K7XqoTi7B+lng5e6jCSFJ
 rczk3pu5waNJOUnu0RD+n0Y6ZkSHbbRnr4jrju/zs//nqqlqX3fB9cUZsoYLD42stZ0cJK
 T/KYkZ4dUmZCdrlUGhu7d4QTx7/FbBc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611274914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xArGlEBATC4FBMfxUc7lH33aCqS4k4uJUVX7nlXoC/0=;
 b=gxNyz3IUEihz7gHHuOuAB1olnFBOBVxR9ZOQMb9Kpl6XbSzcwO7cGvvkkDR/mRqOHhDfrt
 5TZqbCUPYOsXiB3KVXWTnmwi8ZJxGm+UYd0g8WDJDUSoFj5zyx9CazEmr1NvOjnJttJU7y
 e/GpuR5lCinYqr3WiP9MCb0C7zb8/0c=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-4eQR8UDINfap1RM-gkCtNA-1; Thu, 21 Jan 2021 19:21:51 -0500
X-MC-Unique: 4eQR8UDINfap1RM-gkCtNA-1
Received: by mail-pl1-f200.google.com with SMTP id c18so2081585pls.8
 for <linux-erofs@lists.ozlabs.org>; Thu, 21 Jan 2021 16:21:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=xArGlEBATC4FBMfxUc7lH33aCqS4k4uJUVX7nlXoC/0=;
 b=lOCNWLRt5xJuCy7QLsywh60B14fHONwa6kMmm2hxCV7fug5h0IYqA4nnJ8Ovhawgam
 dQCuL50CMu+/PcLBduWI25ORzSmv01KSyka7/aVA4bSqfA2nOpi/cb1ylvJ1tiZ0nG8b
 r1BenJZd6ztyRCB7xtIqn3V7EcAdmyBMalAOXnub53j00Tr6+zP1WQzoOd5a0Ac+nvbM
 n9Dk4eO+cVlCz1Rrho9Kn8ptIN67Qmx8J8lXJBfQ3SLrnWueMThMpxaKWQ6p+JX6qUCG
 4747QJMMqkJeFW5BHZS/Ht7TBB0KJaPiyQeefVN8JIzMbwpVYein1WVCs7ucFRrfEmOm
 tsEg==
X-Gm-Message-State: AOAM530zrzl6kEg/OmQre5YgO/+pszjIMqJqOGMqk7iVuHma5i3H1iL/
 2dHWCdeBNGG1jX+W36DY83Sd1DgplwU4U478R6vxaa4Qo276NvFoxs846tdsP2HGohcGhEoGbYT
 a7FfSlCcadzi90WQCmS5bFE/B
X-Received: by 2002:a63:d418:: with SMTP id a24mr1881965pgh.73.1611274909689; 
 Thu, 21 Jan 2021 16:21:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwRlHutC3RcJijmd4nWigQkpmxC+yiUEmnOSRRE+w5i+MXVbDRglQ848mGWVDPd6WdLAXajRg==
X-Received: by 2002:a63:d418:: with SMTP id a24mr1881955pgh.73.1611274909520; 
 Thu, 21 Jan 2021 16:21:49 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id l2sm5298144pga.65.2021.01.21.16.21.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Jan 2021 16:21:49 -0800 (PST)
Date: Fri, 22 Jan 2021 08:21:39 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Hu Weiwen <sehuww@mail.scut.edu.cn>
Subject: Re: [PATCH 1/7] erofs-utils: tests: fix when lz4 is not enabled
Message-ID: <20210122002139.GE2996701@xiangao.remote.csb>
References: <20210121163715.10660-1-sehuww@mail.scut.edu.cn>
 <20210121163715.10660-2-sehuww@mail.scut.edu.cn>
MIME-Version: 1.0
In-Reply-To: <20210121163715.10660-2-sehuww@mail.scut.edu.cn>
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

On Fri, Jan 22, 2021 at 12:37:09AM +0800, Hu Weiwen wrote:
> Signed-off-by: Hu Weiwen <sehuww@mail.scut.edu.cn>

Generally it can be directly fixed to check_PROGRAMS =...

Otherwise, it looks good to me,
Reviewed-by: Gao Xiang <hsiangkao@aol.com>

Thanks,
Gao Xiang

> ---
>  tests/src/Makefile.am | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/src/Makefile.am b/tests/src/Makefile.am
> index 4959592..ad272d6 100644
> --- a/tests/src/Makefile.am
> +++ b/tests/src/Makefile.am
> @@ -2,11 +2,12 @@
>  # Makefile.am
>  
>  AUTOMAKE_OPTIONS	= foreign
> -noinst_PROGRAMS		= fssum badlz4
> +noinst_PROGRAMS		= fssum
>  
>  fssum_SOURCES = md5.c fssum.c
>  
>  if ENABLE_LZ4
> +noinst_PROGRAMS += badlz4
>  badlz4_SOURCES = badlz4.c
>  badlz4_LDADD = ${liblz4_LIBS}
>  endif
> -- 
> 2.30.0
> 

