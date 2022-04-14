Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 753A1500803
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Apr 2022 10:10:33 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KfBwR3Xskz2ymb
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Apr 2022 18:10:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=M5KQ7mfZ;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::d2e;
 helo=mail-io1-xd2e.google.com; envelope-from=zhangjiachen.jaycee@bytedance.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=bytedance-com.20210112.gappssmtp.com
 header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=M5KQ7mfZ; dkim-atps=neutral
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KfBwM1sJSz2xY0
 for <linux-erofs@lists.ozlabs.org>; Thu, 14 Apr 2022 18:10:24 +1000 (AEST)
Received: by mail-io1-xd2e.google.com with SMTP id x4so4573267iop.7
 for <linux-erofs@lists.ozlabs.org>; Thu, 14 Apr 2022 01:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=80GuG9Z2OB5edjjpunkIyc1yhfEaarhhzGyq+14i704=;
 b=M5KQ7mfZv6mFYhtnrBqG00dB7LnKFIRZKqw/pvrepjt7LV24VvlIxp5D7/Zz+9yyXR
 pcPjKG43Q7cC/d27eRU9Uby1RPUAJagk37XLqjEYf0jrR3uZ0NTRg/BqxNix5DT830yN
 blUsYDqUPI6g4xemqC5mcga57q1wFsimEU2d4ClWinFeFdloxNm4+KyNvyrmWGeB7TnC
 xOngQ5jnzDeIF3XJ7SWRDm7xX90JSeRdnTrSeQO2u/JsNzoe4X1kiUvv2BWKzItBFiOn
 VNF2kjjlqE1CGO8JP7USrdhkvHGrgL56OIwU5At1X5HRheWcOfAqA91iYGuCnSiVo0A1
 mlsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=80GuG9Z2OB5edjjpunkIyc1yhfEaarhhzGyq+14i704=;
 b=Axy7/FlGlCbUV9y4ZXfb+Mu/4Io+nwbjlQWlYWtRrUhT4wY/Xp9cmOFg4JlbJ6c0Uw
 w3wguHcHGe5Mv60hHZ2xWJGReafOWcuZit69xZBJzx2yNOqUTkzceZbapfiSJhGgQ5YD
 AgSTa6YNtz/4xREL/Jn/BEOB5s4jgo5V2dVf9ttGOYfXkKqmf4AsE+c70u2TqiiCDvcJ
 8dcl1r6E/Fa//7dPJ52Y14h5MgmrO2yrqt5xonJEL3rM8QUtKYrb8qFHt6/YH6reN4AJ
 dhRdtGIeWI2v5yv8D6klqAdJecRSorFmGW5kEGXSlQsnwmJQtLskYqzSDasruXDN+mY7
 TB8A==
X-Gm-Message-State: AOAM533n+a98qU7GTGYupnHBYRzw93MnO+1soEyzqANfYqYlLtBgny1p
 wLaJmNfmW4682KRBDLbTbzZ/9gkthRmb1BDOTcDpnA==
X-Google-Smtp-Source: ABdhPJyQyyUIJu7HSaI/sHH6jgGH90kBT3f1SyDRMUnKe+RNtKh/8DVg+hrLhzrO3qrrF7NYPZxCyZP+Y63gqiTXviI=
X-Received: by 2002:a05:6638:3e8f:b0:326:72cb:2b49 with SMTP id
 ch15-20020a0566383e8f00b0032672cb2b49mr715190jab.247.1649923821659; Thu, 14
 Apr 2022 01:10:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220406075612.60298-1-jefflexu@linux.alibaba.com>
 <YlLS47A9TpHyZJQi@B-P7TQMD6M-0146.local>
In-Reply-To: <YlLS47A9TpHyZJQi@B-P7TQMD6M-0146.local>
From: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Date: Thu, 14 Apr 2022 16:10:10 +0800
Message-ID: <CAFQAk7iUuaUL40NGzOkCOL=P9d6PgsDjRoKLs_5KDycaA9RQ4w@mail.gmail.com>
Subject: Re: Re: [PATCH v8 00/20] fscache,
 erofs: fscache-based on-demand read semantics
To: Jeffle Xu <jefflexu@linux.alibaba.com>, dhowells@redhat.com, 
 linux-cachefs@redhat.com, xiang@kernel.org, chao@kernel.org, 
 linux-erofs@lists.ozlabs.org, torvalds@linux-foundation.org, 
 gregkh@linuxfoundation.org, willy@infradead.org, 
 linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com, 
 bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com, gerry@linux.alibaba.com, 
 eguan@linux.alibaba.com, linux-kernel@vger.kernel.org, 
 luodaowen.backend@bytedance.com, tianzichen@kuaishou.com, fannaihao@baidu.com
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
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sun, Apr 10, 2022 at 8:52 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>
> On Wed, Apr 06, 2022 at 03:55:52PM +0800, Jeffle Xu wrote:
> > changes since v7:
> > - rebased to 5.18-rc1
> > - include "cachefiles: unmark inode in use in error path" patch into
> >   this patchset to avoid warning from test robot (patch 1)
> > - cachefiles: rename [cookie|volume]_key_len field of struct
> >   cachefiles_open to [cookie|volume]_key_size to avoid potential
> >   misunderstanding. Also add more documentation to
> >   include/uapi/linux/cachefiles.h. (patch 3)
> > - cachefiles: valid check for error code returned from user daemon
> >   (patch 3)
> > - cachefiles: change WARN_ON_ONCE() to pr_info_once() when user daemon
> >   closes anon_fd prematurely (patch 4/5)
> > - ready for complete review
> >
> >
> > Kernel Patchset
> > ---------------
> > Git tree:
> >
> >     https://github.com/lostjeffle/linux.git jingbo/dev-erofs-fscache-v8
> >
> > Gitweb:
> >
> >     https://github.com/lostjeffle/linux/commits/jingbo/dev-erofs-fscache-v8
> >
> >
> > User Daemon for Quick Test
> > --------------------------
> > Git tree:
> >
> >     https://github.com/lostjeffle/demand-read-cachefilesd.git main
> >
> > Gitweb:
> >
> >     https://github.com/lostjeffle/demand-read-cachefilesd
> >
>
> Btw, we've also finished a preliminary end-to-end on-demand download
> daemon in order to test the fscache on-demand kernel code as a real
> end-to-end workload for container use cases:
>
> User guide: https://github.com/dragonflyoss/image-service/blob/fscache/docs/nydus-fscache.md
> Video: https://youtu.be/F4IF2_DENXo
>
> Thanks,
> Gao Xiang

Hi Xiang,

I think this feature is interesting and promising. So I have performed
some tests according to the user guide. Hope it can be an upstream
feature.

Thanks,
Jiachen
