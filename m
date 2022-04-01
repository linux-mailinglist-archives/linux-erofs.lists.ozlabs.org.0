Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B308F4EEC78
	for <lists+linux-erofs@lfdr.de>; Fri,  1 Apr 2022 13:41:08 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KVJCQ4Clvz2yxP
	for <lists+linux-erofs@lfdr.de>; Fri,  1 Apr 2022 22:41:06 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132;
 helo=out30-132.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-132.freemail.mail.aliyun.com
 (out30-132.freemail.mail.aliyun.com [115.124.30.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KVJCL0Tdcz2xSM
 for <linux-erofs@lists.ozlabs.org>; Fri,  1 Apr 2022 22:40:56 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04357; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=2; SR=0; TI=SMTPD_---0V8u1Vzx_1648813248; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V8u1Vzx_1648813248) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 01 Apr 2022 19:40:49 +0800
Date: Fri, 1 Apr 2022 19:40:48 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Henry King <hongyu.jin.cn@gmail.com>
Subject: Re: [PATCH] erofs: fix use-after-free of on-stack io[]
Message-ID: <YkbkwI7Vgo3pxkzj@B-P7TQMD6M-0146.local>
References: <20220401063301.3150-1-hongyu.jin.cn@gmail.com>
 <Ykah7AB8k6Abed+u@B-P7TQMD6M-0146.local>
 <CAMQnb4P5c4-xajX_OY8wzhwhZBgktuijZJyQR_B9k+S4wNpo4Q@mail.gmail.com>
 <Ykbe2MiG25oWpsZa@B-P7TQMD6M-0146.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Ykbe2MiG25oWpsZa@B-P7TQMD6M-0146.local>
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
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Apr 01, 2022 at 07:15:36PM +0800, Gao Xiang wrote:
> On Fri, Apr 01, 2022 at 05:36:23PM +0800, Henry King wrote:
> > Gao Xiang <hsiangkao@linux.alibaba.com> 于2022年4月1日周五 14:55写道：

...

> > > > @@ -1370,8 +1367,7 @@ static void z_erofs_runqueue(struct super_block *sb,
> > > >               return;
> > > >
> > > >       /* wait until all bios are completed */
> > > > -     io_wait_event(io[JQ_SUBMIT].u.wait,
> > > > -                   !atomic_read(&io[JQ_SUBMIT].pending_bios));
> > > > +     wait_for_completion_io(&io[JQ_SUBMIT].u.done);
> > >
> > > Thanks, good catch!
> > >
> > > What if pending_bios is always 0 (nr_bios == 0), is it possible?
> > The pending_bios isn't always 0.  If bio is completed faster before
> > io_wait_event() called, the value of pending_bios from 1 to 0,
> > when enter io_wait_event(), it will not acquire lock and return immediately.
> 
> nope, IMO, if no io submission, we could run into this case.
> 

Ok, after revisiting the code, I think it's impossible as well.
Please help commit another version with commit message updated. I will
test it later (it's a quite rare race I think.)

Thanks,
Gao Xiang


> Thanks,
> Gao Xiang
> 
> > >
> > > Thanks,
> > > Gao Xiang
