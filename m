Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FADC58DF57
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Aug 2022 20:47:30 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4M2MWM29rmz307g
	for <lists+linux-erofs@lfdr.de>; Wed, 10 Aug 2022 04:47:27 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.44; helo=out30-44.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4M2MWH5yjsz2xHC
	for <linux-erofs@lists.ozlabs.org>; Wed, 10 Aug 2022 04:47:22 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VLqpLoL_1660070835;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VLqpLoL_1660070835)
          by smtp.aliyun-inc.com;
          Wed, 10 Aug 2022 02:47:17 +0800
Date: Wed, 10 Aug 2022 02:47:15 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Naoto Yamaguchi <wata2ki@gmail.com>
Subject: Re: RFC: erofs-utils:mkfs: add unprivileged container use-case
 support
Message-ID: <YvKrs6J5zBPzFYpF@B-P7TQMD6M-0146.local>
References: <CABBJnRbpAxGB644x=fBRK5GOrjxYawZE-zrhHnRHQbz5Lzp-CQ@mail.gmail.com>
 <YvKj8aZp/6bg/Nxv@debian>
 <CABBJnRaP8XWbKiYVxbtdiJ0ViFz0hhkwTPnBA004aetZx_5nhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBJnRaP8XWbKiYVxbtdiJ0ViFz0hhkwTPnBA004aetZx_5nhQ@mail.gmail.com>
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
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Aug 10, 2022 at 03:37:59AM +0900, Naoto Yamaguchi wrote:
> Hi Gao
> 
> Thank you for your response.
> 
> > Could you give more details about this? EROFS already supports idmapped
> > mount for container use cases since 5.19, so I guess uid/gid offsets
> > can be set by this?
> 
> It's good news for me.  I  investigated LTS version 5.10 and 5.15.  I
> didn’t know this new feature.
> 
> My work detail, it's easy to share experimental patch in my github.
> https://github.com/AGLExport/erofs-utils/commit/d9080b80152c2f9065d98a7a2ac36912c74657ac

The patch itself looks good to me (some minor, should we use signed
integers instead? I'm not sure if some use cases need to shift down
instead.. Also need to add some words to mkfs manpage).

Feel free to submit patch, thanks for contribution in advance!

Thanks,
Gao Xiang

> 
> That will use combination with lxc idmap option.
> 
> ex:
> Image creation
> mkafs.erofs --uid-offset=100000 --gid-offset=100000 .....
> 
> Lxc config
> lxc.idmap = u 0 100000 65536
> lxc.idmap = g 0 100000 65536
> 
> 
> Thanks,
> Naoto Yamaguchi,
> a member of Automotive Grade Linux Instrument Cluster EG.
