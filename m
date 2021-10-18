Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 207154319FF
	for <lists+linux-erofs@lfdr.de>; Mon, 18 Oct 2021 14:48:41 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HXxWV59sRz2yph
	for <lists+linux-erofs@lfdr.de>; Mon, 18 Oct 2021 23:48:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=kOcq7fB2;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::134;
 helo=mail-lf1-x134.google.com; envelope-from=nl6720@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=kOcq7fB2; dkim-atps=neutral
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HXxWM1x29z2yJy
 for <linux-erofs@lists.ozlabs.org>; Mon, 18 Oct 2021 23:48:29 +1100 (AEDT)
Received: by mail-lf1-x134.google.com with SMTP id z11so66080091lfj.4
 for <linux-erofs@lists.ozlabs.org>; Mon, 18 Oct 2021 05:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=j27/9PuBrM2h6jCidIXcM0XPcZSEOdOZr51slj3l+OA=;
 b=kOcq7fB2xG6A7e1gAnhyrcNI0T7wEwJlnn2adoJfagZvVSYkKyBYpbesdsEBRSisza
 SjLJ5Ht7d+/kEDFLWHFFPNI3eJiGMv7lOAFBW/FPSeDqsUE+r3Qjc7D+YowGVUkzwALe
 MmksAPVqWPq856L2m2NgNdsfoms5jMjz8O3AoS4JaONmFsxoCO69/5pGgrk9mCUUL7Wh
 BTEGc0BuD3PNrxWjDJ9ad/ox1OHRCpUGE34yaF6s4zYhNTyoK1QzpixOSo7JDtjr3Ibi
 zMMvKDEjJRXmgtsCzLwIWbYDxZ93pnuhHJNWTBQ+tF3GalgnVOy+r4KfdvFtOJEJYwhu
 b71Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=j27/9PuBrM2h6jCidIXcM0XPcZSEOdOZr51slj3l+OA=;
 b=mXsAqrnUvTtzIwu30Xa8+wsYAhwqziisKD7QgeTnZRFOYeJTNy+HMBwNSOxg+5YKLx
 zed+JyAhz/8g4EhnJFRRlK1ddrpaUZmHRSWAb/yAMNu+LJzx7pIc5Kqhpg+qWaoKsCq7
 rEyQZOBakk5BhD3fL9UJzQ0WhFZ5mgWX3oneAUlXVvZlsGANf2tW+5A+38XKSbZKeNZ8
 ki5g6k9IjbyBqBJl85LY+InXAQ1LRsA2XE7uYOAUEkpIXgka8zzqrEPOgvkw+U0zhklK
 0NqLQCM0f3D06jNHS2fTS9Q7AjB+YKcodmOOdX9z27r8A1FkNycmBL5b/WyTQaw+n3HI
 pP2Q==
X-Gm-Message-State: AOAM533yk3h3TcIWGXsLAOUOJo9qySsEvFO1DtXK1ZKYwcC/BThhV5oE
 JrORICV7NQ3X8pzOyUVQW1ENlWxqG7k=
X-Google-Smtp-Source: ABdhPJyxWeNANsLYtYmJuDJk8YeFBA21nF0pTkcwB15oiZ+ABWOkDTN4GY3O4UFGIwyPpXJwU+Il0A==
X-Received: by 2002:a05:6512:3d91:: with SMTP id
 k17mr16558601lfv.272.1634561298366; 
 Mon, 18 Oct 2021 05:48:18 -0700 (PDT)
Received: from nl6720 (balticom-231-46.balticom.lv. [83.99.231.46])
 by smtp.gmail.com with ESMTPSA id k17sm1385124lfb.233.2021.10.18.05.48.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Oct 2021 05:48:17 -0700 (PDT)
From: nl6720 <nl6720@gmail.com>
To: linux-erofs@lists.ozlabs.org, Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH] erofs-utils: mkfs: introduce --quiet option
Date: Mon, 18 Oct 2021 15:48:16 +0300
Message-ID: <11045556.rbnRpsbqeb@walnut>
In-Reply-To: <YW1luAmReW8HpbHn@B-P7TQMD6M-0146.local>
References: <YW1luAmReW8HpbHn@B-P7TQMD6M-0146.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Monday, 18 October 2021 15:16:56 EEST Gao Xiang wrote:
> Add a preliminary quiet mode as described in
> https://gitlab.archlinux.org/archlinux/archiso/-/issues/148
> 
> Suggested-by: nl6720 <nl6720@gmail.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  lib/config.c |  4 +++-
>  mkfs/main.c  | 25 ++++++++++++++++++++-----
>  2 files changed, 23 insertions(+), 6 deletions(-)

I tried it on top of the experimental branch and it seems to work as intended.
Thanks for working on this!

-- 
nl6720


