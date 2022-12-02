Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C31E63FDC4
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Dec 2022 02:43:36 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NNbLt2yG5z3bZQ
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Dec 2022 12:43:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=DG0nXhV5;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=DG0nXhV5;
	dkim-atps=neutral
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NNbLp6p2Rz2yYj
	for <linux-erofs@lists.ozlabs.org>; Fri,  2 Dec 2022 12:43:28 +1100 (AEDT)
Received: by mail-pl1-x636.google.com with SMTP id b21so3331066plc.9
        for <linux-erofs@lists.ozlabs.org>; Thu, 01 Dec 2022 17:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UKPfWRJ85aOFnhit5nLpL7VZ2rqog8fC29KwRe/MXcw=;
        b=DG0nXhV5oOsP5mo9PQCXKazm7HuXPg378nX7XznPHkQ1a1j6j7yu0TdUbj+QO+2AMz
         T8KDpE8RWBPge/y7fxvpjdMkbwSvBbTL+UhQ2U5uW2DcV3Gzn5wKkXzmbtWaw0rE/I5S
         4mYAZK9wDd4xm/xnavuqygTTUSoRXv+Fb5A9fyaPgaRt50oVmTBewf+XAXcecF8oTMnA
         vsnsjLmedbRm9xh/J0fvwWuSYpdID0oFPYgs+bGPMfc8ikg3D8His68vGJH1yB0RYkx4
         NQZqCdeWXpZMiv1MgVxOH5wFnL/5KmfkFwLH8tS8mZZNoPtZBrg0DlhFJQWjeuAveEBV
         QmYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UKPfWRJ85aOFnhit5nLpL7VZ2rqog8fC29KwRe/MXcw=;
        b=nFEntQbz/tIbfhcY2vf3Zl9rQUETdCUqMw2zeYMzjuldRPs9NIra6C9/pEMi6kx8dg
         UqupoLZbEwq17kRdjpy4lo7Vp/KPOAcTExX1FwfqWgvME49pYC4/4equx0dML0otj0C2
         O3Nnzim9B0j2SWZI2Ysxvn1hJGBOPyj6UDSEsih2qbbUfaGcRqX0aycpW4rKLN/OojMc
         HeXuzsTsPXqhNaYGmV3KHOIzxynba2T4GXh88I5x/41WzBSeQpbAFnbq82jHLhm/SJsE
         6X4gjbI82ZPgAIRG8WUP8gx37jwwA14hEX7hZFhd6YMMOy7i7Uuiu+cJ3iXo3IoCkqUM
         BHYA==
X-Gm-Message-State: ANoB5pn8+vG5fltQH52kceXJak588QbjIx/MzjKaY+uRxdAF5yBFIO4T
	6QLB+6YoJsPO5KaZJtoFZHAni6az04M4kg==
X-Google-Smtp-Source: AA0mqf5pEAEMDEC6TcmOq5KUqL4TbLPxH1c2ffujoXC+GrnC8zF+8wn1Tkhh6oaNeyAaGw/8ULtCNA==
X-Received: by 2002:a17:90b:3d84:b0:213:f8a9:fd49 with SMTP id pq4-20020a17090b3d8400b00213f8a9fd49mr72840409pjb.73.1669945405124;
        Thu, 01 Dec 2022 17:43:25 -0800 (PST)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id 188-20020a6304c5000000b00477bfac06b7sm3114291pge.34.2022.12.01.17.43.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Dec 2022 17:43:24 -0800 (PST)
Date: Fri, 2 Dec 2022 09:47:37 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH] erofs: clean up cached I/O strategies
Message-ID: <20221202094737.00000c92.zbestahu@gmail.com>
In-Reply-To: <20221201033119.101682-1-hsiangkao@linux.alibaba.com>
References: <20221201033119.101682-1-hsiangkao@linux.alibaba.com>
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
Cc: linux-erofs@lists.ozlabs.org, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu,  1 Dec 2022 11:31:19 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> After commit 4c7e42552b3a ("erofs: remove useless cache strategy of
> DELAYEDALLOC"), only one cached I/O allocation strategy is supported:
> 
>   When cached I/O is preferred, page allocation is applied without
>   direct reclaim.  If allocation fails, fall back to inplace I/O.
> 
> Let's get rid of z_erofs_cache_alloctype.  No logical changes.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>

> ---
>  fs/erofs/zdata.c | 65 +++++++++++++++++++-----------------------------
>  1 file changed, 25 insertions(+), 40 deletions(-)
