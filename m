Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5B05009DB
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Apr 2022 11:29:50 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KfDgw5R5Hz2yZv
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Apr 2022 19:29:48 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.45;
 helo=out30-45.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-45.freemail.mail.aliyun.com
 (out30-45.freemail.mail.aliyun.com [115.124.30.45])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KfDgn0glVz2xKT
 for <linux-erofs@lists.ozlabs.org>; Thu, 14 Apr 2022 19:29:37 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R181e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=20; SR=0; TI=SMTPD_---0VA1uGiX_1649928564; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0VA1uGiX_1649928564) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 14 Apr 2022 17:29:27 +0800
Date: Thu, 14 Apr 2022 17:29:24 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Subject: Re: Re: [PATCH v8 00/20] fscache, erofs: fscache-based on-demand read
 semantics
Message-ID: <YlfpdAjfRclK4aLQ@B-P7TQMD6M-0146.local>
Mail-Followup-To: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>,
 Jeffle Xu <jefflexu@linux.alibaba.com>, dhowells@redhat.com,
 linux-cachefs@redhat.com, xiang@kernel.org, chao@kernel.org,
 linux-erofs@lists.ozlabs.org, torvalds@linux-foundation.org,
 gregkh@linuxfoundation.org, willy@infradead.org,
 linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
 bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
 gerry@linux.alibaba.com, eguan@linux.alibaba.com,
 linux-kernel@vger.kernel.org, luodaowen.backend@bytedance.com,
 tianzichen@kuaishou.com, fannaihao@baidu.com
References: <20220406075612.60298-1-jefflexu@linux.alibaba.com>
 <YlLS47A9TpHyZJQi@B-P7TQMD6M-0146.local>
 <CAFQAk7iUuaUL40NGzOkCOL=P9d6PgsDjRoKLs_5KDycaA9RQ4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFQAk7iUuaUL40NGzOkCOL=P9d6PgsDjRoKLs_5KDycaA9RQ4w@mail.gmail.com>
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
Cc: tianzichen@kuaishou.com, joseph.qi@linux.alibaba.com,
 torvalds@linux-foundation.org, fannaihao@baidu.com, willy@infradead.org,
 linux-kernel@vger.kernel.org, dhowells@redhat.com,
 linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
 gregkh@linuxfoundation.org, luodaowen.backend@bytedance.com,
 gerry@linux.alibaba.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Jiachen,

On Thu, Apr 14, 2022 at 04:10:10PM +0800, Jiachen Zhang wrote:
> On Sun, Apr 10, 2022 at 8:52 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> >
> > On Wed, Apr 06, 2022 at 03:55:52PM +0800, Jeffle Xu wrote:
> > > changes since v7:
> > > - rebased to 5.18-rc1
> > > - include "cachefiles: unmark inode in use in error path" patch into
> > >   this patchset to avoid warning from test robot (patch 1)
> > > - cachefiles: rename [cookie|volume]_key_len field of struct
> > >   cachefiles_open to [cookie|volume]_key_size to avoid potential
> > >   misunderstanding. Also add more documentation to
> > >   include/uapi/linux/cachefiles.h. (patch 3)
> > > - cachefiles: valid check for error code returned from user daemon
> > >   (patch 3)
> > > - cachefiles: change WARN_ON_ONCE() to pr_info_once() when user daemon
> > >   closes anon_fd prematurely (patch 4/5)
> > > - ready for complete review
> > >
> > >
> > > Kernel Patchset
> > > ---------------
> > > Git tree:
> > >
> > >     https://github.com/lostjeffle/linux.git jingbo/dev-erofs-fscache-v8
> > >
> > > Gitweb:
> > >
> > >     https://github.com/lostjeffle/linux/commits/jingbo/dev-erofs-fscache-v8
> > >
> > >
> > > User Daemon for Quick Test
> > > --------------------------
> > > Git tree:
> > >
> > >     https://github.com/lostjeffle/demand-read-cachefilesd.git main
> > >
> > > Gitweb:
> > >
> > >     https://github.com/lostjeffle/demand-read-cachefilesd
> > >
> >
> > Btw, we've also finished a preliminary end-to-end on-demand download
> > daemon in order to test the fscache on-demand kernel code as a real
> > end-to-end workload for container use cases:
> >
> > User guide: https://github.com/dragonflyoss/image-service/blob/fscache/docs/nydus-fscache.md
> > Video: https://youtu.be/F4IF2_DENXo
> >
> > Thanks,
> > Gao Xiang
> 
> Hi Xiang,
> 
> I think this feature is interesting and promising. So I have performed
> some tests according to the user guide. Hope it can be an upstream
> feature.

Many thanks for the feedback. We're doing our best to form/stablize it
now. Still struggle with some specific cases.

Thanks,
Gao Xiang


> 
> Thanks,
> Jiachen
