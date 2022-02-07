Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EF44D4ACBA1
	for <lists+linux-erofs@lfdr.de>; Mon,  7 Feb 2022 22:51:00 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Jt0FZ51Zfz3050
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Feb 2022 08:50:58 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Jt0FW0GsTz2xYQ
 for <linux-erofs@lists.ozlabs.org>; Tue,  8 Feb 2022 08:50:51 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=5; SR=0; TI=SMTPD_---0V3t8jDM_1644270640; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V3t8jDM_1644270640) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 08 Feb 2022 05:50:42 +0800
Date: Tue, 8 Feb 2022 05:50:39 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Kelvin Zhang <zhangkelvin@google.com>
Subject: Re: [PATCH v1] erofs-utils: lib: Fix 8MB bug on uncompressed extent
 size
Message-ID: <YgGUL3aWmPmBvJ7z@B-P7TQMD6M-0146.local>
References: <20211222020307.273150-1-zhangkelvin@google.com>
 <YgBg9mjAxi5aPSW6@B-P7TQMD6M-0146.local>
 <YgB+/+xCCjqT6AQO@B-P7TQMD6M-0146.local>
 <CAOSmRzjGFpxq4MUAKC0TFeRP_R8=gZUtA0J2yefWhdmij-8FhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOSmRzjGFpxq4MUAKC0TFeRP_R8=gZUtA0J2yefWhdmij-8FhA@mail.gmail.com>
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

