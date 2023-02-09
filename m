Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCAF69008A
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Feb 2023 07:44:04 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PC6lk3klqz3cgV
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Feb 2023 17:44:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=Zh3cJnAD;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::530; helo=mail-pg1-x530.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=Zh3cJnAD;
	dkim-atps=neutral
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PC6ld6w67z2yNs
	for <linux-erofs@lists.ozlabs.org>; Thu,  9 Feb 2023 17:43:57 +1100 (AEDT)
Received: by mail-pg1-x530.google.com with SMTP id v3so960074pgh.4
        for <linux-erofs@lists.ozlabs.org>; Wed, 08 Feb 2023 22:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hs5x5ZXIhdGFgr27gK1Fnt9bHwiJLKk/0eSe/qe4EPs=;
        b=Zh3cJnADwV88ZfVwg11BjlChbhuXKDMUWljHWWwW3PLnA36YyGkK6lKN4cGgNS6s3K
         YiQgKamc9nWJMRtj2rJZf+qd1coYXR9Dy2A/jqnTLQiay+ez9X+L4mp3+Jsoiavqokul
         E7Vli2MqyiPij5nKMCzIBb276Nblog1wB4dLVuCafs/luaj6xOC4necOr5hnNl+XYnmq
         3LEDlHNxOOj9c9+BrRWpi1kUP3abXVz8IiS+st9D5QVkWTyhCfet5HJSBV8uI7bxUmH8
         93XjwLO1lWr9xuD3R6K7CyTccqG7UlTBbeQ6GcAASIE0SvxEG5gaPgRaFOz+5G1bqul9
         iWXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hs5x5ZXIhdGFgr27gK1Fnt9bHwiJLKk/0eSe/qe4EPs=;
        b=ZvXPYL/7noIGy5xY5MaI5z8KT2AnzCTEfpUfpZO9Tbj23825IYe4QWC3GYYSU+8ZjN
         X7XBtin971hWCpj/QoYiE5SqlrsDQZEFPwIH7E6kC9XIlRO1fiHdbxs1o6uNlL7ifpgq
         zO2PeOghMQMwB8gfOvzCi3febWO6FFyXs5cBwAH1GHTJKqxuCYpEhUqPU6kARYFL8cnU
         NVbhcoSJLf3I9tYTXmxIfA9U0FyErHubX3aBJLrjcWqhCNvWoUUBubBu5FHSzzDNHMgK
         DRyeKdgPfrey1UTCVf+XtLI8tVVfflfY1E/mlAvjN5LzeoIaJ9ssImS5KjtLOG9rSQlx
         b04A==
X-Gm-Message-State: AO0yUKU6ZjeHwADm+usQxkbM8PY6RNFw+pYMKzhoYVTytjCj+xnhFpH5
	3dbfPFePPehyfb00syeiCx4=
X-Google-Smtp-Source: AK7set/bLwfODp+rXdNMQ//IstT8odfHG6zlIr7tAOavPqRnwJ9VKzxmO7BmI6As6KbbwsnxbnlCZA==
X-Received: by 2002:a62:19d0:0:b0:5a8:455a:694f with SMTP id 199-20020a6219d0000000b005a8455a694fmr4222900pfz.4.1675925034750;
        Wed, 08 Feb 2023 22:43:54 -0800 (PST)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id x47-20020a056a000bef00b005a817ff3903sm582401pfu.3.2023.02.08.22.43.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Feb 2023 22:43:54 -0800 (PST)
Date: Thu, 9 Feb 2023 14:49:38 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Yangtao Li <frank.li@vivo.com>
Subject: Re: [PATCH] MAINTAINERS: erofs: Add
 Documentation/ABI/testing/sysfs-fs-erofs
Message-ID: <20230209144938.0000408a.zbestahu@gmail.com>
In-Reply-To: <20230209052013.34952-1-frank.li@vivo.com>
References: <20230209052013.34952-1-frank.li@vivo.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: linux-kernel@vger.kernel.org, zhangwen@coolpad.com, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu,  9 Feb 2023 13:20:13 +0800
Yangtao Li <frank.li@vivo.com> wrote:

> Add this doc to the erofs maintainers entry.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d0485b58b9d9..7d50e5df4508 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7745,6 +7745,7 @@ R:	Jeffle Xu <jefflexu@linux.alibaba.com>
>  L:	linux-erofs@lists.ozlabs.org
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git
> +F:	Documentation/ABI/testing/sysfs-fs-erofs
>  F:	Documentation/filesystems/erofs.rst
>  F:	fs/erofs/
>  F:	include/trace/events/erofs.h

