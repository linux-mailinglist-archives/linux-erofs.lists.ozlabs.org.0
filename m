Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F6A47CAE9
	for <lists+linux-erofs@lfdr.de>; Wed, 22 Dec 2021 02:47:19 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JJbmP0b81z2yp9
	for <lists+linux-erofs@lfdr.de>; Wed, 22 Dec 2021 12:47:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1640137637;
	bh=U9EPaaVqSUmJjxuQm7VLIeKenAJZWYo+jeQ0aZRyesk=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Xuhi2yPbJTiviyfsyPlcNdt/mJ+YRlEXmynwLITIEzLsm5hkGl/v4WGGMsjhEV8QH
	 jL5jz6wnu2wNMAGbRyYk2tmf5+FBSEmVUZg2rX/SjUcQk24uzUrv77UeUUlv+qMy8f
	 o/xDDFSzUXiRYF+YVL0nXxGFTl8rZWENZR5to41oKCs57VAFAxeiFWyvicZ4MJgc8J
	 q2QMsY8ya+8RsXDNRAqwavtXMotRUJG8lVwHwRoKIE6UE1+nmwSwoIPvpP17sSRafZ
	 K6U7NP+FSEzOxgZkDXY0mp/dK6q3NqLPv7uWLOiK8We+7lWPxJWRHOOTl/FOoW1V8a
	 b1D0XYUAV9odA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::72e;
 helo=mail-qk1-x72e.google.com; envelope-from=zhangkelvin@google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20210112 header.b=BjJT/eL6; dkim-atps=neutral
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JJbmJ3qYdz2xWd
 for <linux-erofs@lists.ozlabs.org>; Wed, 22 Dec 2021 12:47:11 +1100 (AEDT)
Received: by mail-qk1-x72e.google.com with SMTP id a11so846678qkh.13
 for <linux-erofs@lists.ozlabs.org>; Tue, 21 Dec 2021 17:47:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=U9EPaaVqSUmJjxuQm7VLIeKenAJZWYo+jeQ0aZRyesk=;
 b=yW3EL8+GGWAjwOIIb2qiQDiqrrsCpJRilUuYibIL1709wmptkIvua608F+dHkqIGzC
 P4dMI8YSoYEWxZfJPMwrTxN2i5nD5+oWk2PWW4/CS0lFd25Wud0XiwDBIiUs7L3L05eM
 O8pTDU6Ct90hFMidBm/x4Khg2RcIV+r7QbBN+mJWUkZkV95br5pnBMhFakv7i3p6lsmp
 6Fj7YNMujiPrRhkhKNBKxx7102NBbYTsCARiQX2B1FOdm/atLS31yj2SqXQbFa7AEWvk
 rMuTvkWPyWsbfBwwJsXGVjJVgPySSykvgKk8j6w0sv8U8lLgvGb1l5TeCkTlLjXiAPAW
 9v3g==
X-Gm-Message-State: AOAM530+9SHixhuY8/qI7vXpX56VnX49YHd6jCrsEztIXzvwoP9kIB+P
 bmETmjMRjlCaNyyOAHOfRASY7vHPXMM57oZKdcA6XQ==
X-Google-Smtp-Source: ABdhPJzBZ9jwT8GIO3womeOOsqG/YSx5KO8fgVXvaBukpWHyGWSaGq+HKdZmstFvSAVRFNRawR1gYawJ5evrkLWDEpY=
X-Received: by 2002:a05:620a:440b:: with SMTP id
 v11mr763628qkp.160.1640137629076; 
 Tue, 21 Dec 2021 17:47:09 -0800 (PST)
MIME-Version: 1.0
References: <20211221142829.4123631-1-zhangkelvin@google.com>
 <20211221142829.4123631-2-zhangkelvin@google.com>
 <YcKDYzlMEt01YjdU@B-P7TQMD6M-0146.local>
