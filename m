Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9533FF3B0
	for <lists+linux-erofs@lfdr.de>; Thu,  2 Sep 2021 20:58:33 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H0qvW2KPdz2yN4
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Sep 2021 04:58:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=Ibpdc46z;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linuxfoundation.org (client-ip=2a00:1450:4864:20::229;
 helo=mail-lj1-x229.google.com; envelope-from=torvalds@linuxfoundation.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org
 header.a=rsa-sha256 header.s=google header.b=Ibpdc46z; 
 dkim-atps=neutral
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H0qvN04ytz2xtQ
 for <linux-erofs@lists.ozlabs.org>; Fri,  3 Sep 2021 04:58:21 +1000 (AEST)
Received: by mail-lj1-x229.google.com with SMTP id i28so5437224ljm.7
 for <linux-erofs@lists.ozlabs.org>; Thu, 02 Sep 2021 11:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=nou0znqimsrLl6OB5c1aMp82GMEqusuNoyOJ20o6LFI=;
 b=Ibpdc46zjQloZ+vX8Jc+8cZvxyZgkNzdSsEJA3RXMKA4Uv115klG8TP44ku0D70EYN
 2ZdHNkPCogYuUgXzzStalGmdzhm6x4HMAJyz6jwygSEzV1uGAEnpH4rb6ZQRdRgWqyQl
 K8bZBGqrT9kuG/VjjS1yasgD0iTr8JY35ybDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=nou0znqimsrLl6OB5c1aMp82GMEqusuNoyOJ20o6LFI=;
 b=G80Dft57anwrd24wzdVk/WOqMPSx6PBKwE11UcOxguoTxUJcihflDi9J5U+/OseUFy
 fYlHEyH4siGjKQqPlwpH8fUKsItcR8xuzfvDzSrSTT8cLvoRd90r8bS4mnpt0JyCkpO2
 C837Txdl2i9JLuc9FXCm5wHxYPSy6MqAeHfa0GRsU0r5xTnML2VtBYz0pw1+3zyqHWD3
 0qOeDtLiRsAPCgAgVvFU+aGX7weZyJ5ThCWEIsgdGVLz2fSChOR0u2dGwzHmDYQjSaLh
 7udKZHaLtiaCfy2jS0KkX1sl0I/vy5WhsqCl6j8yyXPpUfmUqGSFAkBb1dN79n1ua2oz
 Qm5w==
X-Gm-Message-State: AOAM533X60i7SDd5npQ0l8JPU3iaraKGZj3RURNMu/BDreZuiIBRt7vI
 oIT1nITU+RTipwwYaOWP2Xsp9apY/q2hQYpPq7Y=
X-Google-Smtp-Source: ABdhPJzDUhxgGZI2ddTn1sFskq1w3CjrpyIneEhcu0Ay0g//FU8z1nMSDUDeJfcjUSRcpsIZkcv70g==
X-Received: by 2002:a2e:960c:: with SMTP id v12mr3740475ljh.300.1630609095250; 
 Thu, 02 Sep 2021 11:58:15 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com.
 [209.85.167.52])
 by smtp.gmail.com with ESMTPSA id d40sm190966lfv.23.2021.09.02.11.58.14
 for <linux-erofs@lists.ozlabs.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Sep 2021 11:58:14 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id bq28so6509429lfb.7
 for <linux-erofs@lists.ozlabs.org>; Thu, 02 Sep 2021 11:58:14 -0700 (PDT)
X-Received: by 2002:a05:6512:230b:: with SMTP id
 o11mr3465517lfu.377.1630609094065; 
 Thu, 02 Sep 2021 11:58:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210831225935.GA26537@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CAHk-=wi7gf_afYhx_PYCN-Sgghuw626dBNqxZ6aDQ-a+sg6wag@mail.gmail.com>
 <20210902182053.GB26537@hsiangkao-HP-ZHAN-66-Pro-G1>
In-Reply-To: <20210902182053.GB26537@hsiangkao-HP-ZHAN-66-Pro-G1>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 2 Sep 2021 11:57:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgirqjdeuYX+PvL-09UUKtnBaRYTXQrRdjCYxGKirEpug@mail.gmail.com>
Message-ID: <CAHk-=wgirqjdeuYX+PvL-09UUKtnBaRYTXQrRdjCYxGKirEpug@mail.gmail.com>
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

On Thu, Sep 2, 2021 at 11:21 AM Gao Xiang <xiang@kernel.org> wrote:
>
> Yeah, thanks. That was my first time to merge another tree due to hard
> dependency like this. I've gained some experience from this and will be
> more confident on this if such things happen in the future. :)

Well, being nervous about cross-tree merges is probably a good thing,
and they *should* be fairly rare.

So don't get over-confident and cocky ;^)

                  Linus
