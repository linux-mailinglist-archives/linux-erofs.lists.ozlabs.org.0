Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DF33FB6F1
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Aug 2021 15:27:54 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GyrjF6Cddz2yJX
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Aug 2021 23:27:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=LRamHBH9;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::434;
 helo=mail-pf1-x434.google.com; envelope-from=jnhuang95@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=LRamHBH9; dkim-atps=neutral
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Gyrj72q69z2xfN
 for <linux-erofs@lists.ozlabs.org>; Mon, 30 Aug 2021 23:27:38 +1000 (AEST)
Received: by mail-pf1-x434.google.com with SMTP id e16so11777898pfc.6
 for <linux-erofs@lists.ozlabs.org>; Mon, 30 Aug 2021 06:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:date:mime-version:user-agent:subject:to:cc:references
 :from:in-reply-to:content-transfer-encoding;
 bh=WVNWadDK9TQ6N888U3pXNzzssZlTwOWJgvR7zYKPjGc=;
 b=LRamHBH9+AuJBchAFSSYxda65wV2EKG5y9n4BPPBJ3wZ0x+HizD/QhVh8uyLbltaxR
 jLRTCyjUzJChvUiFSCUHw62k0QkN7jtj2DnGvPOeVxf6uiijf5fBGwRSfSzsQ9NVWfHi
 Wc9FJ4RjLKJ4u96EbHz7PVAxj2bwI40PsU9W6z8KfKKuzt7ltcpIy6AhSvfAzRxCubJf
 Xoezkuf4sA+ty2q0bssOkIhWU1Cq55nYUoO2wWVOEG5lfXE1s7UoZP440PHYSa0Q08LD
 xkC+KkdnIaLEziWOgSwQac6XLpQPexLaD2wwtXUq8Zp2xBBmn6poITyBK8hDpUzKR4Qp
 qeSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :to:cc:references:from:in-reply-to:content-transfer-encoding;
 bh=WVNWadDK9TQ6N888U3pXNzzssZlTwOWJgvR7zYKPjGc=;
 b=l8M8UOfLxh7mc7RFIziJmpBYxQH00jBMoPBjAS/U55Vc0Ji3R1KRErohId5+wZCQ1q
 30IdwNajQEbuSNVRZLBz3D59FEJROCtDts0VFrx1f3Xd4xBiDlxygrb/a0yjliZpytf3
 c15DC9hWxqlGTTqi4MV/V/sepZh+bZxajCigR8dpDDTmfaVICsSt8N3x+uXr+1i3xOG4
 0Vi64qLHV3VWJQaj/Yjcu55vlu7h5UJ6bJpuR80RWIq7DwXXrCNMI1YJha+MHl1oSkOh
 7pyaicQtT2FJV6oz2zuBwO79g37aA95nGQo64Dvft6dV+JGH6HaLps1x25E4BSA2gkIu
 VNYw==
X-Gm-Message-State: AOAM530evbXjijJLruJ8MjmR/yr74Z+tZuLz97krs9TezxpoFcXaZbYL
 cSrloArV8BkGl80QWWcv9go=
X-Google-Smtp-Source: ABdhPJy3mgbuikn7E7wALRz9Z8Lv9r0YrDdRwLqw6msxWcp8EuLNPqDz0E8z2aDE9TixPKEu+Y3kPg==
X-Received: by 2002:a63:5445:: with SMTP id e5mr21849317pgm.100.1630330055576; 
 Mon, 30 Aug 2021 06:27:35 -0700 (PDT)
Received: from [0.0.0.0] (li1080-207.members.linode.com. [45.33.61.207])
 by smtp.gmail.com with ESMTPSA id p11sm4604722pfw.203.2021.08.30.06.27.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Aug 2021 06:27:34 -0700 (PDT)
Message-ID: <177141f0-ebbd-017e-ab63-9445b3f53ac1@gmail.com>
Date: Mon, 30 Aug 2021 21:27:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: [PATCH v2 1/3] fs/erofs: add erofs filesystem support
To: Tom Rini <trini@konsulko.com>
References: <20210822154843.10971-1-jnhuang95@gmail.com>
 <20210823123646.9765-1-jnhuang95@gmail.com>
 <20210823123646.9765-2-jnhuang95@gmail.com>
 <20210825223947.GD858@bill-the-cat>
From: Huang Jianan <jnhuang95@gmail.com>
In-Reply-To: <20210825223947.GD858@bill-the-cat>
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
Cc: u-boot@lists.denx.de, xiang@kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



在 2021/8/26 6:39, Tom Rini 写道:
> On Mon, Aug 23, 2021 at 08:36:44PM +0800, Huang Jianan wrote:
>
>> From: Huang Jianan <huangjianan@oppo.com>
>>
>> This patch mainly deals with uncompressed files.
>>
>> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
>> ---
>>   fs/Kconfig          |   1 +
>>   fs/Makefile         |   1 +
>>   fs/erofs/Kconfig    |  12 ++
>>   fs/erofs/Makefile   |   7 +
>>   fs/erofs/data.c     | 124 ++++++++++++++
>>   fs/erofs/erofs_fs.h | 384 ++++++++++++++++++++++++++++++++++++++++++++
>>   fs/erofs/fs.c       | 231 ++++++++++++++++++++++++++
>>   fs/erofs/internal.h | 203 +++++++++++++++++++++++
>>   fs/erofs/namei.c    | 238 +++++++++++++++++++++++++++
>>   fs/erofs/super.c    |  65 ++++++++
>>   fs/fs.c             |  22 +++
>>   include/erofs.h     |  19 +++
>>   include/fs.h        |   1 +
>>   13 files changed, 1308 insertions(+)
>>   create mode 100644 fs/erofs/Kconfig
>>   create mode 100644 fs/erofs/Makefile
>>   create mode 100644 fs/erofs/data.c
>>   create mode 100644 fs/erofs/erofs_fs.h
>>   create mode 100644 fs/erofs/fs.c
>>   create mode 100644 fs/erofs/internal.h
>>   create mode 100644 fs/erofs/namei.c
>>   create mode 100644 fs/erofs/super.c
>>   create mode 100644 include/erofs.h
> Do the style problems checkpatch.pl complains about here match what's in
> the linux kernel?  I expect at lease some of them come from using custom
> debug/etc macros rather than the standard logging functions.  Thanks.

The code is mainly come from erofs-utils, thems it has the same problem, i
will fix it ASAP.

Thanks,
Jianan


