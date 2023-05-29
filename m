Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D64714735
	for <lists+linux-erofs@lfdr.de>; Mon, 29 May 2023 11:42:10 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QV9Xv69PZz3f7h
	for <lists+linux-erofs@lfdr.de>; Mon, 29 May 2023 19:42:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=IZtVbX4j;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=IZtVbX4j;
	dkim-atps=neutral
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QV9Xp1gvCz3cNY
	for <linux-erofs@lists.ozlabs.org>; Mon, 29 May 2023 19:42:01 +1000 (AEST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-64d30ab1f89so2071654b3a.3
        for <linux-erofs@lists.ozlabs.org>; Mon, 29 May 2023 02:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685353318; x=1687945318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ZwleT5IqdSnB0eE2Q5xce5TQ8K2d57jgpMbOyCxpLY=;
        b=IZtVbX4jJlsx2tmnt54Epk31v5BBQwPiFTdN9jPbJqFgiheK7o7BqixtGfVKh5L8lZ
         delKKE0URJsJCw/66VjLngG7R8DseCH2uikm69RT4MLiLnvqvufuTn8f5Oil+FAnG9uh
         cMruROIze+0Dx3IX8nf+VR1gh9BfQtEOgZERBJnONb5yr+IB1X/9KzOQd04zc0o9ZcAm
         DjeddI+Axw0Hfn+uDJQEONKpPQm8QQrEnntY2i0DLRt3sQMahP1En/rJaxRhRk832cv2
         hB+KmSTrHMu04C+K39Axd6JeTUo9mqt/Aemsgj+lswOf0vfmanlHsmn3Ya2UuuUqy9ed
         7lvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685353318; x=1687945318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ZwleT5IqdSnB0eE2Q5xce5TQ8K2d57jgpMbOyCxpLY=;
        b=Q8EFmtwhXOEk40hUdae+N8ZizDM80gfN9c3idHnI0pH1YXM3nbgjsnZIsVekAesuJ3
         KLeOSRgaGMra9wGJfXFbwW0uZRKUN4YzKYbVN/Qyw1db0exMt5LUo/etbfSPshK51Y5s
         xYZ5cevooX6TT/FKirv6NzUt73ZJ/oJrna5CiRStMoYyfH5Bju2JFpKEhIrBSlbb3Opz
         R/tSEw30pzmqUXpoNeuMMfOmCxVyQrIq7pdCcR/08Kzsd+TnYqBOx7/P69dSE7C1j0Ni
         u6fH082HKon8niElHAuJ5Id4g+5NLcGLU7NmgKA2h0kEX0nS0h2CwFe2VcfvXSHaAucI
         /PnQ==
X-Gm-Message-State: AC+VfDwD3P1OSmAi94U1Lz6FbvFkxv6wgRbuACp0+wnnbUWReCyq6U6o
	QH0hTEl4K2qjXvgVWbOqQdfHv3qYMjo=
X-Google-Smtp-Source: ACHHUZ6EsnTgielr6QKFKeMl27FoI7NJAsi6CJKjqr8Sk97EEcee4809r0MkYypHO0LnY2+MTaYQvQ==
X-Received: by 2002:a05:6a20:4306:b0:10b:2ba5:ca66 with SMTP id h6-20020a056a20430600b0010b2ba5ca66mr8726828pzk.20.1685353318327;
        Mon, 29 May 2023 02:41:58 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id i14-20020aa787ce000000b0063b8ce0e860sm6430131pfo.21.2023.05.29.02.41.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 May 2023 02:41:58 -0700 (PDT)
Date: Mon, 29 May 2023 17:50:07 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH 0/6] erofs: random cleanups and fixes
Message-ID: <20230529175007.000007c6.zbestahu@gmail.com>
In-Reply-To: <20230526201459.128169-1-hsiangkao@linux.alibaba.com>
References: <20230526201459.128169-1-hsiangkao@linux.alibaba.com>
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
Cc: huyue2@coolpad.com, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sat, 27 May 2023 04:14:53 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Hi folks,
> 
> These are some cleanups and fixes for the compressed part I'd like to
> aim for the next cycle. I will send several versions if there are more
> patches available.  This ongoing cleanup work are also for later folio
> adaption.
> 
> I've set up a stress test for this patchset at the same time.
> 
> Thanks,
> Gao Xiang
> 
> Gao Xiang (6):
>   erofs: allocate extra bvec pages directly instead of retrying
>   erofs: avoid on-stack pagepool directly passed by arguments
>   erofs: kill hooked chains to avoid loops on deduplicated compressed
>     images
>   erofs: adapt managed inode operations into folios
>   erofs: use struct lockref to replace handcrafted approach
>   erofs: use poison pointer to replace the hard-coded address
> 
>  fs/erofs/internal.h |  41 +-------
>  fs/erofs/super.c    |  62 ------------
>  fs/erofs/utils.c    |  87 ++++++++--------
>  fs/erofs/zdata.c    | 238 ++++++++++++++++++++------------------------
>  4 files changed, 156 insertions(+), 272 deletions(-)
> 

Reviewed-by: Yue Hu <huyue2@coolpad.com>
