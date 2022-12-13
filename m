Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 296F164AE92
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Dec 2022 05:12:50 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NWQ7z6jDDz3bgJ
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Dec 2022 15:12:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=Yvg8jYxn;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=2607:f8b0:4864:20::82c; helo=mail-qt1-x82c.google.com; envelope-from=torvalds@linuxfoundation.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=Yvg8jYxn;
	dkim-atps=neutral
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NWQ7v6Lhdz3bSn
	for <linux-erofs@lists.ozlabs.org>; Tue, 13 Dec 2022 15:12:41 +1100 (AEDT)
Received: by mail-qt1-x82c.google.com with SMTP id ay32so10913109qtb.11
        for <linux-erofs@lists.ozlabs.org>; Mon, 12 Dec 2022 20:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IbX66ZXwXxKVKyE5+d5TwpxRmxyoArAKr+H2f8obyNQ=;
        b=Yvg8jYxnKKGYYS96lK+qTy6828mLCsBGBUhO4kv2uFz3BXfleQ4F6ocBPx95r1oHrm
         J/qcF4SsXvzDHpPAvk0L9m0uq9vTL4nhZXb1qniyQ2oHPbsIOpxjou/VxekGSDIM3I17
         3DWgDzJ83YlECtx5BRGdI5fKmsx3bUV+0NO2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IbX66ZXwXxKVKyE5+d5TwpxRmxyoArAKr+H2f8obyNQ=;
        b=wtuZ9RzSDfSAbTrvK7pZFitaZVW+zex8YoyjP/xpqJmQs6mpoXuYGkCjwtTHvpKRvi
         ReB6ojH1nzuh2YiwkshutrXkeANVMXM8MhETM4VJ8Ql3KSHhRnc8zc+IZYqWYZFeVQ2j
         eG+jxRlkWjlKG7HqadR+/GkMrly0IkiXpQYVCO093OjCsWBvMpfo3xu3J6AXowZ7vESR
         iIn2gk5dxwE3Y4hpFbEDFb9tcq+sdNFkX5/IEo1X/U1Aadg9/i9to82TusKrQBwOfdOQ
         Uc5zprU06wAarfWjTKKNZkOlunnPEjkj/J0YGClY6Ead6McPqttuC+YhilrY986UBaVH
         JtuQ==
X-Gm-Message-State: ANoB5plsTuHWnVwE81laEdoa4MnmzfsNgnjbDedyNOLnXOrDIxlNZKpw
	a5ofFgBAy2r/7EK9y+5MQfVJFutVFs0iVqfL
X-Google-Smtp-Source: AA0mqf5yQA04PHiwSu1bODUONstpnsFULZ3d8JjLJNUi7tud7vGu8g5hvig5a+mBOy+w2yJ18nsRLA==
X-Received: by 2002:ac8:424e:0:b0:3a8:5d1:aabc with SMTP id r14-20020ac8424e000000b003a805d1aabcmr21031786qtm.15.1670904757159;
        Mon, 12 Dec 2022 20:12:37 -0800 (PST)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com. [209.85.222.170])
        by smtp.gmail.com with ESMTPSA id dm49-20020a05620a1d7100b006bbc3724affsm7198804qkb.45.2022.12.12.20.12.34
        for <linux-erofs@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 20:12:34 -0800 (PST)
Received: by mail-qk1-f170.google.com with SMTP id k3so6024136qki.13
        for <linux-erofs@lists.ozlabs.org>; Mon, 12 Dec 2022 20:12:34 -0800 (PST)
X-Received: by 2002:a37:8883:0:b0:6fb:628a:1aea with SMTP id
 k125-20020a378883000000b006fb628a1aeamr84330860qkd.697.1670904754152; Mon, 12
 Dec 2022 20:12:34 -0800 (PST)
MIME-Version: 1.0
References: <Y5TB6E77vbpRMhIk@debian> <Y5bRuDiEwUAK1si1@debian>
In-Reply-To: <Y5bRuDiEwUAK1si1@debian>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 12 Dec 2022 20:12:18 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg44HkHGo-j5HEChEJYqW0-=vu7=i0euGBPT4asc1xBaQ@mail.gmail.com>
Message-ID: <CAHk-=wg44HkHGo-j5HEChEJYqW0-=vu7=i0euGBPT4asc1xBaQ@mail.gmail.com>
Subject: Re: [GIT PULL] erofs updates for 6.2-rc1 (fscache part inclusive)
To: Linus Torvalds <torvalds@linux-foundation.org>, linux-erofs@lists.ozlabs.org, 
	linux-cachefs@redhat.com, LKML <linux-kernel@vger.kernel.org>, 
	David Howells <dhowells@redhat.com>, Jeff Layton <jlayton@kernel.org>, Chao Yu <chao@kernel.org>, 
	Yue Hu <huyue2@coolpad.com>, Jingbo Xu <jefflexu@linux.alibaba.com>, 
	Hou Tao <houtao1@huawei.com>, Chen Zhongjin <chenzhongjin@huawei.com>, 
	Jia Zhu <zhujia.zj@bytedance.com>
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
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sun, Dec 11, 2022 at 11:01 PM Gao Xiang <xiang@kernel.org> wrote:
>
> Comparing with the latest -next on the last Thursday, there was one-liner
> addition  commit 927e5010ff5b ("erofs: use kmap_local_page()
> only for erofs_bread()") as below:
[...]
> Because there is no -next version on Monday, if you would like to
> take all commits in -next you could take
>   git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.2-rc1-alt

No worries. That one-liner isn't a problem, and you sent the pull
request to me early, so I'm perfectly happy with your original request
and have pulled it.

Thanks for being careful,

                 Linus