In-Reply-To: <YcKDYzlMEt01YjdU@B-P7TQMD6M-0146.local>
Date: Tue, 21 Dec 2021 20:46:58 -0500
Message-ID: <CAOSmRzi5rinyzyY84ywF=Yepg2vrHMFY2JvoWQU9WRpVzdjcOQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] Add API to get on disk size of an inode
To: Gao Xiang <hsiangkao@linux.alibaba.com>
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
From: Kelvin Zhang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Kelvin Zhang <zhangkelvin@google.com>
Cc: Miao Xie <miaoxie@huawei.com>,
 linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Not really, dump_get_occupied_size() contains some custom logic for
counting stats.

On Tue, Dec 21, 2021 at 8:46 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>
> On Tue, Dec 21, 2021 at 06:28:29AM -0800, Kelvin Zhang wrote:
> > Change-Id: I60fa9346737b14418bd3fa1d12f760aaf0a0cca5
> > Signed-off-by: Kelvin Zhang <zhangkelvin@google.com>
>
> The same to the previous patch.
>
> Also could we remove dump_get_occupied_size() entirely?
>
> Thanks,
> Gao Xiang
>
> > ---
> >  dump/main.c              |  4 ++--
> >  include/erofs/internal.h |  2 ++
> >  lib/data.c               | 21 +++++++++++++++++++++
> >  3 files changed, 25 insertions(+), 2 deletions(-)
> >
> > diff --git a/dump/main.c b/dump/main.c
> > index 71b44b4..cdde561 100644
> > --- a/dump/main.c
> > +++ b/dump/main.c
> > @@ -175,7 +175,7 @@ static int erofsdump_parse_options_cfg(int argc, char **argv)
> >       return 0;
> >  }
> >
> > -static int erofs_get_occupied_size(struct erofs_inode *inode,
> > +static int dump_get_occupied_size(struct erofs_inode *inode,
> >               erofs_off_t *size)
> >  {
> >       *size = 0;
> > @@ -291,7 +291,7 @@ static int erofs_read_dirent(struct erofs_dirent *de,
> >               return err;
> >       }
> >
> > -     err = erofs_get_occupied_size(&inode, &occupied_size);
> > +     err = dump_get_occupied_size(&inode, &occupied_size);
> >       if (err) {
> >               erofs_err("get file size failed\n");
> >               return err;
> > diff --git a/include/erofs/internal.h b/include/erofs/internal.h
> > index 947304f..8f13e69 100644
> > --- a/include/erofs/internal.h
> > +++ b/include/erofs/internal.h
> > @@ -320,6 +320,8 @@ int erofs_pread(struct erofs_inode *inode, char *buf,
> >  int erofs_map_blocks(struct erofs_inode *inode,
> >               struct erofs_map_blocks *map, int flags);
> >  int erofs_map_dev(struct erofs_sb_info *sbi, struct erofs_map_dev *map);
> > +int erofs_get_occupied_size(const struct erofs_inode *inode,
> > +                         erofs_off_t *size);
> >  /* zmap.c */
> >  int z_erofs_fill_inode(struct erofs_inode *vi);
> >  int z_erofs_map_blocks_iter(struct erofs_inode *vi,
> > diff --git a/lib/data.c b/lib/data.c
> > index 27710f9..92e54b5 100644
> > --- a/lib/data.c
> > +++ b/lib/data.c
> > @@ -320,3 +320,24 @@ int erofs_pread(struct erofs_inode *inode, char *buf,
> >       }
> >       return -EINVAL;
> >  }
> > +
> > +int erofs_get_occupied_size(const struct erofs_inode *inode,
> > +                         erofs_off_t *size)
> > +{
> > +     *size = 0;
> > +     switch (inode->datalayout) {
> > +     case EROFS_INODE_FLAT_INLINE:
> > +     case EROFS_INODE_FLAT_PLAIN:
> > +     case EROFS_INODE_CHUNK_BASED:
> > +             *size = inode->i_size;
> > +             break;
> > +     case EROFS_INODE_FLAT_COMPRESSION_LEGACY:
> > +     case EROFS_INODE_FLAT_COMPRESSION:
> > +             *size = inode->u.i_blocks * EROFS_BLKSIZ;
> > +             break;
> > +     default:
> > +             erofs_err("unknown datalayout");
> > +             return -1;
> > +     }
> > +     return 0;
> > +}
> > --
> > 2.34.1.307.g9b7440fafd-goog



-- 
Sincerely,

Kelvin Zhang
