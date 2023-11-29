Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5932A7FCE5B
	for <lists+linux-erofs@lfdr.de>; Wed, 29 Nov 2023 06:39:43 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=EM8PRE4Z;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Sg7SD61yNz3cW2
	for <lists+linux-erofs@lfdr.de>; Wed, 29 Nov 2023 16:39:40 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=EM8PRE4Z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::22f; helo=mail-oi1-x22f.google.com; envelope-from=zbestahu@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Sg7S56JmKz3c5j
	for <linux-erofs@lists.ozlabs.org>; Wed, 29 Nov 2023 16:39:32 +1100 (AEDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3b565e35fedso3673725b6e.2
        for <linux-erofs@lists.ozlabs.org>; Tue, 28 Nov 2023 21:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701236369; x=1701841169; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=odzHaB82SZdpybaH4ujfpl6ch16xiqGdapqSSbgzBkI=;
        b=EM8PRE4ZbvWS9VztiLOLxUr06Z5IY1vgK8aNSBRzj1ZnfGAftlnvzq2Ll+lNicKqOp
         iZCO6pqnUKX7dwdHGjaIdou2EldDHbW2UlOqUCvVDiJr/Nu7GRsHzthJrO+5LATU/+dR
         Y1607YDGl+gbpaOC/OOKRlYL1QknPZHuwHXYWG+zNPCXExXTF9Jn/o2ibPUVCJCpS+pw
         z/xYsXtMloYj7JVlpFBF+6rETVKOGLUX21DXOddEV/U7jCb7Czj+OrZyH5ZAQzpx7UzB
         5LQUz94rZLETul85X1cnBzX1AtJO6OkSTXvOhEAwoJA7GQLrCX00VXePCz189bgD1zKq
         enRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701236369; x=1701841169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=odzHaB82SZdpybaH4ujfpl6ch16xiqGdapqSSbgzBkI=;
        b=lvUnw9XPeCHSY5lr6j3txNyJb0PpUlQkdxw2/2Tix3bthZL3oOHvhNlorZKVMOalNe
         WImJFdk0cfnVALS7F9VTGxLWcQXGLJ7y0nLUblPrlUSIXmfTeMmg7m1i9LHHTZU+PXJl
         CoSR3SJXYTz/u6SIE4MI8CWRhf9Yp0wApKrhCQdXnMgcmP1Zt520eBevunB3wvC6NqoR
         G+tFjgq28FMixU5X79MZsKz2IzP2o8Q3VLLSliXmnNiDnwTxKFDds226wMuNJU34819x
         K0WpH+3Lu/Rq36D9wmaoRBGH9R+ATUpu59328xIzISekLhmB+c6g1pEJy6dcqf1KDrYL
         m9Iw==
X-Gm-Message-State: AOJu0Yz//OD7lp0vgvRBGomVWa/MMJP/BgI2ke6oDwu1iy6NUFI3sm7A
	bWcTQHXV4sGg1feDjQcY+Zs=
X-Google-Smtp-Source: AGHT+IGz8aGZVmu36Kmt61oqFIQCLjCV8dVstGF4hdOcUUg0GDOBZZrghen2rAaIuIBCohBpFEg9pg==
X-Received: by 2002:a05:6808:4342:b0:3b8:8db8:d8b5 with SMTP id dx2-20020a056808434200b003b88db8d8b5mr2218303oib.58.1701236368872;
        Tue, 28 Nov 2023 21:39:28 -0800 (PST)
Received: from localhost ([156.236.96.172])
        by smtp.gmail.com with ESMTPSA id e13-20020a631e0d000000b0057c44503835sm10337143pge.65.2023.11.28.21.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 21:39:28 -0800 (PST)
Date: Wed, 29 Nov 2023 13:39:23 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH v2] erofs: fix memory leak on short-lived bounced pages
Message-ID: <20231129133923.00005957.zbestahu@gmail.com>
In-Reply-To: <20231128180431.4116991-1-hsiangkao@linux.alibaba.com>
References: <20231128175810.4105671-1-hsiangkao@linux.alibaba.com>
	<20231128180431.4116991-1-hsiangkao@linux.alibaba.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-w64-mingw32)
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
Cc: huyue2@coolpad.com, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, 29 Nov 2023 02:04:31 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Both MicroLZMA and DEFLATE algorithms can use short-lived pages on
> demand for overlap inplace I/O decompression.
> 
> However, those short-lived pages are actually added to
> `be->compressed_pages`.  Thus, it should be checked instead of
> `pcl->compressed_bvecs`.
> 
> The LZ4 algorithm doesn't work like this, so it won't be impacted.
> 
> Fixes: 67139e36d970 ("erofs: introduce `z_erofs_parse_in_bvecs'")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>
