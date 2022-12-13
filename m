Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D89FC64AEC3
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Dec 2022 05:56:52 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NWR6p3LP2z3bgK
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Dec 2022 15:56:50 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.44; helo=out30-44.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NWR6f3YdJz3bSn
	for <linux-erofs@lists.ozlabs.org>; Tue, 13 Dec 2022 15:56:41 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=0;PH=DS;RN=12;SR=0;TI=SMTPD_---0VXCTSqP_1670907394;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VXCTSqP_1670907394)
          by smtp.aliyun-inc.com;
          Tue, 13 Dec 2022 12:56:36 +0800
Date: Tue, 13 Dec 2022 12:56:33 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] erofs updates for 6.2-rc1 (fscache part inclusive)
Message-ID: <Y5gGAedWBwMgqjAm@B-P7TQMD6M-0146.local>
References: <Y5TB6E77vbpRMhIk@debian>
 <Y5bRuDiEwUAK1si1@debian>
 <CAHk-=wg44HkHGo-j5HEChEJYqW0-=vu7=i0euGBPT4asc1xBaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wg44HkHGo-j5HEChEJYqW0-=vu7=i0euGBPT4asc1xBaQ@mail.gmail.com>
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
Cc: Yue Hu <huyue2@coolpad.com>, Chen Zhongjin <chenzhongjin@huawei.com>, Jeff Layton <jlayton@kernel.org>, LKML <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com, Hou Tao <houtao1@huawei.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Dec 12, 2022 at 08:12:18PM -0800, Linus Torvalds wrote:
> On Sun, Dec 11, 2022 at 11:01 PM Gao Xiang <xiang@kernel.org> wrote:
> >
> > Comparing with the latest -next on the last Thursday, there was one-liner
> > addition  commit 927e5010ff5b ("erofs: use kmap_local_page()
> > only for erofs_bread()") as below:
> [...]
> > Because there is no -next version on Monday, if you would like to
> > take all commits in -next you could take
> >   git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.2-rc1-alt
> 
> No worries. That one-liner isn't a problem, and you sent the pull
> request to me early, so I'm perfectly happy with your original request
> and have pulled it.
> 
> Thanks for being careful,

Thank you, Linus!

Thanks,
Gao Xiang

> 
>                  Linus
