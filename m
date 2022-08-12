Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A645909FE
	for <lists+linux-erofs@lfdr.de>; Fri, 12 Aug 2022 03:48:03 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4M3mlg3gGbz3bY5
	for <lists+linux-erofs@lfdr.de>; Fri, 12 Aug 2022 11:47:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=f+tBulor;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42b; helo=mail-pf1-x42b.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=f+tBulor;
	dkim-atps=neutral
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4M3mlY3vkWz2xX6
	for <linux-erofs@lists.ozlabs.org>; Fri, 12 Aug 2022 11:47:51 +1000 (AEST)
Received: by mail-pf1-x42b.google.com with SMTP id y141so17965742pfb.7
        for <linux-erofs@lists.ozlabs.org>; Thu, 11 Aug 2022 18:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc;
        bh=ozFEP/yxJOd5RIDMUysufLZ7E8NIanoxqPsbAkiMPNw=;
        b=f+tBulor+sAbYQVYEv5LS1+urI8Bt3/7NimeJ18XG3wZQAM9zhS0EbBC+AScTgzHBF
         xzz1U9/DEeG8/B5ZbqeuN/NVDF2ikPWlfGZ9SRoV+yqvbOZkNzEhcd0PwmmkdsDo4p3I
         +0sdDODlWw1Aa4MWZVPZZ8B1gT7OD6guwOROv/mdup2ku0GDOWDS+7j8hWz1DrfRL6re
         oNUPPgE7xxtM150tMjB+Gwi78FjyOoWfa0FSzrHRyLo2SL9Z99fCwdaIeGoyUB3ScfPY
         OdoYugUg1ylEzP3iqmh+lxwzWQszqXTMKE8QHOYIswEukyPGdy7dk+f9hOVuZMcUXjeK
         Mu2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=ozFEP/yxJOd5RIDMUysufLZ7E8NIanoxqPsbAkiMPNw=;
        b=ABuEqXynPwOzRs3/Un3EdSuCD4U28A+bUfooD+2Yei0gHPAON84Sh5ajQrShbWBQEw
         03kiwEXtcSBTWaLDUNSOFS3RbjezeHSDorwfE7t9UUDZkJgr741zqTUVIfBOr20mP6j8
         wSLZUD8IVYIoSSDe7puZrKYJhdExjaltzlhdgaJ2IUSlWbrG5b5P3BtJD7rN5ovyEXGL
         VLfEU6DNAz3Qfq3I5YueYutp6wQYgWg96x79cpS51PHyUz9O6xo1NqUJIFhxOxA+bt8N
         aqBTcw630D7xkx7ZYB46eEbqF9mAPeIgXUJUUf4cPd26ullGaquAN61KhD6xXO+LN5zw
         +mOw==
X-Gm-Message-State: ACgBeo3LOdqPstJQxMUNmkQFWyCPMVEOkNe72qx8VErdVmPW0JJKju88
	YqGqqqRcKSMQU0+c2sG/eNg=
X-Google-Smtp-Source: AA6agR5/Wbrrh4kjMEWQXsZsSpteZbJp5nPll4zSf1VlIslOK8DJaurPblD3/Hiw1d1+ySVTblRqMw==
X-Received: by 2002:a05:6a00:2352:b0:52e:a03b:76f1 with SMTP id j18-20020a056a00235200b0052ea03b76f1mr1838471pfj.34.1660268868507;
        Thu, 11 Aug 2022 18:47:48 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id p6-20020a63c146000000b0041a919ed63dsm391771pgi.3.2022.08.11.18.47.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Aug 2022 18:47:48 -0700 (PDT)
Date: Fri, 12 Aug 2022 09:49:41 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Naoto Yamaguchi <wata2ki@gmail.com>
Subject: Re: RFC: erofs-utils:mkfs: add unprivileged container use-case
 support
Message-ID: <20220812094941.00001031.zbestahu@gmail.com>
In-Reply-To: <CABBJnRYOHLX25FmB3rhmcqEHRS28NKwNAuEihi0JDj0NoQkoDg@mail.gmail.com>
References: <CABBJnRbpAxGB644x=fBRK5GOrjxYawZE-zrhHnRHQbz5Lzp-CQ@mail.gmail.com>
	<YvKj8aZp/6bg/Nxv@debian>
	<CABBJnRaP8XWbKiYVxbtdiJ0ViFz0hhkwTPnBA004aetZx_5nhQ@mail.gmail.com>
	<YvKrs6J5zBPzFYpF@B-P7TQMD6M-0146.local>
	<CABBJnRYOHLX25FmB3rhmcqEHRS28NKwNAuEihi0JDj0NoQkoDg@mail.gmail.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Naoto,

On Fri, 12 Aug 2022 08:04:40 +0900
Naoto Yamaguchi <wata2ki@gmail.com> wrote:

> Hi Gao
> 
> I created patch for submit,  but it couldn't send using git
> send-email.   Google updated security, it blocked smtp based send
> email by git maybe....

As Xiang said, check below about 'app password' if you want:

https://fmsinc.com/MicrosoftAccess/email/smtp/app-password/index.htm

Thanks.

> 
> Can I submit using github pull request to
> https://github.com/hsiangkao/erofs-utils ?
> 
> Thanks,
> Naoto Yamaguchi,
> a member of Automotive Grade Linux Instrument Cluster EG.

