Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDF6325C2
	for <lists+linux-erofs@lfdr.de>; Mon,  3 Jun 2019 02:41:14 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45HGSl4YpSzDqMw
	for <lists+linux-erofs@lfdr.de>; Mon,  3 Jun 2019 10:41:11 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="l+ISS5Kh"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45HGSd6BSWzDqMg
 for <linux-erofs@lists.ozlabs.org>; Mon,  3 Jun 2019 10:41:05 +1000 (AEST)
Received: by mail-pf1-x442.google.com with SMTP id t16so736635pfe.11
 for <linux-erofs@lists.ozlabs.org>; Sun, 02 Jun 2019 17:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rdSWglbmV33o90cfT5RR14PiSy81XzIFQtZlDfbIjfA=;
 b=l+ISS5KhoUi07pvqa/TdOCYHxyZ2WgPo8E+ZTddA4ojTN8JtlMemrKO5u8Oa1QWedp
 bizW+v3XupRCXAh7yKIvb2LqRhei2gJ2CDIatpnAK3wg5TdwpXQNB1DfWpMwQLVZABJu
 8r2+qXKp/5FLJcV1H0xTbpT/DFoiraYesmKty1BvWo3dRdwYR2ab2//fg0xoDuXyRO7h
 8d7HJjKn5XaM3p/RUu8+7kAa5kN6EbsQRVJxQGNyBfmsScVb+QEAwEdibIRvDyzRQfCA
 qKjWwdsIecuISHN3LcxyqW7UIOvowiWDGvlDWFw9H56BXbO5DJM8mYzt25gE0qWw9mJN
 4LTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rdSWglbmV33o90cfT5RR14PiSy81XzIFQtZlDfbIjfA=;
 b=Ak1fX8R74DR4ms9PLzwIxmfKTVYiEIR103g8ikBOUNNdC3YCbDK8CGiAOCZmcz54rx
 JD79qRA0Z4nt6PD1Cx2Tuc7sAPk2wmiF5oA4NCxwRc6jXpYI/7iUDOL6J6Qc7+B3tEoo
 rtWWZRB71vqAS0HbsR6aP3lmjHR+43lcWkaKXiA42SdJyuCrspwlJjzPC1elTfJF1+tZ
 FRA/PJu3Tc5HxfWFCB/bwvVpgpznhk+GTH8kqeN9ndaWsC/JXoK9fUVcHET9ITp8WTeY
 w03vm5BOJ8twYgtbJQrf+72KmSH2VfO/1AtI9raPyyJUOjOT5nbTG98KJUCWvMhLrnZ/
 QoBA==
X-Gm-Message-State: APjAAAWoroxRZtK7m6oGX6C6va5nvgWbkUZvYsDBU1iQCuWN5e/I7BrI
 q81JMg7ofldABxBUN9Uots0=
X-Google-Smtp-Source: APXvYqwGcARDI41CuoyEcm1zWgqQDK6QclDZvyOPPGCrPNWNlnl7ybfSz4GneLHGtonDyWIxtGyTvA==
X-Received: by 2002:a63:87c8:: with SMTP id
 i191mr25373520pge.131.1559522462130; 
 Sun, 02 Jun 2019 17:41:02 -0700 (PDT)
Received: from localhost ([218.189.10.173])
 by smtp.gmail.com with ESMTPSA id l20sm12890057pff.102.2019.06.02.17.40.59
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 02 Jun 2019 17:41:01 -0700 (PDT)
Date: Mon, 3 Jun 2019 08:40:49 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@aol.com>
Subject: Re: [PATCH] erofs-utils: correct --with-lz4 example in README
Message-ID: <20190603084049.000004bf.zbestahu@gmail.com>
In-Reply-To: <852d84fb-8073-0f3e-bca5-2716788c8149@aol.com>
References: <20190531092722.6708-1-zbestahu@gmail.com>
 <852d84fb-8073-0f3e-bca5-2716788c8149@aol.com>
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
Cc: linux-erofs@lists.ozlabs.org, huyue2@yulong.com, miaoxie@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sat, 1 Jun 2019 13:38:09 +0800
Gao Xiang <hsiangkao@aol.com> wrote:

> On 2019/5/31 ??????5:27, Yue Hu wrote:
> > From: Yue Hu <huyue2@yulong.com>
> > 
> > Option --with-lz4 means LZ4 install directory rather than LZ4 lib
> > directory. We will meet configuration error due to wrong path if
> > setting --with-lz4 to /usr/local/lib. Also stay the same with LZ4
> > help in configure shell script.
> > 
> > Signed-off-by: Yue Hu <huyue2@yulong.com>  
> 
> Applied to mkfs-dev. However, I'd suggest to take a look at new
> erofs-utils since I want to mark old mkfs.erofs as obsoleted...

Ok, got it.

Thx.

> 
> Thanks,
> Gao Xiang
> 
> > ---
> >  README | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/README b/README
> > index 9014268..97eb228 100644
> > --- a/README
> > +++ b/README
> > @@ -19,8 +19,8 @@ Dependencies
> >  
> >  How to build with lz4 static library
> >  	./configure --with-lz4=<lz4 install path>
> > -eg. if lz4 lib has been installed into fold of /usr/local/lib
> > -	./configure --with-lz4=/usr/local/lib && make
> > +eg. if lz4 has been installed into fold of /usr/local
> > +	./configure --with-lz4=/usr/local && make
> >  On Fedora, static lz4 can be installed using:
> >  	yum install lz4-static.x86_64
> >  To build you should run this first:
> >   