On Mon, Feb 07, 2022 at 09:38:45AM -0800, Kelvin Zhang wrote:
> -1
> 
> On Sun, Feb 6, 2022 at 6:08 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> >
> > On Mon, Feb 07, 2022 at 07:59:50AM +0800, Gao Xiang wrote:
> > > Hi Kelvin,
> > >
> > > On Tue, Dec 21, 2021 at 06:03:07PM -0800, Kelvin Zhang wrote:
> > > > Previously, uncompressed extent can be at most 8MB before mkfs.erofs
> > > > crashes on some error condition. This is due to a minor bug in how
> > > > compressed indices are encoded. This patch fixes the issue.
> > > >
> > > > Signed-off-by: Kelvin Zhang <zhangkelvin@google.com>
> > > > ---
> > > >  include/erofs_fs.h |  2 +-
> > > >  lib/compress.c     | 21 ++++++++++++++++++++-
> > > >  2 files changed, 21 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/include/erofs_fs.h b/include/erofs_fs.h
> > > > index 9a91877..13eaf24 100644
> > > > --- a/include/erofs_fs.h
> > > > +++ b/include/erofs_fs.h
> > > > @@ -353,7 +353,7 @@ enum {
> > > >   * compressed block count of a compressed extent (in logical clusters, aka.
> > > >   * block count of a pcluster).
> > > >   */
> > > > -#define Z_EROFS_VLE_DI_D0_CBLKCNT          (1 << 11)
> > > > +#define Z_EROFS_VLE_DI_D0_CBLKCNT          (1U << 11)
> > >
> > > If erofs_fs.h update is necessary, I prefer to update in-kernel
> > > header first. Would you mind making a kernel patch for this if needed?
> 
> Reverted erofs_fs.h change.
> 
> > >
> > > >
> > > >  struct z_erofs_vle_decompressed_index {
> > > >     __le16 di_advise;
> > > > diff --git a/lib/compress.c b/lib/compress.c
> > > > index 98be7a2..23e571c 100644
> > > > --- a/lib/compress.c
> > > > +++ b/lib/compress.c
> > > > @@ -97,7 +97,26 @@ static void vle_write_indexes(struct z_erofs_vle_compress_ctx *ctx,
> > > >             } else if (d0) {
> > > >                     type = Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD;
> > > >
> > > > -                   di.di_u.delta[0] = cpu_to_le16(d0);
> > > > +                   /* If the |Z_EROFS_VLE_DI_D0_CBLKCNT| bit is set, parser
> > > > +                    * will interpret |delta[0]| as size of pcluster, rather
> > > > +                    * than distance to last head cluster. Normally this
> > > > +                    * isn't a problem, because uncompressed extent size are
> > > > +                    * below Z_EROFS_VLE_DI_D0_CBLKCNT * BLOCK_SIZE = 8MB.
> > > > +                    * But with large pcluster it's possible to go over this
> > > > +                    * number, resulting in corrupted compressed indices.
> > > > +                    * To solve this, we use Z_EROFS_VLE_DI_D0_CBLKCNT-1 if
> > > > +                    * the uncompressed extent size goes above 8MB. This is
> > > > +                    * OK because if kernel sees another non-head cluster
> > > > +                    * after going back by |delta[0]| blocks, kernel will
> > > > +                    * just keep looking back.
> > > > +                    */
> > >
> > > Would you mind updating this into the kernel comment style, I mean
> > > /*
> > >  * ...
> > >  */
> > > Instead?
> 
> Done
> 
> > >
> > > > +                   if (d0 & Z_EROFS_VLE_DI_D0_CBLKCNT) {
> > > > +                           di.di_u.delta[0] = max(
> > > > +                                   d0 & (~Z_EROFS_VLE_DI_D0_CBLKCNT),
> > > > +                                   Z_EROFS_VLE_DI_D0_CBLKCNT-1);
> > >
> > > May I ask if it's actually tested with big pcluster feature? It's
> > > lack of cpu_to_le16() convert and even the original
> > > Z_EROFS_VLE_DI_D0_CBLKCNT flag.
> 
> Sorry.. It was tested on a Little Endian machine, so I didn't discover
> the missing cpu_to_le16. Added now.
> 
> >
> > Sorry this part shouldn't have Z_EROFS_VLE_DI_D0_CBLKCNT flag.
> >
> > Btw, I think a proper change for this might be just:
> >         if (d0 > Z_EROFS_VLE_DI_D0_CBLKCNT - 1)
> >                 di.di_u.delta[0] = le16_to_cpu(Z_EROFS_VLE_DI_D0_CBLKCNT - 1);
> >         else
> >                 di.di_u.delta[0] = cpu_to_le16(d0);
> > Or using max() to simplify above even more a bit.
> 
> This would work, but it's not optimal. For example,
> Z_EROFS_VLE_DI_D0_CBLKCNT << 1
> is greater than Z_EROFS_VLE_DI_D0_CBLKCNT, but it does not have the
> 11th bit set.
> Using Z_EROFS_VLE_DI_D0_CBLKCNT-1 in this case would cause the kernel to
> take more hops than necessary when finding the head cluster. A better
> change would be:
> 
>         if (d0 > Z_EROFS_VLE_DI_D0_CBLKCNT - 1)
>                 di.di_u.delta[0] = le16_to_cpu(largest number smaller
> than d0 that does not have Z_EROFS_VLE_DI_D0_CBLKCNT bit set);
>         else
>                 di.di_u.delta[0] = cpu_to_le16(d0);
> 
> But how do we find "largest number smaller than d0 that does not have
> Z_EROFS_VLE_DI_D0_CBLKCNT bit set" ?
> Simple, clear the Z_EROFS_VLE_DI_D0_CBLKCNT bit, and set all bits
> before that to 1. In code:
> d0 & (~ Z_EROFS_VLE_DI_D0_CBLKCNT) | (Z_EROFS_VLE_DI_D0_CBLKCNT-1)
> 
> So final answer:
> 
>         if (d0 > Z_EROFS_VLE_DI_D0_CBLKCNT - 1)
>                 di.di_u.delta[0] = le16_to_cpu(d0 & (~
> Z_EROFS_VLE_DI_D0_CBLKCNT) | (Z_EROFS_VLE_DI_D0_CBLKCNT-1));
>         else
>                 di.di_u.delta[0] = cpu_to_le16(d0);
> 

That may work for non-compact indexes, but it's somewhat unsafe for
compact indexes (especially compact 2B), since the valid bits for
each lcluster are 14 (12 plus 2-bit lcluster type):
  for head lclusters, it stores lclusterofs;
  for non-head lclusters, it stores delta0 (lookback distance) or
                                    delta1 (lookforward distance)
                          conditionally.

That is also why Z_EROFS_VLE_DI_D0_CBLKCNT is set as (1 << 11). So in
order to make them unique, I suggest just don't reuse higher bits even
for non-compact indexes... (I think we could stand just looking back
multiple times instead for such large logical extents...)

Actually "* eg. for 4k page-sized cluster, maximum 4K*64k = 256M)" is
somewhat outdated now after compact-indexes was introduced. If you
have time, could you submit a kernel patch to fix the description
together?

Thanks,
Gao Xiang
