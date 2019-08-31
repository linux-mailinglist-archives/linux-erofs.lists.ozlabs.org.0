Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A05A42CF
	for <lists+linux-erofs@lfdr.de>; Sat, 31 Aug 2019 08:35:11 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46L6632zGfzDqZD
	for <lists+linux-erofs@lfdr.de>; Sat, 31 Aug 2019 16:35:07 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::c43; helo=mail-yw1-xc43.google.com;
 envelope-from=amir73il@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="cG4yS7h+"; 
 dkim-atps=neutral
Received: from mail-yw1-xc43.google.com (mail-yw1-xc43.google.com
 [IPv6:2607:f8b0:4864:20::c43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46L65y2GcLzDqFt
 for <linux-erofs@lists.ozlabs.org>; Sat, 31 Aug 2019 16:35:02 +1000 (AEST)
Received: by mail-yw1-xc43.google.com with SMTP id i207so3144922ywc.9
 for <linux-erofs@lists.ozlabs.org>; Fri, 30 Aug 2019 23:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=w5dRQc/V85HUSdK58SOuqLdOPIPqHI76KYRXadjhW1Q=;
 b=cG4yS7h+dHwCqC7+1d/JcKh3/NJvSD6CdeEW76fj6dxOuSvT9LSkJ8Nw3jmjC0bhZ4
 Sqx+lrDHzXK1l3xs8fjelflWht3rUg9LcY/+nBUGiZep0IuzstbMDRGUXyjzoHG7DxD/
 FpLTH8v7U7hprKh92RiJ0SQhkoJWM2DpwrNuUDnbZXfWbVuLIira7NywHRNsESJFm/vM
 vs/lvXv9Jn61eYBI4hYDyFFou9UMyxS8NTMnjWc4K+2gGiTsaYN980N8H6QvMgMYgx/R
 FNMz2TizJuR2z4eFxtNyFMXeMJJNbhab1gIRpoX9peerBAO98/FPCgrsZ/v87KPz/xsk
 mAhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=w5dRQc/V85HUSdK58SOuqLdOPIPqHI76KYRXadjhW1Q=;
 b=GJeCzJB/Y0KTIcYHVKxaj56AWU70y1GfmAXGWLoSP2CrLa707AQsfFywvcPkIpscgv
 3Mkkc9+0AWbGsQfM4kN2s/XBNlfEglXILMSBCBFP2UxblT0zJ8ow2UR6ITttAfNtrnWG
 AMTCmMml51GiU0g55P6g3UsjtxxuE5+Oe0RTYlLjyiK4+/aN63PNtBN0HRIm7i19QeHM
 9k9EmF399k49sSCRAZOjW9ailRHj/jYLAd12cxSXA1bMC5eO0TvT4rCvynPIrBRxTx0m
 fX7vb34s9elARQhlEgi7LZFVKDHZpiWXlb2ljCOLZKZgL8tHg7zHxdsEfhA/hjf29wvX
 J+2w==
X-Gm-Message-State: APjAAAWdOumsr16dJUhDbjt2V3TeTDv/0xoQNgY7iHa1WF9Z6BbKIws2
 uIRZfDib1tTpLkpCIFM0BkaTgfEygvmUbMQzVCY=
X-Google-Smtp-Source: APXvYqxA5jrG+aw5cnWfvi5zFi4WHO9+wZCHT7+Yz6m0t7DUrxcUd6HDfyHU+ofMYTrsXauHYejNEsuIL56i7wezFkE=
X-Received: by 2002:a81:6c8:: with SMTP id 191mr11928917ywg.181.1567233298135; 
 Fri, 30 Aug 2019 23:34:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190802125347.166018-4-gaoxiang25@huawei.com>
 <20190829101545.GC20598@infradead.org>
 <20190829105048.GB64893@architecture4> <20190830163910.GB29603@infradead.org>
 <20190830171510.GC107220@architecture4>
In-Reply-To: <20190830171510.GC107220@architecture4>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 31 Aug 2019 09:34:44 +0300
Message-ID: <CAOQ4uxichLUsPyg5Fqg-pSL85oqoDFcQHZbzdrkXX_-kK=CjDQ@mail.gmail.com>
Subject: Re: [PATCH v6 03/24] erofs: add super block operations
To: Gao Xiang <gaoxiang25@huawei.com>
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
Cc: devel@driverdev.osuosl.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 linux-erofs@lists.ozlabs.org, Theodore Ts'o <tytso@mit.edu>,
 "Darrick J . Wong" <darrick.wong@oracle.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jan Kara <jack@suse.cz>,
 Dave Chinner <david@fromorbit.com>, David Sterba <dsterba@suse.cz>,
 LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>,
 Miao Xie <miaoxie@huawei.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Pavel Machek <pavel@denx.de>, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Aug 30, 2019 at 8:16 PM Gao Xiang <gaoxiang25@huawei.com> wrote:
>
> Hi Christoph,
>
> On Fri, Aug 30, 2019 at 09:39:10AM -0700, Christoph Hellwig wrote:
> > On Thu, Aug 29, 2019 at 06:50:48PM +0800, Gao Xiang wrote:
> > > > Please use an erofs_ prefix for all your functions.
> > >
> > > It is already a static function, I have no idea what is wrong here.
> >
> > Which part of all wasn't clear?  Have you looked at the prefixes for
> > most functions in the various other big filesystems?
>
> I will add erofs prefix to free_inode as you said.
>
> At least, all non-prefix functions in erofs are all static functions,
> it won't pollute namespace... I will add "erofs_" to other meaningful
> callbacks...And as you can see...
>
> cifs/cifsfs.c
> 1303:cifs_init_inodecache(void)
> 1509:   rc = cifs_init_inodecache();
>
> hpfs/super.c
> 254:static int init_inodecache(void)
> 771:    int err = init_inodecache();
>
> minix/inode.c
> 84:static int __init init_inodecache(void)
> 665:    int err = init_inodecache();
>

Hi Gao,

"They did it first" is never a good reply for code review comments.
Nobody cares if you copy&paste code with init_inodecache().
I understand why you thought static function names do not pollute
the (linker) namespace, but they do pollute the global namespace.

free_inode() as a local function name is one of the worst examples
for VFS namespace pollution.

VFS code uses function names like those a lot in the global namespace, e.g.:
clear_inode(),new_inode().

For example from recent history of namespace collision caused by your line
of thinking, see:
e6fd2093a85d md: namespace private helper names

Besides, you really have nothing to loose from prefixing everything
with erofs_, do you? It's better for review, for debugging...

Thanks,
Amir.
