Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E42EC3FB903
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Aug 2021 17:31:52 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GyvSQ5mwfz2yJr
	for <lists+linux-erofs@lfdr.de>; Tue, 31 Aug 2021 01:31:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=Q4fs1JiR;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::435;
 helo=mail-pf1-x435.google.com; envelope-from=jnhuang95@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=Q4fs1JiR; dkim-atps=neutral
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GyvSJ0dzkz2xtw
 for <linux-erofs@lists.ozlabs.org>; Tue, 31 Aug 2021 01:31:42 +1000 (AEST)
Received: by mail-pf1-x435.google.com with SMTP id u6so11860682pfi.0
 for <linux-erofs@lists.ozlabs.org>; Mon, 30 Aug 2021 08:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:date:mime-version:user-agent:subject:from:to:cc
 :references:in-reply-to:content-transfer-encoding;
 bh=VzTzh8Z2uUrRLBqxcN/Ur+7QQBWhVdaLmqWS12H8JL0=;
 b=Q4fs1JiR3zFQjWdlTaRy5Y9C2wu4rp2X96GPnZaS8+01+wfnA/lTb85myEl5ogyc9m
 wLRAsQ1j40P/zMod4GPHCfliroesJ0shgiGKhBN30shjujiolSvWa/m18klQnUFgigv5
 p0GOvT6/sz9WGMaoEK2P4sMdYUpW+hsHD/YITWbAnc4BSsMWLdmV3nb1x8X7Gpwa3i0r
 FGFW0stmiOhjcZp5k03UOu86pMO97IZVCN5esIwgw+K0oLgJTO7O1BNODFvUah2eiKWa
 2vxFQ8LEtPaS5yo5E8jYHLBBJaI0JDbNwtCokQzZXFlkHTeyFP28tNH7pqrkosssznR7
 1Axg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :from:to:cc:references:in-reply-to:content-transfer-encoding;
 bh=VzTzh8Z2uUrRLBqxcN/Ur+7QQBWhVdaLmqWS12H8JL0=;
 b=bAQvsYo5dJvu1JLWAvZpDpn04OggR74H/e+fTd1PMmtbSx1sLIwvwzTQIKCYyXvL5+
 gIqQUIpQtj5Ov283E5BV2UVTs4/rcwNSPdilMOXYzkWbnypD5/VtHY8T7zT3kCmVaLuK
 tGb9KOSvudLf8vDZBQBUnAyn30C/xjJW+Q9i1QGTMI2XBlY+lyTCb+9kntnfmmG3i/uL
 8yt2oLpFV2vo5nRY/NNejmmXafOWWb2lUTNzEuY3Fq/VIu1ryYcQkeJKt6xt/E+4EwEJ
 PR+U20y49BiJXcAHyxYbGtxtp+eHbZzzFzx/xmyDlH446HyMOg0MGcFIVAV7gV3kDPjr
 DXGA==
X-Gm-Message-State: AOAM531OfRCeL06A+CQeSlLxzRoK12peR0bZ3YwritLcrbfcm1h7xoJH
 deNpH9W4MY8VSx7Ch5jNBso=
X-Google-Smtp-Source: ABdhPJzInfy5lyhlLnn74TaNBiqpjdciMwjJ7WF0SGlwwp0j3f9glU8gpgInoMgPFHccb06obpxqnQ==
X-Received: by 2002:a63:1c1e:: with SMTP id c30mr12766083pgc.352.1630337497553; 
 Mon, 30 Aug 2021 08:31:37 -0700 (PDT)
Received: from [0.0.0.0] (li1080-207.members.linode.com. [45.33.61.207])
 by smtp.gmail.com with ESMTPSA id l12sm17238417pgc.41.2021.08.30.08.31.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Aug 2021 08:31:36 -0700 (PDT)
Message-ID: <35ce7ab3-a21c-0401-c677-eb2140ea908d@gmail.com>
Date: Mon, 30 Aug 2021 23:31:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: [PATCH v2 1/3] fs/erofs: add erofs filesystem support
From: Huang Jianan <jnhuang95@gmail.com>
To: Tom Rini <trini@konsulko.com>
References: <20210822154843.10971-1-jnhuang95@gmail.com>
 <20210823123646.9765-1-jnhuang95@gmail.com>
 <20210823123646.9765-2-jnhuang95@gmail.com>
 <20210825223947.GD858@bill-the-cat>
 <177141f0-ebbd-017e-ab63-9445b3f53ac1@gmail.com>
In-Reply-To: <177141f0-ebbd-017e-ab63-9445b3f53ac1@gmail.com>
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

在 2021/8/30 21:27, Huang Jianan 写道:
>
>
> 在 2021/8/26 6:39, Tom Rini 写道:
>> On Mon, Aug 23, 2021 at 08:36:44PM +0800, Huang Jianan wrote:
>>
>>> From: Huang Jianan <huangjianan@oppo.com>
>>>
>>> This patch mainly deals with uncompressed files.
>>>
>>> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
>>> ---
>>>   fs/Kconfig          |   1 +
>>>   fs/Makefile         |   1 +
>>>   fs/erofs/Kconfig    |  12 ++
>>>   fs/erofs/Makefile   |   7 +
>>>   fs/erofs/data.c     | 124 ++++++++++++++
>>>   fs/erofs/erofs_fs.h | 384 
>>> ++++++++++++++++++++++++++++++++++++++++++++
>>>   fs/erofs/fs.c       | 231 ++++++++++++++++++++++++++
>>>   fs/erofs/internal.h | 203 +++++++++++++++++++++++
>>>   fs/erofs/namei.c    | 238 +++++++++++++++++++++++++++
>>>   fs/erofs/super.c    |  65 ++++++++
>>>   fs/fs.c             |  22 +++
>>>   include/erofs.h     |  19 +++
>>>   include/fs.h        |   1 +
>>>   13 files changed, 1308 insertions(+)
>>>   create mode 100644 fs/erofs/Kconfig
>>>   create mode 100644 fs/erofs/Makefile
>>>   create mode 100644 fs/erofs/data.c
>>>   create mode 100644 fs/erofs/erofs_fs.h
>>>   create mode 100644 fs/erofs/fs.c
>>>   create mode 100644 fs/erofs/internal.h
>>>   create mode 100644 fs/erofs/namei.c
>>>   create mode 100644 fs/erofs/super.c
>>>   create mode 100644 include/erofs.h
>> Do the style problems checkpatch.pl complains about here match what's in
>> the linux kernel?  I expect at lease some of them come from using custom
>> debug/etc macros rather than the standard logging functions. Thanks.
>
> The code is mainly come from erofs-utils, thems it has the same 
> problem, i
> will fix it ASAP.
>
> Thanks,
> Jianan
>
I have checked checkpatch.pl complains, some need to be fixed, and some
come frome using custom macros. It seems that there are still some warnings
that are inconsistent with the linux kernel, such as :

WARNING: Use 'if (IS_ENABLED(CONFIG...))' instead of '#if or #ifdef' where
possible
#835: FILE: fs/erofs/fs.c:224:
+#ifdef CONFIG_LIB_UUID

WARNING: Possible switch case/default not preceded by break or fallthrough
comment
#763: FILE: fs/erofs/zmap.c:489:
+       case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:

erofs-utils is written according to the linux kernel coding style, I 
expect this
part can be consistent in order to reduce maintenance burden and keep
with the latest feature.

