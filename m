Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BEAE73FF128
	for <lists+linux-erofs@lfdr.de>; Thu,  2 Sep 2021 18:19:32 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H0mN24fJcz2xrw
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Sep 2021 02:19:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=UqYwBgxk;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linuxfoundation.org (client-ip=2a00:1450:4864:20::233;
 helo=mail-lj1-x233.google.com; envelope-from=torvalds@linuxfoundation.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org
 header.a=rsa-sha256 header.s=google header.b=UqYwBgxk; 
 dkim-atps=neutral
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H0mMw3GXyz2xrw
 for <linux-erofs@lists.ozlabs.org>; Fri,  3 Sep 2021 02:19:22 +1000 (AEST)
Received: by mail-lj1-x233.google.com with SMTP id g14so4594011ljk.5
 for <linux-erofs@lists.ozlabs.org>; Thu, 02 Sep 2021 09:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=iMvWLkdWUtkaR1dklSOOm8LWF6kDmId1zmm7zZNctbo=;
 b=UqYwBgxkGgrjPUjuhbRaR+xLyGBDGqNcXTGQY2dH1sazdx9URXp5fCnNYrBqs5Yf7J
 TvrKnb971ru+ib8HBTPlUc11Ft7o6IkhsByM2Jk+y8Ovf8G4HlaCr9CiPAmTrIPQfYbb
 q5nIzlUcLfmsFEKimVxis1ZpI3WSJxF/9jqfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=iMvWLkdWUtkaR1dklSOOm8LWF6kDmId1zmm7zZNctbo=;
 b=gtUfcwl3KCx+/UCuayqhLuSfFGgpubqbE4ZA9vR6a0Nx4Iq9fCD9aRPyoW751WosLx
 vhpngxvRM3IA6TeZpgU1FRljtxd2BOpn36HH7jJCgNORh7RU+pY38ntvLU9fBQLHk/L8
 6EydGeUzfIuu0uGtCnQm+yDZdjyj0nblj7J/72Av7qAEUgnkEJjOuPF65DTD1DJjPy6J
 LyjYBx/bO3qSu/LJaaeminglJcYK9fQ6blhBWs1+OIDqbvmXvKompBzP7qtSM/2yBRrQ
 /NDaOLigeB5eZzKLhhO6ClKXHVw2m1jm/k2ruT21y4AgDbosCzLmk8gxDGKsr74ETt2R
 XijQ==
X-Gm-Message-State: AOAM532uWZHGshyhdQGs5YajjI9dqRdEXBUw/2IsK9SOqq9s9Xy1Ajyz
 Oe6hrj5feA0Dd6QDIJdB+RZFSXPsATIV5qXz
X-Google-Smtp-Source: ABdhPJwkmi/75RdIShWeqkObfoKH1t0+Yi+OnWRF+E92zdg4L6Gnc16ONbtroKhRKDTazCebEq+IBA==
X-Received: by 2002:a2e:98d0:: with SMTP id s16mr3317192ljj.115.1630599557583; 
 Thu, 02 Sep 2021 09:19:17 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com.
 [209.85.167.49])
 by smtp.gmail.com with ESMTPSA id n4sm260405lji.100.2021.09.02.09.19.15
 for <linux-erofs@lists.ozlabs.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Sep 2021 09:19:15 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id p38so5591653lfa.0
 for <linux-erofs@lists.ozlabs.org>; Thu, 02 Sep 2021 09:19:15 -0700 (PDT)
X-Received: by 2002:a05:6512:681:: with SMTP id
 t1mr3132726lfe.487.1630599555287; 
 Thu, 02 Sep 2021 09:19:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210831225935.GA26537@hsiangkao-HP-ZHAN-66-Pro-G1>
In-Reply-To: <20210831225935.GA26537@hsiangkao-HP-ZHAN-66-Pro-G1>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 2 Sep 2021 09:18:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi7gf_afYhx_PYCN-Sgghuw626dBNqxZ6aDQ-a+sg6wag@mail.gmail.com>
Message-ID: <CAHk-=wi7gf_afYhx_PYCN-Sgghuw626dBNqxZ6aDQ-a+sg6wag@mail.gmail.com>
Subject: Re: [GIT PULL] erofs updates for 5.15-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, 
 Chao Yu <chao@kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
 linux-erofs@lists.ozlabs.org, Dan Williams <dan.j.williams@intel.com>, 
 Stephen Rothwell <sfr@canb.auug.org.au>, Huang Jianan <huangjianan@oppo.com>,
 Yue Hu <huyue2@yulong.com>, 
 Miao Xie <miaoxie@huawei.com>, Liu Bo <bo.liu@linux.alibaba.com>, 
 Peng Tao <tao.peng@linux.alibaba.com>, Joseph Qi <joseph.qi@linux.alibaba.com>,
 Liu Jiang <gerry@linux.alibaba.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Aug 31, 2021 at 4:00 PM Gao Xiang <xiang@kernel.org> wrote:
>
> All commits have been tested and have been in linux-next. Note that
> in order to support iomap tail-packing inline, I had to merge iomap
> core branch (I've created a merge commit with the reason) in advance
> to resolve such functional dependency, which is now merged into
> upstream. Hopefully I did the right thing...

It all looks fine to me. You have all the important parts: what you
are merging, and _why_ you are merging it.

So no complaints, and thanks for making it explicit in your pull
request too so that I'm not taken by surprise.

         Linus
