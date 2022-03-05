Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 950384CE4F3
	for <lists+linux-erofs@lfdr.de>; Sat,  5 Mar 2022 14:06:53 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4K9lNp2rtnz30N1
	for <lists+linux-erofs@lfdr.de>; Sun,  6 Mar 2022 00:06:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=nksxmy5X;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::536;
 helo=mail-pg1-x536.google.com; envelope-from=jnhuang95@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=nksxmy5X; dkim-atps=neutral
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4K9lNg65v6z30Jj
 for <linux-erofs@lists.ozlabs.org>; Sun,  6 Mar 2022 00:06:41 +1100 (AEDT)
Received: by mail-pg1-x536.google.com with SMTP id e6so9786978pgn.2
 for <linux-erofs@lists.ozlabs.org>; Sat, 05 Mar 2022 05:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:to:cc:references
 :from:in-reply-to:content-transfer-encoding;
 bh=5KKhV1ciOS+kd5YVOSjrlY76lvyQL+iwD0geBcFMuQw=;
 b=nksxmy5XU/zU2FhD606cRz4ADS5DAB7xI/9HAGMyFaqUPsGTtg7deu5bVBafSvwDRD
 Im2/x4txveChddX7y+MrZc17djO2E86UEfuYPAq5l12yzKnxRrE6Lu8qvrucpMfP2PhM
 ecCKCeQLSTJU8UXnGvO09v8IHbms66xg7AuXSObM6gW+AF3OELyPXJiM0cpnIySeEjBz
 khE9N7qOBv8h+hWyuqShGZLA4KtA44SdbOOauXyt34kllBvW9BzXHsQB7JS2aY4eGD+t
 rAzAbx6qnjgyjPZQIYXvT6rbRK3Itk6itBf1y10u4ttyVk+7qSppjSFHNeGxt5cCsvqF
 0dUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :to:cc:references:from:in-reply-to:content-transfer-encoding;
 bh=5KKhV1ciOS+kd5YVOSjrlY76lvyQL+iwD0geBcFMuQw=;
 b=whbG0H31xUU1ipjQ1qFiBbV6UQhs0npHzlC7gl57yaNpTQXhoEV/bZB8JABTr8dUTU
 A3nsyW+p4lyZhSZSUiwk9j6Db99MXUfANuNoBcwBAi3rLP3yrHijS0TdGVf8Uu7FNyj1
 FmaUlknvSDhLoh9vFEM87fST+ek/Q3eD+40KEEXlxxnHSWf00yRiq4+XRvVNzfYqkEju
 n9kG2qNshXnlpc3erW8uLfHDjKXj0JdK1d6h7emR4MFey3wNxK0z24/0XJ4TXlVvDfI/
 UR9+6BZ3Vd9RQU0mnIDU4DtC7tg0a5gg3OA23p7oUY8MpjALLbSvJX6rY2WL9D9SptJr
 1oFA==
X-Gm-Message-State: AOAM530ry/Pl5gBJ6/U+3MvAQ30Aojou9ct6QhBBvHrTddPtmMgV+VLV
 pFFBjI1LRLfXq1zUorKTNAk=
X-Google-Smtp-Source: ABdhPJwHgexmUd7hOh6j7UG7FuhWQdOYrJBidhkWnYBj5YclKQTaaz0vOq8mcyXPJQyAgHMGhSwzGw==
X-Received: by 2002:a05:6a00:244f:b0:4df:82ad:447 with SMTP id
 d15-20020a056a00244f00b004df82ad0447mr3785425pfj.49.1646485596544; 
 Sat, 05 Mar 2022 05:06:36 -0800 (PST)
Received: from [127.0.0.1] ([103.97.175.139]) by smtp.gmail.com with ESMTPSA id
 v7-20020a637a07000000b0037c9268a310sm4652225pgc.3.2022.03.05.05.06.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Mar 2022 05:06:36 -0800 (PST)
Message-ID: <3d6e3fb8-1b96-6f45-0aa9-9f330ee71432@gmail.com>
Date: Sat, 5 Mar 2022 21:06:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v4 0/5] fs/erofs: new filesystem
To: Tom Rini <trini@konsulko.com>
References: <20220226070551.9833-1-jnhuang95@gmail.com>
 <a028ed71-b694-2c95-094b-c50551245770@gmail.com>
 <20220303191524.GF5020@bill-the-cat>
From: Huang Jianan <jnhuang95@gmail.com>
In-Reply-To: <20220303191524.GF5020@bill-the-cat>
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
Cc: u-boot@lists.denx.de, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



