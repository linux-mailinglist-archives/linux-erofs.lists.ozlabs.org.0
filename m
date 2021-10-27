Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 88DB143D31E
	for <lists+linux-erofs@lfdr.de>; Wed, 27 Oct 2021 22:46:57 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HfgjC3FXBz2ypZ
	for <lists+linux-erofs@lfdr.de>; Thu, 28 Oct 2021 07:46:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel-com.20210112.gappssmtp.com header.i=@intel-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=TxZcat++;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=2607:f8b0:4864:20::529;
 helo=mail-pg1-x529.google.com; envelope-from=dan.j.williams@intel.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel-com.20210112.gappssmtp.com
 header.i=@intel-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=TxZcat++; dkim-atps=neutral
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hfgj53NLqz2xC1
 for <linux-erofs@lists.ozlabs.org>; Thu, 28 Oct 2021 07:46:47 +1100 (AEDT)
Received: by mail-pg1-x529.google.com with SMTP id s136so4157936pgs.4
 for <linux-erofs@lists.ozlabs.org>; Wed, 27 Oct 2021 13:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sJa1X8Nq9O3Y4Jpn6QiA74FKvcIV+C24z8IRQUjGGE0=;
 b=TxZcat++g2F8swI/guncdG9/17Z/6RCDj0O4DaP3V2lEJrBjGy6sZkL1oaiVAPUX7i
 ibRs8fV27ZpLTrAbifA8zRst6y+Kk83j+VEjhNI+Vbneg5PK76uFu3Pt51HYTeEaMMd/
 OOX5Fw0eevNVN84NzUSIfUo21BQoeHWua4n8iiMA5hViXFqIkNINp7tTwt6Va0lJxObQ
 XbAdy+YG2LtzHKedjvpvUxc4S7WGprooI9+nPgi9DghDQrCCLYP8qAZgeT7medHBfAJw
 WFVgaDdPI0CXvVHu3YcuEB3ai43LJghhdT9dLcGlj4W6soszGfdT20P58PyL1vt7VaVP
 hqmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sJa1X8Nq9O3Y4Jpn6QiA74FKvcIV+C24z8IRQUjGGE0=;
 b=U1KZ8uh35HIoquIJx5uSe5Gi8YOV2SCcrU0wlouT4cQ+OeW+FVKGxeUksGApLMnkki
 8BkD4rv19x3cl5t9FYHPox7KDp/jlwrLY4PXJ00r6lAxZVAnXoZjIU09ya64EpnaUB2z
 zrGXpv3MCurztqszKJj8nbrwojxyvGMn2OsTJVRz7SeTmomD6E25z04HUNgBZBtVSYNY
 U0gTajJzrR7sg2p5fXDvUYx4+s2cgDd7rFmkzX/Ne5JMI+yPk/4bX29EhmXPexG8kt2V
 ie98hmeqrCZ/SYSFZxYxWsmSDvKtiYDheY2C1TR5G9ZLtXRXDUy3oKXeHWRF6gdgwwYH
 hDNQ==
X-Gm-Message-State: AOAM531O44JkgYIVjj0PBT3Zeon8KF6dm98v4troJZsv+JPg83H3HA29
 v7UiTHmsWk07f++38dg78GnkwF7uIODMJgn6u9U92w==
X-Google-Smtp-Source: ABdhPJzuYcyzIFqC2QDapdBCh3wTfdWUrlublr2aq9P2i1Emub6ylFDIqTcshjHDL5pSUpWP0gXhlJZ+k6Puz+OdoJE=
X-Received: by 2002:a05:6a00:1348:b0:47c:e8f1:69a3 with SMTP id
 k8-20020a056a00134800b0047ce8f169a3mr433025pfu.86.1635367603066; Wed, 27 Oct
 2021 13:46:43 -0700 (PDT)
MIME-Version: 1.0
References: <20211018044054.1779424-1-hch@lst.de>
In-Reply-To: <20211018044054.1779424-1-hch@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 27 Oct 2021 13:46:31 -0700
Message-ID: <CAPcyv4iEt78-XSsKjTWcpy71zaduXyyigTro6f3fmRqqFOG98Q@mail.gmail.com>
Subject: Re: futher decouple DAX from block devices
To: Christoph Hellwig <hch@lst.de>
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
Cc: Linux NVDIMM <nvdimm@lists.linux.dev>, Mike Snitzer <snitzer@redhat.com>,
 linux-s390 <linux-s390@vger.kernel.org>, linux-erofs@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org,
 linux-xfs <linux-xfs@vger.kernel.org>,
 device-mapper development <dm-devel@redhat.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 linux-ext4 <linux-ext4@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

[ add sfr ]

On Sun, Oct 17, 2021 at 9:41 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Hi Dan,
>
> this series cleans up and simplifies the association between DAX and block
> devices in preparation of allowing to mount file systems directly on DAX
> devices without a detour through block devices.

So I notice that this is based on linux-next while libnvdimm-for-next
is based on v5.15-rc4. Since I'm not Andrew I went ahead and rebased
these onto v5.15-rc4, tested that, and then merged with linux-next to
resolve the conflicts and tested again.

My merge resolution is here [1]. Christoph, please have a look. The
rebase and the merge result are both passing my test and I'm now going
to review the individual patches. However, while I do that and collect
acks from DM and EROFS folks, I want to give Stephen a heads up that
this is coming. Primarily I want to see if someone sees a better
strategy to merge this, please let me know, but if not I plan to walk
Stephen and Linus through the resolution.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/djbw/nvdimm.git/commit/?id=c3894cf6eb8f


>
> Diffstat:
>  drivers/dax/Kconfig          |    4
>  drivers/dax/bus.c            |    2
>  drivers/dax/super.c          |  220 +++++--------------------------------------
>  drivers/md/dm-linear.c       |   51 +++------
>  drivers/md/dm-log-writes.c   |   44 +++-----
>  drivers/md/dm-stripe.c       |   65 +++---------
>  drivers/md/dm-table.c        |   22 ++--
>  drivers/md/dm-writecache.c   |    2
>  drivers/md/dm.c              |   29 -----
>  drivers/md/dm.h              |    4
>  drivers/nvdimm/Kconfig       |    2
>  drivers/nvdimm/pmem.c        |    9 -
>  drivers/s390/block/Kconfig   |    2
>  drivers/s390/block/dcssblk.c |   12 +-
>  fs/dax.c                     |   13 ++
>  fs/erofs/super.c             |   11 +-
>  fs/ext2/super.c              |    6 -
>  fs/ext4/super.c              |    9 +
>  fs/fuse/Kconfig              |    2
>  fs/fuse/virtio_fs.c          |    2
>  fs/xfs/xfs_super.c           |   54 +++++-----
>  include/linux/dax.h          |   30 ++---
>  22 files changed, 185 insertions(+), 410 deletions(-)
