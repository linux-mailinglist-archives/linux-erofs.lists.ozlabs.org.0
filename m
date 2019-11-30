Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id CB63E10DDFE
	for <lists+linux-erofs@lfdr.de>; Sat, 30 Nov 2019 16:16:08 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47QFM80dzjzDqwH
	for <lists+linux-erofs@lfdr.de>; Sun,  1 Dec 2019 02:16:04 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::443;
 helo=mail-wr1-x443.google.com; envelope-from=fedora.dm0@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="blJjuB+f"; 
 dkim-atps=neutral
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47QFLl1Hz8zDqcx
 for <linux-erofs@lists.ozlabs.org>; Sun,  1 Dec 2019 02:15:40 +1100 (AEDT)
Received: by mail-wr1-x443.google.com with SMTP id j42so12640813wrj.12
 for <linux-erofs@lists.ozlabs.org>; Sat, 30 Nov 2019 07:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=utbS7r3DRmoN8HxQUtiOAPdtm21cO7frIFdAwUFAD9Y=;
 b=blJjuB+fZOwO2PTZd8gmixt1/10HfKaEqh0lyU4h8L6TwNvZYwjv+IjNxai+4D4fQr
 4pRDHHMv2AiAiKENV1QgERWmN4ELxREA1B5VOVMWUj5b4kw9Mvi4Q9isUqOPcjCRJHFD
 hJKd6hR0OkUHS5KOutkVDDdK4EZ3HoiARCwUDV3qndAeMSCzf8vCZ1DWaBtmL4sZjlnL
 8LBjQBBCAU2BhMfR7LipkyNT2sAAMlxew4+we/JEsAI6fqzkt8tJ/MFRCrOJwD4bVm5Z
 SbxmO6yxoTlaYkbuN6oqZ2v9SheuTk6sak5VrDJC1umbMjcB56iuHh4J66LRM2RweJAo
 nlVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=utbS7r3DRmoN8HxQUtiOAPdtm21cO7frIFdAwUFAD9Y=;
 b=ph++nG1MsLFAk+C4lSkEiekafZR0dxRWSK80ba4aPFCsaC/qXZe2Xt7wwU00hLe4J4
 P7FxxwVvqPItufFCZBdvJ3+xysxOsxHH+7v5WyIImZe/zHfQNDI1QHsHNZqZZopwns1D
 +6pAHsjSWqQqr4u2Wql8rccwZcBzeZMLsHdJdx6/KKJ5AML8XvPeXopqZwk51O5bU2Ux
 nNgCORBS/SM+dMuuP4CeC7gDxU0Ij+Xm1AcVOANeBAvsq95jqhmUNIaxmIqTgb7AAo55
 apOjgbjQuDH2KPYPJLUOYEt4Fi7Eo9BLrXPxUjFs4HCCtvWf0KQCWAW51mc0MiBBvWPR
 +pxA==
X-Gm-Message-State: APjAAAWwIwvyysVRb2lfugPo6o29F01hPwoyd56G7R9jn1W1Hl9hLhTb
 13bily9HE/CUirjXXMh7q+cg7/NfZ/RdJmq5X6c=
X-Google-Smtp-Source: APXvYqwtQq3eyvYFnojZa15x4/sks+Mo4JGjDP9EjA23mCSLHBgwTAbwDzitrztROKZ4ssLnIOG+e5wXmm+Kn1w+p7w=
X-Received: by 2002:a05:6000:1241:: with SMTP id
 j1mr13430126wrx.26.1575126936315; 
 Sat, 30 Nov 2019 07:15:36 -0800 (PST)
MIME-Version: 1.0
References: <CAEvUa7nxnby+rxK-KRMA46=exeOMApkDMAV08AjMkkPnTPV4CQ@mail.gmail.com>
 <20191130012900.GA2862@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20191130021257.GA5562@hsiangkao-HP-ZHAN-66-Pro-G1>
In-Reply-To: <20191130021257.GA5562@hsiangkao-HP-ZHAN-66-Pro-G1>
From: David Michael <fedora.dm0@gmail.com>
Date: Sat, 30 Nov 2019 10:15:25 -0500
Message-ID: <CAEvUa7nG9Akp3Uv59P4+eGYYZ+nTfdO4OywiqZaLfY3_ag-vcQ@mail.gmail.com>
Subject: Re: Compatibility with overlayfs
To: Gao Xiang <hsiangkao@aol.com>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Nov 29, 2019 at 9:13 PM Gao Xiang <hsiangkao@aol.com> wrote:
> On Sat, Nov 30, 2019 at 09:29:04AM +0800, Gao Xiang via Linux-erofs wrote:
> > Hi David,
> >
> > On Fri, Nov 29, 2019 at 03:22:15PM -0500, David Michael wrote:
> > > Hi,
> > >
> > > I tried to test EROFS on Linux 5.4 as the root file system and mounted
> > > a writable overlay (with upper layer on tmpfs) over /etc, but I get
> > > ENODATA errors when attempting to modify files.  For example, adding a
> > > user results in "Failed to take /etc/passwd lock: No data available".
> > > Files can be modified after unlinking and restoring them so they're
> > > created on the upper layer.  This is not necessary with other
> > > read-only file systems (at least squashfs or ext4 with the read-only
> > > feature).  I tried while forcing compact and extended inodes.
> > >
> > > Is EROFS intended to be usable as a lower layer with overlayfs?
> >
> > Yes, and overlayfs were used on our smartphones for development use
> > only as well. I think it's weird, I will try it on the latest kernel
> > now, and see if I can reproduce this issue soon...
> >
> > Thanks for your report!
> >
> > Thanks,
> > Gao Xiang
>
> I have reproduced this issue -- That is due to erofs will return an
> unexpected -ENODATA when calling listxattr without xattr and cause
> copy_up fail:

Oh, sorry I forgot to mention I had xattrs disabled during my testing.
I confirmed it works with xattrs, so I can use that as a workaround in
binary distros until a fix is upstream.

> since our products using xattr enabled EROFS with overlayfs,
> so we didn't observe this issue before. So could you try
> the following patch (If it can resolve the issue, I will
> send it for 5.5-rc2 and backport to all stable version)?
> Look forward to your feekback.

Yes, I applied the patch and everything works now.

Thanks.

David
