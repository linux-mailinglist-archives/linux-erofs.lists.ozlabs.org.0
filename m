Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 118C14D99BC
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Mar 2022 11:56:14 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KHr1R6wHLz30Dy
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Mar 2022 21:56:11 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130;
 helo=out30-130.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KHr1J5Lnlz2y7M
 for <linux-erofs@lists.ozlabs.org>; Tue, 15 Mar 2022 21:56:01 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R411e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=8; SR=0; TI=SMTPD_---0V7HTLPm_1647341751; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V7HTLPm_1647341751) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 15 Mar 2022 18:55:53 +0800
Date: Tue, 15 Mar 2022 18:55:50 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Huang Jianan <jnhuang95@gmail.com>
Subject: Re: [PATCH] fs: erofs: remember if kobject_init_and_add was done
Message-ID: <YjBwtqsEOZ5JbqvS@B-P7TQMD6M-0146.local>
References: <20220315075152.63789-1-dzm91@hust.edu.cn>
 <bca8f865-bc3e-44d7-7298-c2c7e8973580@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bca8f865-bc3e-44d7-7298-c2c7e8973580@gmail.com>
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
Cc: Dongliang Mu <dzm91@hust.edu.cn>, Dongliang Mu <mudongliangabcd@gmail.com>,
 linux-kernel@vger.kernel.org, syzkaller <syzkaller@googlegroups.com>,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Mar 15, 2022 at 06:43:01PM +0800, Huang Jianan wrote:
> 在 2022/3/15 15:51, Dongliang Mu 写道:
> > From: Dongliang Mu <mudongliangabcd@gmail.com>
> > 
> > Syzkaller hit 'WARNING: kobject bug in erofs_unregister_sysfs'. This bug
> > is triggered by injecting fault in kobject_init_and_add of
> > erofs_unregister_sysfs.
> > 
> > Fix this by remembering if kobject_init_and_add is successful.
> > 
> > Note that I've tested the patch and the crash does not occur any more.
> > 
> > Reported-by: syzkaller <syzkaller@googlegroups.com>
> > Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > ---
> >   fs/erofs/internal.h | 1 +
> >   fs/erofs/sysfs.c    | 9 ++++++---
> >   2 files changed, 7 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> > index 5aa2cf2c2f80..9e20665e3f68 100644
> > --- a/fs/erofs/internal.h
> > +++ b/fs/erofs/internal.h
> > @@ -144,6 +144,7 @@ struct erofs_sb_info {
> >   	u32 feature_incompat;
> >   	/* sysfs support */
> > +	bool s_sysfs_inited;
> 
> Hi Dongliang,
> 
> How about using sbi->s_kobj.state_in_sysfs to avoid adding a extra member in
> sbi ?

Ok, I have no tendency of these (I'm fine with either ways).
I've seen some usage like:

static inline int device_is_registered(struct device *dev)
{
        return dev->kobj.state_in_sysfs;
}

But I'm still not sure if we need to rely on such internal
interface.. More thoughts?

Thanks,
Gao Xiang

> 
> Thanks,
> Jianan
> 
> >   	struct kobject s_kobj;		/* /sys/fs/erofs/<devname> */
> >   	struct completion s_kobj_unregister;
> >   };
> > diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
> > index dac252bc9228..2b48a4df19b4 100644
> > --- a/fs/erofs/sysfs.c
> > +++ b/fs/erofs/sysfs.c
> > @@ -209,6 +209,7 @@ int erofs_register_sysfs(struct super_block *sb)
> >   				   "%s", sb->s_id);
> >   	if (err)
> >   		goto put_sb_kobj;
> > +	sbi->s_sysfs_inited = true;
> >   	return 0;
> >   put_sb_kobj:
> > @@ -221,9 +222,11 @@ void erofs_unregister_sysfs(struct super_block *sb)
> >   {
> >   	struct erofs_sb_info *sbi = EROFS_SB(sb);
> > -	kobject_del(&sbi->s_kobj);
> > -	kobject_put(&sbi->s_kobj);
> > -	wait_for_completion(&sbi->s_kobj_unregister);
> > +	if (sbi->s_sysfs_inited) {
> > +		kobject_del(&sbi->s_kobj);
> > +		kobject_put(&sbi->s_kobj);
> > +		wait_for_completion(&sbi->s_kobj_unregister);
> > +	}
> >   }
> >   int __init erofs_init_sysfs(void)
