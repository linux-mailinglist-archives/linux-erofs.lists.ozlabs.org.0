Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F21F484BAA
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Jan 2022 01:24:38 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JT9GX2jyXz2yfb
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Jan 2022 11:24:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1641342276;
	bh=Hzxt5urzMb6xBGXvJYwLDZcAscZ19KRl1fzfHUb4EvQ=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=mWqQD5iF9Kqgy272HmAbd14HwJAWL4a5h73JzhlrdDmNaINtPsNxDO5njKb/qYb2j
	 zMEhukhKOib3DKe5bb/NtJHdWv5zqk/xJSU6yt1FLa8qt5pwnS+YsbyWbMH9Wyvsfi
	 gfvKyhg6FhtE2+k+1Ge7R1GA6A729viICJIMcaR5ZG97S/0Zrz3g22ZZ0IMRb0KTlM
	 y7CZxEJ9manerXsWG7154JIQVf69+kdtYr4SrzjuDJZwF2M6vkuR8DMKT+nZ3DwO98
	 CUzFfBcoogPbj4yYAlWGp9K3GDTSUj4Mo2F5+6DRqXeGE4I9HAyBSnIg++IlG8YXaZ
	 SDiUAUDRw95cQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::736;
 helo=mail-qk1-x736.google.com; envelope-from=zhangkelvin@google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20210112 header.b=Ds3FFqd0; dkim-atps=neutral
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JT9GT42Vgz2xBP
 for <linux-erofs@lists.ozlabs.org>; Wed,  5 Jan 2022 11:24:32 +1100 (AEDT)
Received: by mail-qk1-x736.google.com with SMTP id b85so36644374qkc.1
 for <linux-erofs@lists.ozlabs.org>; Tue, 04 Jan 2022 16:24:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Hzxt5urzMb6xBGXvJYwLDZcAscZ19KRl1fzfHUb4EvQ=;
 b=Wuzo75tpoUFKnZ9mVD/KROn98zCHap+sbwDhIgeQQHcWZ77LnUw6SIeDqnXy8XHcnv
 rwY092XrDR7SAX9DNcPUM0xApd6w40oh5+1Vbjeh+kUG82GX3374hNgERfBCIK/wfExu
 lDgzS78ZZVW4543OUZrz+fRXfUUo4kElRrTrKtUp2XeZVM2sws+5+lgO/PiEOtVHEwn5
 QRn2yi9TFN5RdPB2fJ0cGdsR58Tn+40YfC3xFNaaoWioCqoRk77Is9iEUfZcpw35+AUf
 rhCb48886Yq8Hgt8sy2uBde4TOEWsQydamS0RH5HMdGdMRtf0MavbrMYFbHo1WtvbEAh
 kZJQ==
X-Gm-Message-State: AOAM531drIH8qC6WlKIf9rH67qjSwKUqypyXK+Hz5IN9l/MVXQ6RcNSQ
 KYS9RgQcu8IchZ3YgMwxWgY6wVCp8s4NL3Pjd8jfNA==
X-Google-Smtp-Source: ABdhPJyiDGuGtY8sZq3/o3zG20iPtorP9wKJ9ijYxd7lpXCQVX1ET33eOJKPZQIqkpzdhft3fXW450ZiBhuxXVO8cgU=
X-Received: by 2002:a05:620a:e16:: with SMTP id
 y22mr36500772qkm.122.1641342269398; 
 Tue, 04 Jan 2022 16:24:29 -0800 (PST)
MIME-Version: 1.0
References: <YcKDAILGEoYFE7K0@B-P7TQMD6M-0146.local>
 <20211222014917.265476-1-zhangkelvin@google.com>
 <CAOSmRzgOB-78BSc4Ug-xNnS+Cc6x8AZ8zEVTYPU4iiKcOowVWQ@mail.gmail.com>
 <YdTlFVEYrjoV4zkv@B-P7TQMD6M-0146.local>
In-Reply-To: <YdTlFVEYrjoV4zkv@B-P7TQMD6M-0146.local>
Date: Tue, 4 Jan 2022 16:24:18 -0800
Message-ID: <CAOSmRzitX0=WJ9gcFvfCyBfzFjdCGw6RGJuBWOvC1bP7bzG44A@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] erofs-utils: lib: Add some comments about
 const-ness around iterate API
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
From: Kelvin Zhang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Kelvin Zhang <zhangkelvin@google.com>
Cc: Miao Xie <miaoxie@huawei.com>,
 linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Ah, I see, thanks!

On Tue, Jan 4, 2022 at 4:23 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>
> On Tue, Jan 04, 2022 at 03:37:51PM -0800, Kelvin Zhang wrote:
> > friendly ping
>
> I already merged them, didn't I?
> https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/commit/?h=dev&id=2be280dc28ace9c3840aa5e6ca7ff90ef4212cd1
>
> Thanks,
> Gao Xiang
>
> >



-- 
Sincerely,

Kelvin Zhang
