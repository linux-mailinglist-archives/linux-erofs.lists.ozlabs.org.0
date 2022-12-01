Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3376E63ECFD
	for <lists+linux-erofs@lfdr.de>; Thu,  1 Dec 2022 10:57:00 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NNBLf0f0Gz3bXK
	for <lists+linux-erofs@lfdr.de>; Thu,  1 Dec 2022 20:56:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=gsrd5EKp;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=gsrd5EKp;
	dkim-atps=neutral
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NNBLX70Vhz30QS
	for <linux-erofs@lists.ozlabs.org>; Thu,  1 Dec 2022 20:56:52 +1100 (AEDT)
Received: by mail-pf1-x430.google.com with SMTP id x66so1397887pfx.3
        for <linux-erofs@lists.ozlabs.org>; Thu, 01 Dec 2022 01:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eqsJUdWwznGqXZHtZVA2Lf6JtI1sIvSq0mnVMZoABzU=;
        b=gsrd5EKpo1Q9NB6hMks9e6ZGYCv1uY68U5vZVd2eFVDz8q7XPgalNkYRTRms1M1Nu1
         LxPS6fDtQlB1/ZFgiAsmdzCLKttKqSPo0mCUohzEzTXGCSBfusrJbLInZ1gI+SerCj6s
         fB9TOiy/g0wszX1Nga30ZozDsydc70/tfH9THTfjAqjFui3cVB0bL3DiWY6UfQebfTzH
         wJnTxpAj+pc4MdbGJGEJ8QdkaTaMdgB33MDAT0hZrrA9sV9c80LYdO925YYOl320V9HE
         Hiz8li0/4LB4bEoVlmUoI13X6SxWyo9CKeMY9qb+zQzaHLWkjUVOyja1b9rYf/0f6X/H
         6T5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eqsJUdWwznGqXZHtZVA2Lf6JtI1sIvSq0mnVMZoABzU=;
        b=N5cXjK1XV/miRVlwLOEsRZ9Pytv6SOuZCKxMjXzjVQk2tofzUQyLUAzhHJi3ifJSKY
         /+qB7tM7YbiCvbwYB1GXm1HNyb1ZzIM6V58JVnzY5vdA2VQW+lbEuI3AEEbX+tDbKf0R
         JKDhxGa7n2jyOzvxhQQfFoW+J+H0BgOsRDUmaPqelSFihcQL6XFzT52DeL2Om9HjfiWv
         j0V8m09XVqI0xy6xY3GJtoMmBPaYjYdSH58GRMZ3viPImos5ehN441zbgP8A89FLqv90
         GW7EkRT2dPso59/7fHSaRvsahNXFCKkFjFe3BeLZSC5hlcQzclNdF1tMIUiLWWiyOxm+
         sVTg==
X-Gm-Message-State: ANoB5pmHRJyXz8P2RR6sHPs2g2mF1+VT3/dX4rCjWzjy6mJhcfxAXeo3
	0tRHn+4D3Cbh1lsD5u4kkng=
X-Google-Smtp-Source: AA0mqf7RghXXlO8gRxDwp+ChtvGd5wJmrCaV36gfvsTBJxWevgcV9b+c8L2dYgEjI8Zhy2pPbdvdsw==
X-Received: by 2002:a63:de4a:0:b0:429:983d:22f8 with SMTP id y10-20020a63de4a000000b00429983d22f8mr38963195pgi.165.1669888610601;
        Thu, 01 Dec 2022 01:56:50 -0800 (PST)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id ik11-20020a170902ab0b00b00178143a728esm3130114plb.275.2022.12.01.01.56.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Dec 2022 01:56:50 -0800 (PST)
Date: Thu, 1 Dec 2022 18:01:02 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH] erofs: update documentation
Message-ID: <20221201180102.000011a4.zbestahu@gmail.com>
In-Reply-To: <20221130095605.4656-1-hsiangkao@linux.alibaba.com>
References: <20221130095605.4656-1-hsiangkao@linux.alibaba.com>
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, 30 Nov 2022 17:56:05 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> - Refine highlights for main features;
> 
> - Add multi-reference pclusters and fragment description.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>

> ---
>  Documentation/filesystems/erofs.rst | 35 ++++++++++++++++++-----------
>  1 file changed, 22 insertions(+), 13 deletions(-)
> 
