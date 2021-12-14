Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C812473B5F
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Dec 2021 04:15:14 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JCk5X3D7Hz304y
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Dec 2021 14:15:12 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131;
 helo=out30-131.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JCk5P4j1nz2yfZ
 for <linux-erofs@lists.ozlabs.org>; Tue, 14 Dec 2021 14:15:03 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R601e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04357; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=5; SR=0; TI=SMTPD_---0V-aHBZc_1639451695; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V-aHBZc_1639451695) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 14 Dec 2021 11:14:56 +0800
Date: Tue, 14 Dec 2021 11:14:54 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Kelvin Zhang <zhangkelvin@google.com>
Subject: Re: [PATCH v3 2/2] Add API to iterate over inodes in EROFS
Message-ID: <YbgMLtaDEEH+X5/W@B-P7TQMD6M-0146.local>
References: <20211214004311.GA2891@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20211214021955.992899-1-zhangkelvin@google.com>
 <20211214021955.992899-2-zhangkelvin@google.com>
 <CAOSmRzjd4j+Zus+cnor+X0bwMbdBGp4V=Pm89Co0_BeH=mt6FQ@mail.gmail.com>
 <YbgGdXD0yYpE4B5Y@B-P7TQMD6M-0146.local>
 <CAOSmRzh4VgVVbwSSoRwi3B589qrQ0AFMDSJa+honkNkf3V3asg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOSmRzh4VgVVbwSSoRwi3B589qrQ0AFMDSJa+honkNkf3V3asg@mail.gmail.com>
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
Cc: Miao Xie <miaoxie@huawei.com>,
 linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Dec 13, 2021 at 06:59:28PM -0800, Kelvin Zhang wrote:
> I think we still need parent_nid to skip "." and ".." directories
> correctly? Let's leave these parameters there.

We could also just skip these by the name ("." and "..") instead
of nids. parent nid is just for sanity check.

Thanks,
Gao Xiang

> 
> On Mon, Dec 13, 2021 at 6:50 PM Gao Xiang <hsiangkao@linux.alibaba.com>
> wrote:
> 
> > On Mon, Dec 13, 2021 at 06:25:09PM -0800, Kelvin Zhang wrote:
> > > Fixed most of the issues you pointed out. Except I didn't quite
> > understand
> > > the "nid is optional unless we do a fsck." part. Not sure how we can
> > > implement the iterate dir function w/o nid. Can you provide more context?
> >
> > There were two nids there, parent_nid and nid. I meant you could leave
> > dir nid (no matter how it's called) mandatorily. dir's parent nid is
> > optional.
> >
> > Sorry if I made some confusion at that time.
> >
> > Thanks,
> > Gao Xiang
> >
> 
> 
> -- 
> Sincerely,
> 
> Kelvin Zhang
