Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B164CC05E
	for <lists+linux-erofs@lfdr.de>; Thu,  3 Mar 2022 15:51:32 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4K8YpT6CPzz3c21
	for <lists+linux-erofs@lfdr.de>; Fri,  4 Mar 2022 01:51:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=lz7LkVwk;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1031;
 helo=mail-pj1-x1031.google.com; envelope-from=jnhuang95@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=lz7LkVwk; dkim-atps=neutral
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4K8YpL49Xxz3c1P
 for <linux-erofs@lists.ozlabs.org>; Fri,  4 Mar 2022 01:51:20 +1100 (AEDT)
Received: by mail-pj1-x1031.google.com with SMTP id
 15-20020a17090a098f00b001bef0376d5cso5036548pjo.5
 for <linux-erofs@lists.ozlabs.org>; Thu, 03 Mar 2022 06:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:to:cc:references
 :from:in-reply-to:content-transfer-encoding;
 bh=TYSVzCN1QGUzz3L0BI8hYcSC4M46VOUg2My0Kt9v4jI=;
 b=lz7LkVwkoO7crbBGf6zASEuZASdVxET9+AXqQG8S5tDMFOP8OaAJl+AWn3gNEHHOUI
 sCB8VfQilN7reXdr+8RH5o+61pUF6YtqbywC/SU9YWKlHEzUHfhcEsS1gDQvQWIJ1n8j
 yWPdOMuzQrx6ClAH0oDB7+m7/pUEer7AAHmFcYfp4/hNPmTqv9Gvr8L3S9ZTLBzMFtnH
 7eIMrvh/vlhNcy2MeWw36GJ6ynCN1UdMWztuC6ARnS1KSfrlvN9fxS4BsU2yu14LbQ0A
 WiSrbiiSLOLgq9APtLSbjGELpiQYbZz1ioGZROTl3JSo4Tq6XGuWMUoY5qYYhwreOwqt
 JRSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :to:cc:references:from:in-reply-to:content-transfer-encoding;
 bh=TYSVzCN1QGUzz3L0BI8hYcSC4M46VOUg2My0Kt9v4jI=;
 b=4rDdhogehoaCpO3jIS/7OLSx1/N+oSkxZsaragShrugc4QpfpWFoP7RjAIuN2wOPAE
 1KXZRP7/8qF88SMWupiJrluOoHzYltlxwapsVQXFEUx1DvjSxOXibFxCt9Tdcj4XE9mH
 fT5n/WIq1iQe3B5DKCXf/JWq+dDXpOukDkIda2YIWaLgFIHJQttX1pC96btfQSjSntP+
 MYOT6snc0xUSSrAJwp834yNAjw2BncsVHZM5AeHQvTYir2UrW1d/5si08/po5LRPGSTI
 3ph8dnUV2I3uIq043hYKFIFw2NDfeJo0eu7z7nbYmtB6w86QDPsAUbnqNBlZF6LSdJ/l
 COpA==
X-Gm-Message-State: AOAM530lciiYY6H+18ZCVhrVsKwTVnn3dgX4TAiV4SV3AtvTShcOiGpr
 5TBFsCf1Ar9AFoTI1gBlp6o=
X-Google-Smtp-Source: ABdhPJx4kGuWEpKJJkK/QOcdGYqEYe8vL2xI+Ljt0PhD1fKBCksVYPvMLRF2IgFohbWjZ/ZoJg3qYQ==
X-Received: by 2002:a17:90a:5917:b0:1be:d200:2501 with SMTP id
 k23-20020a17090a591700b001bed2002501mr5730561pji.15.1646319079272; 
 Thu, 03 Mar 2022 06:51:19 -0800 (PST)
Received: from [127.0.0.1] ([103.97.175.139]) by smtp.gmail.com with ESMTPSA id
 q13-20020a056a00088d00b004e1bea9c582sm3026128pfj.43.2022.03.03.06.51.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Mar 2022 06:51:18 -0800 (PST)
Message-ID: <a028ed71-b694-2c95-094b-c50551245770@gmail.com>
Date: Thu, 3 Mar 2022 22:51:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v4 0/5] fs/erofs: new filesystem
To: u-boot@lists.denx.de, trini@konsulko.com
References: <20220226070551.9833-1-jnhuang95@gmail.com>
From: Huang Jianan <jnhuang95@gmail.com>
In-Reply-To: <20220226070551.9833-1-jnhuang95@gmail.com>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Tom,

Would you mind taking some time to check if this version meets
the requirements ？So we could have a chance to be merged
into the next version ?

I have triggered a CI via Github PR based on this version :
https://github.com/u-boot/u-boot/pull/133

Thanks，
Jianan

在 2022/2/26 15:05, Huang Jianan 写道:
> Changes since v3:
>   - update tools/docker/Dockerfile;
>
> Changes since v2:
>   - sync up with erofs-utils 1.4;
>   - update lib/lz4 to v1.8.3;
>   - add test for filesystem functions;
>
> Changes since v1:
>   - fix the inconsistency between From and SoB;
>   - add missing license header;
>
> Huang Jianan (5):
>    fs/erofs: add erofs filesystem support
>    lib/lz4: update LZ4 decompressor module
>    fs/erofs: add lz4 decompression support
>    fs/erofs: add filesystem commands
>    test/py: Add tests for the erofs
>
>   MAINTAINERS                         |   9 +
>   cmd/Kconfig                         |   6 +
>   cmd/Makefile                        |   1 +
>   cmd/erofs.c                         |  42 ++
>   configs/sandbox_defconfig           |   1 +
>   fs/Kconfig                          |   2 +
>   fs/Makefile                         |   1 +
>   fs/erofs/Kconfig                    |  21 +
>   fs/erofs/Makefile                   |   9 +
>   fs/erofs/data.c                     | 311 +++++++++++++
>   fs/erofs/decompress.c               |  78 ++++
>   fs/erofs/decompress.h               |  24 +
>   fs/erofs/erofs_fs.h                 | 436 ++++++++++++++++++
>   fs/erofs/fs.c                       | 267 +++++++++++
>   fs/erofs/internal.h                 | 313 +++++++++++++
>   fs/erofs/namei.c                    | 252 +++++++++++
>   fs/erofs/super.c                    | 105 +++++
>   fs/erofs/zmap.c                     | 601 ++++++++++++++++++++++++
>   fs/fs.c                             |  22 +
>   include/erofs.h                     |  19 +
>   include/fs.h                        |   1 +
>   include/u-boot/lz4.h                |  49 ++
>   lib/lz4.c                           | 679 ++++++++++++++++++++--------
>   lib/lz4_wrapper.c                   |  23 +-
>   test/py/tests/test_fs/test_erofs.py | 211 +++++++++
>   tools/docker/Dockerfile             |   1 +
>   26 files changed, 3269 insertions(+), 215 deletions(-)
>   create mode 100644 cmd/erofs.c
>   create mode 100644 fs/erofs/Kconfig
>   create mode 100644 fs/erofs/Makefile
>   create mode 100644 fs/erofs/data.c
>   create mode 100644 fs/erofs/decompress.c
>   create mode 100644 fs/erofs/decompress.h
>   create mode 100644 fs/erofs/erofs_fs.h
>   create mode 100644 fs/erofs/fs.c
>   create mode 100644 fs/erofs/internal.h
>   create mode 100644 fs/erofs/namei.c
>   create mode 100644 fs/erofs/super.c
>   create mode 100644 fs/erofs/zmap.c
>   create mode 100644 include/erofs.h
>   create mode 100644 test/py/tests/test_fs/test_erofs.py
>

