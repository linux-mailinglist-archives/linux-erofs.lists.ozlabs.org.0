Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF885908E3
	for <lists+linux-erofs@lfdr.de>; Fri, 12 Aug 2022 01:05:13 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4M3j7n6xx8z3bY5
	for <lists+linux-erofs@lfdr.de>; Fri, 12 Aug 2022 09:05:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=jDYn7O3H;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b35; helo=mail-yb1-xb35.google.com; envelope-from=wata2ki@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=jDYn7O3H;
	dkim-atps=neutral
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4M3j7d2STbz2xrR
	for <linux-erofs@lists.ozlabs.org>; Fri, 12 Aug 2022 09:04:59 +1000 (AEST)
Received: by mail-yb1-xb35.google.com with SMTP id o15so30491577yba.10
        for <linux-erofs@lists.ozlabs.org>; Thu, 11 Aug 2022 16:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=kCKtt27la9Wk4o9OeDM46egbWLEdvc1nW9C5RHVF3Mw=;
        b=jDYn7O3HECrkJjK1xU8JNvymGb54ci1eO4lWZB+ht4JboHBI7w/qvsGPt9d//IrpYF
         xoCRqPjG+Aa/bFWhIhTdyJ04B96kjwGi96mDt8oPbHM5W1H8QR0sdpAQ8/NurZbOqevg
         7G0Fp5dE8aHtqWci1Dsgl5ixlaYwtsrqUdbxB+XUg7nmvYh5wU5KrkYT/izau8BiVtpZ
         I/kriyM+ny0lmvTqlRQVwCxNkdaE7fY96ZagQlohu8GdtdyKlLz/iegrBWrnSzYzPByI
         7kUUSBKvZYYhvj5bfmrCxtdGhCljKe4tH0ByEwmiLCwViZBWnfNqne0ANK+Tk0dcmFyy
         lJpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=kCKtt27la9Wk4o9OeDM46egbWLEdvc1nW9C5RHVF3Mw=;
        b=o9pcxC6mbBNIfe2i1+Mzdq6vOr/2iTeEsiGEtyXEf6W7a+YSNOSgROWZqM/yzk7345
         S7WLbdyZyXlTdzVMNtwR4EL9Tcf4WaMMC8UZvwROD3AvNIyAowuts7R2RzzECT0k5kP1
         RlRFVQrtfEZM51dqtR0tDOLARMc9TQWCxDrR/TZGiC/rJZJB/QzIHp+bFLXAV52PllWf
         VQOmxJFeuTHS60AE12ZEiBj5Rp1Y4f/G82haTZbbgPFC3vPF3t2HoV47czUUqcb5P5Ru
         Sx5RTCs2O4NSV3nLu22h86GZEytSRJBZv85ZMhwAE75AYuZOlLHJHiKj9pH4NcTM6hCp
         JyFQ==
X-Gm-Message-State: ACgBeo0p+YidGbddLkzdvnrB0UkZjPo4k4xHv6DPywb0groa91j7bpV+
	qWGFt94+wQzDhE40pUG6xHDLqfO814tpH1afXVE=
X-Google-Smtp-Source: AA6agR5Lu3yJfnmL/t92CptCTa0XIBfoXXG+dAfwUWPNyE42Q9EjxHFANB2CBggoE+BzhyRAij0V1BK3jVV3W3VEZhY=
X-Received: by 2002:a25:60c2:0:b0:67b:d2ff:12ce with SMTP id
 u185-20020a2560c2000000b0067bd2ff12cemr1459003ybb.648.1660259092260; Thu, 11
 Aug 2022 16:04:52 -0700 (PDT)
MIME-Version: 1.0
References: <CABBJnRbpAxGB644x=fBRK5GOrjxYawZE-zrhHnRHQbz5Lzp-CQ@mail.gmail.com>
 <YvKj8aZp/6bg/Nxv@debian> <CABBJnRaP8XWbKiYVxbtdiJ0ViFz0hhkwTPnBA004aetZx_5nhQ@mail.gmail.com>
 <YvKrs6J5zBPzFYpF@B-P7TQMD6M-0146.local>
In-Reply-To: <YvKrs6J5zBPzFYpF@B-P7TQMD6M-0146.local>
From: Naoto Yamaguchi <wata2ki@gmail.com>
Date: Fri, 12 Aug 2022 08:04:40 +0900
Message-ID: <CABBJnRYOHLX25FmB3rhmcqEHRS28NKwNAuEihi0JDj0NoQkoDg@mail.gmail.com>
Subject: Re: RFC: erofs-utils:mkfs: add unprivileged container use-case support
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
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
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Gao

I created patch for submit,  but it couldn't send using git
send-email.   Google updated security, it blocked smtp based send
email by git maybe....

Can I submit using github pull request to
https://github.com/hsiangkao/erofs-utils ?

Thanks,
Naoto Yamaguchi,
a member of Automotive Grade Linux Instrument Cluster EG.
