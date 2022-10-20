Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id AAEFF605ACD
	for <lists+linux-erofs@lfdr.de>; Thu, 20 Oct 2022 11:14:24 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MtMNs6KQtz3cfB
	for <lists+linux-erofs@lfdr.de>; Thu, 20 Oct 2022 20:14:21 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.54; helo=out30-54.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MtMNn0QWfz2ypV
	for <linux-erofs@lists.ozlabs.org>; Thu, 20 Oct 2022 20:14:15 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R331e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VSebUEb_1666257248;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VSebUEb_1666257248)
          by smtp.aliyun-inc.com;
          Thu, 20 Oct 2022 17:14:10 +0800
Date: Thu, 20 Oct 2022 17:14:07 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] erofs: fix possible memory leak in erofs_init_sysfs()
Message-ID: <Y1ERX8jrpkQRAp2Z@B-P7TQMD6M-0146.local>
References: <20221018073947.693206-1-yangyingliang@huawei.com>
 <Y09fJXi42XV/PF4W@B-P7TQMD6M-0146.local>
 <64640ad2-45c5-d07e-60ab-a14e5de5998a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <64640ad2-45c5-d07e-60ab-a14e5de5998a@kernel.org>
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
Cc: gregkh@linuxfoundation.org, huangjianan@oppo.com, Joseph Qi <joseph.qi@linux.alibaba.com>, Yang Yingliang <yangyingliang@huawei.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Chao,

On Thu, Oct 20, 2022 at 04:49:34PM +0800, Chao Yu wrote:
> On 2022/10/19 10:21, Gao Xiang wrote:
> > Hi Yingliang,
> > 
> > On Tue, Oct 18, 2022 at 03:39:47PM +0800, Yang Yingliang wrote:
> > > Inject fault while probing module, kset_register() may fail,
> > > if it fails, but the refcount of kobject is not decreased to
> > > 0, the name allocated in kobject_set_name() is leaked. Fix
> > > this by calling kset_put(), so that name can be freed in
> > > callback function kobject_cleanup().
> > > 
> > > unreferenced object 0xffff888101d228c0 (size 8):
> > >    comm "modprobe", pid 276, jiffies 4294722700 (age 13.151s)
> > >    hex dump (first 8 bytes):
> > >      65 72 6f 66 73 00 ff ff                          erofs...
> > >    backtrace:
> > >      [<00000000e2a9a4a6>] __kmalloc_node_track_caller+0x44/0x1b0
> > >      [<00000000b8ce02de>] kstrdup+0x3a/0x70
> > >      [<000000004a0e01d2>] kstrdup_const+0x63/0x80
> > >      [<00000000051b6cda>] kvasprintf_const+0x149/0x180
> > >      [<000000004dc51dad>] kobject_set_name_vargs+0x56/0x150
> > >      [<00000000b30f0bad>] kobject_set_name+0xab/0xe0
> > > 
> > > Fixes: 168e9a76200c ("erofs: add sysfs interface")
> > > Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> > 
> > Thanks for the catch, the issue itself seems true.  However, I found
> > several fses all have this issue.
> > 
> > After I did some discussion with Joseph Qi offline, I'd like to wait
> > for the conclusion of the following thread:
> > https://lore.kernel.org/r/bf27f347-5ced-98e5-f188-659cc2a9736f@linux.alibaba.com
> > 
> > Since I tend to think kset_put() should be one fail step of
> > kset_register().
> 
> I guess in error path, it missed to free kobj->name which was allocated by
> kobject_set_name(&erofs_root.kobj, "erofs"), so calling kset_put() here looks
> fine?

We looked into this yesterday.  I think the main problem is that the
kset_put() a reference which is set in kset_init() of kset_register().

Therefore such refernece belongs to an internal implementation and
should not be treated for each kset_register() caller.

Please correct me if I'm wrong here.

Thanks,
Gao Xiang

> 
> Thanks,
> 
> > 
> > Thanks,
> > Gao Xiang
> > 
> > > ---
> > >   fs/erofs/sysfs.c | 4 +++-
> > >   1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
> > > index 783bb7b21b51..653b35001bc5 100644
> > > --- a/fs/erofs/sysfs.c
> > > +++ b/fs/erofs/sysfs.c
> > > @@ -254,8 +254,10 @@ int __init erofs_init_sysfs(void)
> > >   	kobject_set_name(&erofs_root.kobj, "erofs");
> > >   	erofs_root.kobj.parent = fs_kobj;
> > >   	ret = kset_register(&erofs_root);
> > > -	if (ret)
> > > +	if (ret) {
> > > +		kset_put(&erofs_root);
> > >   		goto root_err;
> > > +	}
> > >   	ret = kobject_init_and_add(&erofs_feat, &erofs_feat_ktype,
> > >   				   NULL, "features");
> > > -- 
> > > 2.25.1
