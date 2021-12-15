Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C7A475152
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Dec 2021 04:22:57 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JDLCz1jpJz2yyv
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Dec 2021 14:22:55 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.44;
 helo=out30-44.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-44.freemail.mail.aliyun.com
 (out30-44.freemail.mail.aliyun.com [115.124.30.44])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JDLCr4wqwz2yfc
 for <linux-erofs@lists.ozlabs.org>; Wed, 15 Dec 2021 14:22:47 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R711e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04423; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=6; SR=0; TI=SMTPD_---0V-gWq.4_1639538549; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V-gWq.4_1639538549) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 15 Dec 2021 11:22:30 +0800
Date: Wed, 15 Dec 2021 11:22:28 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Huang Jianan <huangjianan@oppo.com>
Subject: Re: [PATCH v2 1/2] erofs-utils: sort shared xattr
Message-ID: <YblfdNxSEBhx6b3T@B-P7TQMD6M-0146.local>
References: <YXE30+2qU75+0szk@B-P7TQMD6M-0146.local>
 <20211214095202.11717-1-huangjianan@oppo.com>
 <Ybi4was1yPMNlNqV@B-P7TQMD6M-0146.local>
 <2decd4e7-506f-6156-15b0-148ba5cb3089@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2decd4e7-506f-6156-15b0-148ba5cb3089@oppo.com>
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
Cc: yh@oppo.com, guoweichao@oppo.com, linux-erofs@lists.ozlabs.org,
 zhangshiming@oppo.com, guanyuwei@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Dec 15, 2021 at 10:43:40AM +0800, Huang Jianan via Linux-erofs wrote:
> Hi Xiang,
> 
> 在 2021/12/14 23:31, Gao Xiang 写道:
> > Hi Jianan,
> > 
> > On Tue, Dec 14, 2021 at 05:52:01PM +0800, Huang Jianan via Linux-erofs wrote:
> > > Sort shared xattr before writing to disk to ensure the consistency
> > > of reproducible builds.
> > > 
> > > Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> > I still fail to understand why the order of shared xattrs will be
> > a problem of reproducible builds.
> > 
> > IOWs, if the order of shared xattrs is really a problem, do we need
> > to sort inline xattrs as well? Or do you have some reproducer to
> > show why the order of shared xattrs can be changed if the filesystem
> > of srcdir isn't changed?
> We discovered this problem when we built the same image content on
> different machines.
> 
> After executing readdir, the order of the subdirectories returned by the
> two machines is different, which leads to a difference in the order of
> shared
> xattr. I'm not sure if this scene can be called reproducible build in the
> strict
> sense.
> 
> In addition, since the problem is caused by the readdir sequence, it should
> have no effect on inline xattr.

So it sounds like we need to optimize xattr readdir process instead?

Thanks,
Gao Xiang

> 
> Thanks,
> Jianan
> > Thanks,
> > Gao Xiang
> > 
