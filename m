Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D393FB6F4
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Aug 2021 15:31:05 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Gyrn32Srzz2yJZ
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Aug 2021 23:31:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=ATuYWgrP;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102f;
 helo=mail-pj1-x102f.google.com; envelope-from=jnhuang95@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=ATuYWgrP; dkim-atps=neutral
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Gyrmz6vDdz2xXR
 for <linux-erofs@lists.ozlabs.org>; Mon, 30 Aug 2021 23:30:58 +1000 (AEST)
Received: by mail-pj1-x102f.google.com with SMTP id j1so9485993pjv.3
 for <linux-erofs@lists.ozlabs.org>; Mon, 30 Aug 2021 06:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:date:mime-version:user-agent:subject:to:cc:references
 :from:in-reply-to:content-transfer-encoding;
 bh=OSV/KBx2J/8Ycjw82PdbYn61gJLvgM47Y/BHb60ZPtY=;
 b=ATuYWgrP1U0LIu5FqRxFZKuUG5X49XDCvje9ImXEaaEXl+BSIqPEoORl7okv06UKZu
 78IoN1uFVsOkyvrl7q8jWP4n5SWEOvstGre3q47sS98hSHQuajjYmOIfxU3V8YNRpZMS
 H8tUDonCyKM3v1LKCM+b3Iw2CRGwJkwb8mqy6hcX7SR8sJxsW5wXh8UAkDEo6mzbsO8Z
 8e9VUPv/MDOpB077dyVR59DF30OYPyGrTKXtefzrFbgzAg4dlUJxzDks8+i/MIAfH4g6
 NgZxX/07Tt/WPq90qr4HvADrgS3bhQRjJtNlNRVJ2YROvD7YDz2XMPlgP3wPh8BTYxTQ
 ie8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :to:cc:references:from:in-reply-to:content-transfer-encoding;
 bh=OSV/KBx2J/8Ycjw82PdbYn61gJLvgM47Y/BHb60ZPtY=;
 b=HvxG7SU5EOdU6E+5kwD59XXdmXjOIsOp6iPWv160ccfZnfjQpeNxcKcTYBVMvA6qEu
 QlxZU2Tr8qQWfU4s4IgK3mkaTx9E9dxidkdNFOqf54R38MVDSisTe06G+G1b5PHAMLSW
 NyN7CqAu3p7YDCJt27ivT2ebZDtGjV7isFunuypDeN5XBSfRzkOkTS8WjDKxL35skmCW
 LxelKveH9VX+j/AcW7w50bJF/P8DuWAbamW9+/hbkyV1wUPslpB8bjkW/hT9uyoSIgN6
 T8Pqqto4OTsF63q78F46caqGYi/cYE3pDb4Mg5C0GNaPVwksDIbKONLso1JIXnnfb3l2
 ovcg==
X-Gm-Message-State: AOAM530a6A55XE/5VMVwDJQZztfUSRv0jdU8MbThM56QuQH1/pFpc3iX
 v46DE7lpS8NXyTG+612eHj8=
X-Google-Smtp-Source: ABdhPJwsbtDUWvgyQ6UXRITJ9ju26WNac07vH+ARSSnwXmIhPZhx5Ppq2+M+V610r2uwbE0WAIaZEQ==
X-Received: by 2002:a17:902:7049:b0:131:bdef:522d with SMTP id
 h9-20020a170902704900b00131bdef522dmr21952846plt.85.1630330255494; 
 Mon, 30 Aug 2021 06:30:55 -0700 (PDT)
Received: from [0.0.0.0] (li1080-207.members.linode.com. [45.33.61.207])
 by smtp.gmail.com with ESMTPSA id o14sm36552pjp.1.2021.08.30.06.30.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Aug 2021 06:30:54 -0700 (PDT)
Message-ID: <e0c1dc62-ffc6-5fd8-e6d2-82f0f2f0caba@gmail.com>
Date: Mon, 30 Aug 2021 21:30:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: [PATCH v2 2/3] fs/erofs: add lz4 1.8.3 decompressor
To: Tom Rini <trini@konsulko.com>
References: <20210822154843.10971-1-jnhuang95@gmail.com>
 <20210823123646.9765-1-jnhuang95@gmail.com>
 <20210823123646.9765-3-jnhuang95@gmail.com>
 <20210825223953.GE858@bill-the-cat>
From: Huang Jianan <jnhuang95@gmail.com>
In-Reply-To: <20210825223953.GE858@bill-the-cat>
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
> On Mon, Aug 23, 2021 at 08:36:45PM +0800, Huang Jianan wrote:
>
>> From: Huang Jianan <huangjianan@oppo.com>
>>
>> In order to use the newest LZ4_decompress_safe_partial() which can
>> now decode exactly the nb of bytes requested.
>>
>> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
>> ---
>>   fs/erofs/Makefile |   3 +-
>>   fs/erofs/lz4.c    | 534 ++++++++++++++++++++++++++++++++++++++++++++++
>>   fs/erofs/lz4.h    |   5 +
>>   3 files changed, 541 insertions(+), 1 deletion(-)
>>   create mode 100644 fs/erofs/lz4.c
>>   create mode 100644 fs/erofs/lz4.h
> Why not use the existing lz4 support, or if it needs updating for new
> features, update it?
erofs use lz4 partial decompress, this feature is fully supported after 
lz4 1.8.3,
I will try to upgrade the existing one.

Thanks,
Jianan

