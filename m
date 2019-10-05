Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 121F5CCB16
	for <lists+linux-erofs@lfdr.de>; Sat,  5 Oct 2019 18:26:11 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46lsYp64nzzDqJj
	for <lists+linux-erofs@lfdr.de>; Sun,  6 Oct 2019 03:26:06 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::544; helo=mail-pg1-x544.google.com;
 envelope-from=blucerlee@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="G5XbZVE7"; 
 dkim-atps=neutral
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46lsYg03djzDqH4
 for <linux-erofs@lists.ozlabs.org>; Sun,  6 Oct 2019 03:25:58 +1100 (AEDT)
Received: by mail-pg1-x544.google.com with SMTP id s1so5514581pgv.8
 for <linux-erofs@lists.ozlabs.org>; Sat, 05 Oct 2019 09:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding;
 bh=97yGixhd7I2Jsoh+zOFpzvj+ltv6CJ1GvM8dFk4Kqvs=;
 b=G5XbZVE7KYDpGvp+gGyUKsOP21A9J2tAcmXkPTby/I78DWd/UdD30pfACeZqTrpuXR
 jKK9+Z4FFG4yFpnbF0ZX87m9Im9aSGehrjWrITvRgzlzoxnJZ1iZfEoQ3PlatTMw8g20
 tKAuhueAO9HeN1W0faYinejW13wPntV0+59aA2J1RqGQ3QE/+3KOfC94Z9WbtMDZkme5
 aj1CICAb4NHaWoJbaCe14RKaCrIWgc5D3WYnt3xS0Vwu0YryY5ukpOu7UKt19rsSL811
 370sMyWKUvlWigVw8zNNaYPix/cd+T3MTDDc9uqz1fhZSaLvjPDsXLpMdetB4BxymzpJ
 AfXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding;
 bh=97yGixhd7I2Jsoh+zOFpzvj+ltv6CJ1GvM8dFk4Kqvs=;
 b=X/t+DCVsuUNzXcrpcFAT0iyL5ivLJ8t9dTZWtxY9GIyP4UUoFAXwu5AlSdeCwNGFFc
 S0eB5FknaIAgdFh8d4s7v/xYelcsGV4p3LwDKUO8glS7kBg5cfKBJeATeoz1+xyMsMaG
 zMnqRLPXwshoPcJ60ajTQeR3QYriC6lVvrbZ+wgjPx8wX6gc/9tikgXtCdd6e/tnyDTo
 mWJ2rgKRjO6Ipcr765oTnF2Q84x2otTT3PKhsiC8m57/JpTPatn/MntINkOAPmtMnAoS
 Y2PaUiSVR4HgZgZiXBVeesJ+w2JEPrl4+yC2+aT7DrkJTSMlXXsmSmdiuvqyDdIkTeMi
 arnw==
X-Gm-Message-State: APjAAAXP7RCDtGYyz8V0mdvSAuFKWL9b6aPq08eTxecLGUISfYFQxyNl
 4ivOsMNq5P3VO6lGSHE0P1Q=
X-Google-Smtp-Source: APXvYqy1SGr8u0RjhWiVOlTfvP1iaMxyh9avN3xS7hKbmTfwEmHqmoUWnDOhIce2pgsKRATF6I3LAg==
X-Received: by 2002:a17:90a:7181:: with SMTP id i1mr589731pjk.39.1570292754760; 
 Sat, 05 Oct 2019 09:25:54 -0700 (PDT)
Received: from [0.0.0.0] (li1778-231.members.linode.com. [172.104.187.231])
 by smtp.gmail.com with ESMTPSA id s73sm8488411pjb.15.2019.10.05.09.25.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 05 Oct 2019 09:25:54 -0700 (PDT)
Subject: Re: [PATCH 1/2] erofs-utils: support 64-bit internal buffer cache
To: Gao Xiang <hsiangkao@aol.com>, Li Guifu <bluce.liguifu@huawei.com>,
 linux-erofs@lists.ozlabs.org
References: <20191004204630.22696-1-hsiangkao@aol.com>
From: Li Guifu <blucerlee@gmail.com>
Message-ID: <463b1ab5-2968-04d4-1f91-4549f9119e5b@gmail.com>
Date: Sun, 6 Oct 2019 00:25:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191004204630.22696-1-hsiangkao@aol.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

> From: Gao Xiang <gaoxiang25@huawei.com>
> 
> Previously, the type of off in struct erofs_buffer_head
> is unsigned int, it's not enough for large files.
> 
> Fix to a 64-bit field in order to support large files.
> 
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>

It looks good
Reviewed-by: Li Guifu <blucerlee@gmail.com>
Tested-by: Li Guifu <blucerlee@gmail.com>

Thanks,
