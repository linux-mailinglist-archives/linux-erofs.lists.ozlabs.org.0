Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F16E4CB0D
	for <lists+linux-erofs@lfdr.de>; Thu, 20 Jun 2019 11:37:33 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45TxYk6LZXzDqVS
	for <lists+linux-erofs@lfdr.de>; Thu, 20 Jun 2019 19:37:30 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="e5a236Hu"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45TxPB1Yd1zDr8L
 for <linux-erofs@lists.ozlabs.org>; Thu, 20 Jun 2019 19:30:05 +1000 (AEST)
Received: by mail-pf1-x443.google.com with SMTP id q10so1323713pff.9
 for <linux-erofs@lists.ozlabs.org>; Thu, 20 Jun 2019 02:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Jw2ujedsxsSKG/9FRSTBxfp7gi2DJ574hzQPjL3ZtHg=;
 b=e5a236HuSs7mXaOzjKiiqxfsrZXT3xmoeAuqsPqfhQodQqLMbJyz5GBvgp8IoLBX1W
 I0emBLE0USGK1vsgE/tjGo2YTpExLK3s5TY0yp3bSMmbIIB2FlgQtb6WMYzin09XtXDM
 XpFiRspLWDcoNyHw/3UAaKvovVEX1Bpuny1MDy0IpPbyN4GdHG3Yeck1ypSq4RHOYbrd
 kWgU9IafQHh/9XVTaVzEd8pF/PBViUxMmIvqfZfsKegAVRvDwXkYuJy7DbOhZiN7cPhk
 rUcHXVtJkFC5q6SWA5bW6yoBPvGnIIO7n6gvqtlzrUmFrrcwhkq9X1Tqp9MrUq2s85Vt
 fchw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Jw2ujedsxsSKG/9FRSTBxfp7gi2DJ574hzQPjL3ZtHg=;
 b=s50Cv8HRmvx/vLbJI5i+BJsRfZQvPCcK7fOAP1LRyt30VoV5DK70IMOkMwCceqm0A6
 NFUNUV0d3VHy8UnyayT0Sml83qcMix5PU4SPA5s2S0WMLRPBpNRUwEM99cJLEICpwZgr
 81y6mBJjDaAbzuDGFjamCXlOLSUdKx1hFT2qSIO9xKVaIl1/PtP9LTsQogWtwUHQ1Q2E
 y1atDg2hImWsa8L18YW83NH3HGk5YiTxJBz3oh0t8kzJEhgLjwWKZHprGOOejpDnoJRK
 3G/vDAv65F0OYRtSz10hZAoReoswihU92ZYKWcmYcqRDQeVfCEe4Z0oLca2mreMiC09c
 0kuA==
X-Gm-Message-State: APjAAAVhc/PycS9zpyx0c+3Qmj6CegdjsmpgSP6upp1/pP7fhSd+Glov
 38cM6wJUANfNrkMqKkA/8rE=
X-Google-Smtp-Source: APXvYqzJOnK78jWPcBJodqTTNyB1CNcSSqaK5Xw46RWJ4tprk10F01i9d0RhSQMHyjbi6w87NNkWzg==
X-Received: by 2002:a17:90a:b104:: with SMTP id
 z4mr2102974pjq.102.1561023002549; 
 Thu, 20 Jun 2019 02:30:02 -0700 (PDT)
Received: from localhost ([218.189.10.173])
 by smtp.gmail.com with ESMTPSA id d9sm22091863pgj.34.2019.06.20.02.30.00
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 20 Jun 2019 02:30:02 -0700 (PDT)
Date: Thu, 20 Jun 2019 17:29:55 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] staging: erofs: remove needless CONFIG_EROFS_FS_SECURITY
Message-ID: <20190620172955.00000e7a.zbestahu@gmail.com>
In-Reply-To: <fdc23da6-90eb-e3f0-448a-5df1494f4190@huawei.com>
References: <20190620083004.2488-1-zbestahu@gmail.com>
 <8a45f678-15cc-be9a-282f-49b251f127a9@huawei.com>
 <fdc23da6-90eb-e3f0-448a-5df1494f4190@huawei.com>
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

On Thu, 20 Jun 2019 17:22:48 +0800
Chao Yu <yuchao0@huawei.com> wrote:

> On 2019/6/20 16:32, Gao Xiang wrote:
> > Hi Yue,
> > 
> > On 2019/6/20 16:30, Yue Hu wrote:  
> >> From: Yue Hu <huyue2@yulong.com>
> >>
> >> erofs_xattr_security_handler is already marked __maybe_unused, no need
> >> to add CONFIG_EROFS_FS_SECURITY condition.  
> 
> CONFIG_EROFS_FS_SECURITY is used as a control switch of erofs security labels
> feature, but __maybe_unused is to avoid unneeded compiler warning on unused
> variable, so I think we can't remove it.

However, erofs_xattr_security_handler will not unused under CONFIG_EROFS_FS_SECURITY
condition, right?

Thx.

> 
> Thanks,
> 
> >>
> >> Signed-off-by: Yue Hu <huyue2@yulong.com>
> >> ---
> >>  drivers/staging/erofs/xattr.c | 2 --
> >>  1 file changed, 2 deletions(-)
> >>
> >> diff --git a/drivers/staging/erofs/xattr.c b/drivers/staging/erofs/xattr.c
> >> index df40654..06024ac 100644
> >> --- a/drivers/staging/erofs/xattr.c
> >> +++ b/drivers/staging/erofs/xattr.c
> >> @@ -499,13 +499,11 @@ static int erofs_xattr_generic_get(const struct xattr_handler *handler,
> >>  	.get	= erofs_xattr_generic_get,
> >>  };
> >>  
> >> -#ifdef CONFIG_EROFS_FS_SECURITY
> >>  const struct xattr_handler __maybe_unused erofs_xattr_security_handler = {
> >>  	.prefix	= XATTR_SECURITY_PREFIX,
> >>  	.flags	= EROFS_XATTR_INDEX_SECURITY,
> >>  	.get	= erofs_xattr_generic_get,
> >>  };
> >> -#endif  
> > 
> > Thanks for your patch.
> > 
> > In that case...erofs_xattr_security_handler could be compiled into .rodata section?
> > I am not sure...
> > 
> > Thanks,
> > Gao Xiang
> >   
> >>  
> >>  const struct xattr_handler *erofs_xattr_handlers[] = {
> >>  	&erofs_xattr_user_handler,
> >>  
> > .
> >   

