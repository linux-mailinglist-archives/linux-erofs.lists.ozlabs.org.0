Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9CC4A69E1
	for <lists+linux-erofs@lfdr.de>; Wed,  2 Feb 2022 03:19:45 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JpQVQ6zN7z30L1
	for <lists+linux-erofs@lfdr.de>; Wed,  2 Feb 2022 13:19:42 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JpQVG4hVmz2yLP
 for <linux-erofs@lists.ozlabs.org>; Wed,  2 Feb 2022 13:19:31 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R561e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=5; SR=0; TI=SMTPD_---0V3Q.FM2_1643768361; 
Received: from B-P7TQMD6M-0146(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V3Q.FM2_1643768361) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 02 Feb 2022 10:19:23 +0800
Date: Wed, 2 Feb 2022 10:19:21 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Kelvin Zhang <zhangkelvin@google.com>
Subject: Re: [PATCH v1] erofs-utils: don't hard code constants
Message-ID: <YfnqKRr73WjaTvZA@B-P7TQMD6M-0146>
References: <20220131184327.30176-1-zhangkelvin@google.com>
 <YfigFlpvjDBbMsYS@B-P7TQMD6M-0146>
 <CAOSmRzjL=ufHBCcyCxHArizdV8cr0mjuER1CBiYKm5G3CzK6wQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOSmRzjL=ufHBCcyCxHArizdV8cr0mjuER1CBiYKm5G3CzK6wQ@mail.gmail.com>
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

On Tue, Feb 01, 2022 at 02:44:46PM -0800, Kelvin Zhang wrote:
> Thanks Gao! I'm reading compressed indices code recently. Is there any
> notes/sketches/design docs you can share with me regarding that?
> 

There are some kernel commit messages to describe the on-disk format:
ec8c24420501d4cf3ed495c4d026984194897276
b86269f43892316ef5a177d7180d09d101a46f22

And Yue Hu wrote his own notes about compacted indexes (in Chinese):
http://tjtech.me/erofs-compacted-index-generation.html

Hope they are useful! I know that may not enough, I will try to write
more this year.

Thanks,
Gao Xiang

> Happy Chinese New Year!
> 
> On Mon, Jan 31, 2022 at 6:51 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> >
> > On Mon, Jan 31, 2022 at 10:43:27AM -0800, Kelvin Zhang wrote:
> > > Use sizeof(z_erofs_vle_decompressed_index) to compute legacy index count
> > >
> > > Test: th
> > > Signed-off-by: Kelvin Zhang <zhangkelvin@google.com>
> > > ---
> > >  lib/compress.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/lib/compress.c b/lib/compress.c
> > > index 98be7a2..c520a1e 100644
> > > --- a/lib/compress.c
> > > +++ b/lib/compress.c
> > > @@ -359,7 +359,7 @@ int z_erofs_convert_to_compacted_format(struct erofs_inode *inode,
> > >                                                          inode->xattr_isize) +
> > >                                 sizeof(struct z_erofs_map_header);
> > >       const unsigned int totalidx = (legacymetasize -
> > > -                                    Z_EROFS_LEGACY_MAP_HEADER_SIZE) / 8;
> > > +                                    Z_EROFS_LEGACY_MAP_HEADER_SIZE) / sizeof(struct z_erofs_vle_decompressed_index);
> >
> > It would be better to keep 80-char limit rule.
> >
> > Thanks, applied.
> >
> > Happy chinese new year!
> > Gao Xiang
> >
> > >       const unsigned int logical_clusterbits = inode->z_logical_clusterbits;
> > >       u8 *out, *in;
> > >       struct z_erofs_compressindex_vec cv[16];
> > > --
> > > 2.35.0.rc2.247.g8bbb082509-goog
> 
> 
> 
> -- 
> Sincerely,
> 
> Kelvin Zhang