在 2022/3/4 3:15, Tom Rini 写道:
> On Thu, Mar 03, 2022 at 10:51:18PM +0800, Huang Jianan wrote:
>
>> Hi Tom,
>>
>> Would you mind taking some time to check if this version meets
>> the requirements ？So we could have a chance to be merged
>> into the next version ?
>>
>> I have triggered a CI via Github PR based on this version :
>> https://github.com/u-boot/u-boot/pull/133
> It seems fine, yes.  The thing about that PR is that it doesn't use a
> custom build of the Docker container that also has the tools, so the FS
> tests aren't actually run.  I'll do that when I get to testing and
> applying this, but if you can do that before hand to ensure the tests
> really do run and pass, especially on Azure where things can be a tiny
> bit trickier (since source directory is enforced read-only), that would
> be great.
I verified the test on my own machine, but I overlooked that the container
used in CI is prebuilt ...
I replaced the container in the .azure-pipelines.yml with my own build and
re-triggered the CI on this PR. Now I can see from the log that the newly
added test_erofs is working properly.

Thanks,
Jianan
>> Thanks，
>> Jianan
>>
>> 在 2022/2/26 15:05, Huang Jianan 写道:
>>> Changes since v3:
>>>    - update tools/docker/Dockerfile;
>>>
>>> Changes since v2:
>>>    - sync up with erofs-utils 1.4;
>>>    - update lib/lz4 to v1.8.3;
>>>    - add test for filesystem functions;
>>>
>>> Changes since v1:
>>>    - fix the inconsistency between From and SoB;
>>>    - add missing license header;
>>>
>>> Huang Jianan (5):
>>>     fs/erofs: add erofs filesystem support
>>>     lib/lz4: update LZ4 decompressor module
>>>     fs/erofs: add lz4 decompression support
>>>     fs/erofs: add filesystem commands
>>>     test/py: Add tests for the erofs
>>>
>>>    MAINTAINERS                         |   9 +
>>>    cmd/Kconfig                         |   6 +
>>>    cmd/Makefile                        |   1 +
>>>    cmd/erofs.c                         |  42 ++
>>>    configs/sandbox_defconfig           |   1 +
>>>    fs/Kconfig                          |   2 +
>>>    fs/Makefile                         |   1 +
>>>    fs/erofs/Kconfig                    |  21 +
>>>    fs/erofs/Makefile                   |   9 +
>>>    fs/erofs/data.c                     | 311 +++++++++++++
>>>    fs/erofs/decompress.c               |  78 ++++
>>>    fs/erofs/decompress.h               |  24 +
>>>    fs/erofs/erofs_fs.h                 | 436 ++++++++++++++++++
>>>    fs/erofs/fs.c                       | 267 +++++++++++
>>>    fs/erofs/internal.h                 | 313 +++++++++++++
>>>    fs/erofs/namei.c                    | 252 +++++++++++
>>>    fs/erofs/super.c                    | 105 +++++
>>>    fs/erofs/zmap.c                     | 601 ++++++++++++++++++++++++
>>>    fs/fs.c                             |  22 +
>>>    include/erofs.h                     |  19 +
>>>    include/fs.h                        |   1 +
>>>    include/u-boot/lz4.h                |  49 ++
>>>    lib/lz4.c                           | 679 ++++++++++++++++++++--------
>>>    lib/lz4_wrapper.c                   |  23 +-
>>>    test/py/tests/test_fs/test_erofs.py | 211 +++++++++
>>>    tools/docker/Dockerfile             |   1 +
>>>    26 files changed, 3269 insertions(+), 215 deletions(-)
>>>    create mode 100644 cmd/erofs.c
>>>    create mode 100644 fs/erofs/Kconfig
>>>    create mode 100644 fs/erofs/Makefile
>>>    create mode 100644 fs/erofs/data.c
>>>    create mode 100644 fs/erofs/decompress.c
>>>    create mode 100644 fs/erofs/decompress.h
>>>    create mode 100644 fs/erofs/erofs_fs.h
>>>    create mode 100644 fs/erofs/fs.c
>>>    create mode 100644 fs/erofs/internal.h
>>>    create mode 100644 fs/erofs/namei.c
>>>    create mode 100644 fs/erofs/super.c
>>>    create mode 100644 fs/erofs/zmap.c
>>>    create mode 100644 include/erofs.h
>>>    create mode 100644 test/py/tests/test_fs/test_erofs.py
>>>

