Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6DF4D9B24
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Mar 2022 13:26:15 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KHt1K2m5tz30Dp
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Mar 2022 23:26:13 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133;
 helo=out30-133.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-133.freemail.mail.aliyun.com
 (out30-133.freemail.mail.aliyun.com [115.124.30.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KHt194NvHz2xVq
 for <linux-erofs@lists.ozlabs.org>; Tue, 15 Mar 2022 23:26:02 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R201e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=8; SR=0; TI=SMTPD_---0V7I11eB_1647347151; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V7I11eB_1647347151) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 15 Mar 2022 20:25:53 +0800
Date: Tue, 15 Mar 2022 20:25:51 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Dongliang Mu <mudongliangabcd@gmail.com>
Subject: Re: [PATCH] fs: erofs: remember if kobject_init_and_add was done
Message-ID: <YjCFz1dxVJZnF3M/@B-P7TQMD6M-0146.local>
References: <20220315075152.63789-1-dzm91@hust.edu.cn>
 <bca8f865-bc3e-44d7-7298-c2c7e8973580@gmail.com>
 <YjBwtqsEOZ5JbqvS@B-P7TQMD6M-0146.local>
 <8d832e7a-c8da-d2fa-571a-ea150b8deb1b@gmail.com>
 <CAD-N9QX2cajf0LXKcOji_Em26-0bw9wfhx7KDV_TLDWhgQ90hQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD-N9QX2cajf0LXKcOji_Em26-0bw9wfhx7KDV_TLDWhgQ90hQ@mail.gmail.com>
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
Cc: Dongliang Mu <dzm91@hust.edu.cn>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 syzkaller <syzkaller@googlegroups.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Dongliang,

On Tue, Mar 15, 2022 at 07:59:26PM +0800, Dongliang Mu wrote:
> On Tue, Mar 15, 2022 at 7:05 PM Huang Jianan <jnhuang95@gmail.com> wrote:
> >
> > 在 2022/3/15 18:55, Gao Xiang 写道:
> > > On Tue, Mar 15, 2022 at 06:43:01PM +0800, Huang Jianan wrote:
> > >> 在 2022/3/15 15:51, Dongliang Mu 写道:
> > >>> From: Dongliang Mu <mudongliangabcd@gmail.com>
> > >>>
> > >>> Syzkaller hit 'WARNING: kobject bug in erofs_unregister_sysfs'. This bug
> > >>> is triggered by injecting fault in kobject_init_and_add of
> > >>> erofs_unregister_sysfs.
> > >>>
> > >>> Fix this by remembering if kobject_init_and_add is successful.
> > >>>
> > >>> Note that I've tested the patch and the crash does not occur any more.
> > >>>
> > >>> Reported-by: syzkaller <syzkaller@googlegroups.com>
> > >>> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > >>> ---
> > >>>    fs/erofs/internal.h | 1 +
> > >>>    fs/erofs/sysfs.c    | 9 ++++++---
> > >>>    2 files changed, 7 insertions(+), 3 deletions(-)
> > >>>
> > >>> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> > >>> index 5aa2cf2c2f80..9e20665e3f68 100644
> > >>> --- a/fs/erofs/internal.h
> > >>> +++ b/fs/erofs/internal.h
> > >>> @@ -144,6 +144,7 @@ struct erofs_sb_info {
> > >>>     u32 feature_incompat;
> > >>>     /* sysfs support */
> > >>> +   bool s_sysfs_inited;
> > >> Hi Dongliang,
> > >>
> > >> How about using sbi->s_kobj.state_in_sysfs to avoid adding a extra member in
> > >> sbi ?
> > > Ok, I have no tendency of these (I'm fine with either ways).
> > > I've seen some usage like:
> > >
> > > static inline int device_is_registered(struct device *dev)
> > > {
> > >          return dev->kobj.state_in_sysfs;
> > > }
> > >
> > > But I'm still not sure if we need to rely on such internal
> > > interface.. More thoughts?
> >
> > Yeah... It seems that it is better to use some of the interfaces
> > provided by kobject,
> > otherwise we should still maintain this state in sbi.
> >
> 
> I am fine with either way. Let me know if you reach to an agreement.

If you have time, would you mind sending another patch by using
state_in_sysfs? I'd like to know Chao's perference later, and
apply one of them...

Thanks,
Gao Xiang

