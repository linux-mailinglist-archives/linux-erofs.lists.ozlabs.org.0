Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4AF83E91D
	for <lists+linux-erofs@lfdr.de>; Sat, 27 Jan 2024 02:50:10 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=myzH7Q4f;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TMHZ81Sgfz3c1g
	for <lists+linux-erofs@lfdr.de>; Sat, 27 Jan 2024 12:50:08 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=myzH7Q4f;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::229; helo=mail-oi1-x229.google.com; envelope-from=zbestahu@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TMHZ05vSMz2xWJ
	for <linux-erofs@lists.ozlabs.org>; Sat, 27 Jan 2024 12:49:58 +1100 (AEDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3bd72353d9fso549426b6e.3
        for <linux-erofs@lists.ozlabs.org>; Fri, 26 Jan 2024 17:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706320194; x=1706924994; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WJXuS3ZFCT9vQXXQeSNaeXPTVoMcLrWWgpD8WrejEEE=;
        b=myzH7Q4fq1R9chHFp/bOXbuotS3Qin/PhKVX/F5/4lUS08y9+bFIF1/KpJxk9Grdzu
         j/K//laA1rNhQOwwXPjNQMFzcEQv5GGTdCadBd41OQYks+WhlaiolXihYAIGaJ+Qduda
         0xLqYG7hVNOAoUn7BCk8zPJLXIRThXpEHX7sh7nqroqn8djc28mOg2+qgVyrQTM8TI6g
         59+oZN2SMVJje7W53f42+/rtZkgKEI5q3aE2dbWAa0yNZJbI8AZhrbb+f2ofBx8WZXqL
         zIPOxcCHhxpDD+A4J3GGj6ixA1bI1+oFJp+u5DVDYI5/POH0lo6jK+MMmT8qz59cRuDY
         kdNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706320194; x=1706924994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WJXuS3ZFCT9vQXXQeSNaeXPTVoMcLrWWgpD8WrejEEE=;
        b=s5xBYcIzxvLjGqAhsAKjKVajVjBAwENRoihAXTo8Sj8nMHdUN0IsiibqI8G2gXAs/Z
         CDn9TyhUO+qTErcbs3au2fZfbBILlXYdACeKG5NIyVG9u5gq5mW4OHQKnLwxTJ5dZd7N
         Bao8nucspRjNccwqzBQqM9ZFqdKd9Ic5mBhFo+UUMYlrjmD4TSLUXKFCS/PlOqcpfZmI
         buU7XWv3f7Giu5V33j0fXeZLgSBGOWF7eoZ9gJNboxCBDHXjRXvw+ouXufb5NDKjJcqx
         auSXdri2zqVCYB7zZ+Os/GOiMUXFQ+z88srtVUYMvrINTqG9TxypsLHFVDNcgVl3vaVn
         BRRA==
X-Gm-Message-State: AOJu0Yxw7OvN/LGm7D8JpwKYPX2GwbmU++GuIohiaGAQjtd7gRo2vcTI
	a5ydn0NHPzkZ3Kgmu4+JNpFyvNI4P1Eilz02O91bBNdPT0ftWJMH
X-Google-Smtp-Source: AGHT+IFGvnwjmF0C3gdAh3PRjAZSEAE3+CW0ftwWg+IEhC8FUASoZNpwKtOHudmubC7tTgDD7GF3Ow==
X-Received: by 2002:a54:408d:0:b0:3bd:db8e:b1d8 with SMTP id i13-20020a54408d000000b003bddb8eb1d8mr1060194oii.31.1706320194011;
        Fri, 26 Jan 2024 17:49:54 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV/DCWLVHwsBwzLWWTWXqarQ1zEpRKCVskDt7zJGu+qXSqto1NfpS4PX/ZwBfa5cVwB5d1GnRoqxu4Lp6goOcXiiXwMmMDTYsoomJqyJwSiCiKSlb6RE2DAaKXy+JitmoJSs+g4PQGLc2eiEQ4WUPxv9ybA+nBclJkIAVtSL/q3/UrwfiMF2zQ=
Received: from localhost ([156.236.96.164])
        by smtp.gmail.com with ESMTPSA id l17-20020a635b51000000b005cd64ff9a42sm1747681pgm.64.2024.01.26.17.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 17:49:53 -0800 (PST)
Date: Sat, 27 Jan 2024 09:49:48 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH v4] erofs: relaxed temporary buffers allocation on
 readahead
Message-ID: <20240127094948.000024ad.zbestahu@gmail.com>
In-Reply-To: <20240126140142.201718-1-hsiangkao@linux.alibaba.com>
References: <20240126184656.0000561c.zbestahu@gmail.com>
	<20240126140142.201718-1-hsiangkao@linux.alibaba.com>
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
Cc: Chunhai Guo <guochunhai@vivo.com>, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, 26 Jan 2024 22:01:42 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> From: Chunhai Guo <guochunhai@vivo.com>
> 
> Even with inplace decompression, sometimes very few temporary buffers
> may be still needed for a single decompression shot (e.g. 16 pages for
> 64k sliding window or 4 pages for 16k sliding window).  In low-memory
> scenarios, it would be better to try to allocate with GFP_NOWAIT on
> readahead first.  That can help reduce the time spent on page allocation
> under durative memory pressure.
> 
> Here are detailed performance numbers under multi-app launch benchmark
> workload [1] on ARM64 Android devices (8-core CPU and 8GB of memory)
> running a 5.15 LTS kernel with EROFS of 4k pclusters:
> 
> +----------------------------------------------+
> |      LZ4       | vanilla | patched |  diff   |
> |----------------+---------+---------+---------|
> |  Average (ms)  |  3364   |  2684   | -20.21% | [64k sliding window]
> |----------------+---------+---------+---------|
> |  Average (ms)  |  2079   |  1610   | -22.56% | [16k sliding window]
> +----------------------------------------------+
> 
> The total size of system images for 4k pclusters is almost unchanged:
> (64k sliding window)  9,117,044 KB
> (16k sliding window)  9,113,096 KB
> 
> Therefore, in addition to switch the sliding window from 64k to 16k,
> after applying this patch, it can eventually save 52.14% (3364 -> 1610)
> on average with no memory reservation.  That is particularly useful for
> embedded devices with limited resources.
> 
> [1] https://lore.kernel.org/r/20240109074143.4138783-1-guochunhai@vivo.com
> 
> Suggested-by: Gao Xiang <xiang@kernel.org>
> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>
