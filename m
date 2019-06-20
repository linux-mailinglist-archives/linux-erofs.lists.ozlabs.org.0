Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 652CE4CB64
	for <lists+linux-erofs@lfdr.de>; Thu, 20 Jun 2019 11:57:08 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45Ty0K6f4mzDr9w
	for <lists+linux-erofs@lfdr.de>; Thu, 20 Jun 2019 19:57:05 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="iB+TVr8s"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45Ty0F2GyVzDr2h
 for <linux-erofs@lists.ozlabs.org>; Thu, 20 Jun 2019 19:57:00 +1000 (AEST)
Received: by mail-pg1-x541.google.com with SMTP id p10so1325246pgn.1
 for <linux-erofs@lists.ozlabs.org>; Thu, 20 Jun 2019 02:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=J75r8rT5GtEIkLzn4Rqcuz1vD78axyidlN0p/ZQEXYQ=;
 b=iB+TVr8sIT4f0xjPy+WtWSrkvv1m7h4l9PRGCW/PCNC4F2mplow9yDR7aPe5+sJgRT
 AiZAq5IEF1+tDU+LMvSeSn02MFmnp3mFmAXlHoq9RYnG7frlbO4S7GQYJ+SWrkUbOXsc
 DJn4REaRV11aDrSovHNeVFEqG7XL3ALxXahd80ycJC1B70GkTg9BdTUSH4RnrS8B3UWK
 3XKgFKew4+yO56KYZXV6XmzCTczIah0D8N+tKUQwa29DnrOS5IwTeRxBnEWsEQtp4GOG
 OLP64PT1DpIjjXRyMvm78jVP7SWbldPYbdWC8nOfDFhGeRgEHAe5P4yBZ/qmVvTjtjOb
 Qh3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=J75r8rT5GtEIkLzn4Rqcuz1vD78axyidlN0p/ZQEXYQ=;
 b=mbA3TDAIwzylyDty3r2jmanWA3jgSQW1T2ZmVZpnDqPC8U1lFgQiDbdQeCZ5enUgSa
 /xbqSPmQcRcJRGfTvjV1pzjQJLicSMPUAYv2bW0G4f7NKKXAePkVPv4BwVliUMoTbadz
 2H4vJ8Zrd1MNeFDpW3KxGGaXURuo8F1YIx3Pe1WcG1tsb6RTsOnAVkJsU0jhiL/ijwQB
 BcGuWgP6iU9Gb22XrxWQJFONQZeCUT9tKiscZogoFLbAHAMEKolbzb1DYp68/ECvCQ+4
 rTb5bR+9rhJjTdMFL/Gso7tw7lKLDjFODePn+nFbUXWoYTqZeh6VsF06MbcJW5Yafos6
 Ca/Q==
X-Gm-Message-State: APjAAAXV7URAx4Bb/L7FzspKZDnZkBj0rzttpuNKbf8R+eK1fishDGdj
 fsWo/JGMfxFCUA94pk9v2+Y=
X-Google-Smtp-Source: APXvYqwIy/StpUk5Fu5qefvKcZlvVjk8GNJPXTD6+JB1RTBrmQTud/mVxScXcc8gIjW8RYXEwFznQw==
X-Received: by 2002:aa7:9786:: with SMTP id o6mr42416750pfp.222.1561024617793; 
 Thu, 20 Jun 2019 02:56:57 -0700 (PDT)
Received: from localhost ([218.189.10.173])
 by smtp.gmail.com with ESMTPSA id i126sm11917462pfb.32.2019.06.20.02.56.55
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 20 Jun 2019 02:56:57 -0700 (PDT)
Date: Thu, 20 Jun 2019 17:56:47 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] staging: erofs: remove needless CONFIG_EROFS_FS_SECURITY
Message-ID: <20190620175647.000025ec.zbestahu@gmail.com>
In-Reply-To: <80310b8c-88fd-5350-71a4-9131b712731a@huawei.com>
References: <20190620083004.2488-1-zbestahu@gmail.com>
 <8a45f678-15cc-be9a-282f-49b251f127a9@huawei.com>
 <fdc23da6-90eb-e3f0-448a-5df1494f4190@huawei.com>
 <20190620172955.00000e7a.zbestahu@gmail.com>
 <80310b8c-88fd-5350-71a4-9131b712731a@huawei.com>
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
Cc: gregkh@linuxfoundation.org, linux-erofs@lists.ozlabs.org, huyue2@yulong.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, 20 Jun 2019 17:52:39 +0800
Chao Yu <yuchao0@huawei.com> wrote:

> On 2019/6/20 17:29, Yue Hu wrote:
> > On Thu, 20 Jun 2019 17:22:48 +0800
> > Chao Yu <yuchao0@huawei.com> wrote:
> >   
> >> On 2019/6/20 16:32, Gao Xiang wrote:  
> >>> Hi Yue,
> >>>
> >>> On 2019/6/20 16:30, Yue Hu wrote:    
> >>>> From: Yue Hu <huyue2@yulong.com>
> >>>>
> >>>> erofs_xattr_security_handler is already marked __maybe_unused, no need
> >>>> to add CONFIG_EROFS_FS_SECURITY condition.    
> >>
> >> CONFIG_EROFS_FS_SECURITY is used as a control switch of erofs security labels
> >> feature, but __maybe_unused is to avoid unneeded compiler warning on unused
> >> variable, so I think we can't remove it.  
> > 
> > However, erofs_xattr_security_handler will not unused under CONFIG_EROFS_FS_SECURITY
> > condition, right?  
> 
> Yes, we will referred it in erofs_xattr_handlers anyway, so, maybe we can remove
> __maybe_unused instead?

It's good to me.

Thx.

> 
> Thanks,
> 
> > 
> > Thx.
> >   
> >>
> >> Thanks,
> >>  
> >>>>
> >>>> Signed-off-by: Yue Hu <huyue2@yulong.com>
> >>>> ---
> >>>>  drivers/staging/erofs/xattr.c | 2 --
> >>>>  1 file changed, 2 deletions(-)
> >>>>
> >>>> diff --git a/drivers/staging/erofs/xattr.c b/drivers/staging/erofs/xattr.c
> >>>> index df40654..06024ac 100644
> >>>> --- a/drivers/staging/erofs/xattr.c
> >>>> +++ b/drivers/staging/erofs/xattr.c
> >>>> @@ -499,13 +499,11 @@ static int erofs_xattr_generic_get(const struct xattr_handler *handler,
> >>>>  	.get	= erofs_xattr_generic_get,
> >>>>  };
> >>>>  
> >>>> -#ifdef CONFIG_EROFS_FS_SECURITY
> >>>>  const struct xattr_handler __maybe_unused erofs_xattr_security_handler = {
> >>>>  	.prefix	= XATTR_SECURITY_PREFIX,
> >>>>  	.flags	= EROFS_XATTR_INDEX_SECURITY,
> >>>>  	.get	= erofs_xattr_generic_get,
> >>>>  };
> >>>> -#endif    
> >>>
> >>> Thanks for your patch.
> >>>
> >>> In that case...erofs_xattr_security_handler could be compiled into .rodata section?
> >>> I am not sure...
> >>>
> >>> Thanks,
> >>> Gao Xiang
> >>>     
> >>>>  
> >>>>  const struct xattr_handler *erofs_xattr_handlers[] = {
> >>>>  	&erofs_xattr_user_handler,
> >>>>    
> >>> .
> >>>     
> > 
> > .
> >   

