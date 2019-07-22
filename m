Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C176F894
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jul 2019 06:39:54 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45sTRW59pSzDqT8
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jul 2019 14:39:51 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::c41; helo=mail-yw1-xc41.google.com;
 envelope-from=amir73il@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="t/VUEFE9"; 
 dkim-atps=neutral
Received: from mail-yw1-xc41.google.com (mail-yw1-xc41.google.com
 [IPv6:2607:f8b0:4864:20::c41])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45sTRQ36tgzDqT4
 for <linux-erofs@lists.ozlabs.org>; Mon, 22 Jul 2019 14:39:43 +1000 (AEST)
Received: by mail-yw1-xc41.google.com with SMTP id l124so15425527ywd.0
 for <linux-erofs@lists.ozlabs.org>; Sun, 21 Jul 2019 21:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OMqsPQOjQqPIEBmD3EIh4Qtw05vaz+UOfW4nYOJHTL4=;
 b=t/VUEFE9R2TvEBxbMNvsYCoL2WZYdDc0V4kRWpaHd/rCAxdQIa436PxuYFihm/ifDL
 H5FDSOR4DAcsJfHRaXAU2y1fOgiHivBPZDcNU+NKvX/KOFe0+TIojO7yzrLOaCpfSgyH
 8w8H1swbhb7jAhafPPfws0q8ehyTp/OIOqdO5fSa9w6TNw/A3QFZcpZ7zIQOcFFirqf3
 rRY81Z8vai/trJWZwFmj3nqB2pLuwZujCtzdqgYaUFY39SgnBtvz0FEizNU7qvcPe1iZ
 9Cd4RFJF9WGz6EuAuJQeCzPQRQ2HfRrXe7rRYmw/vjWiISrRX9vt1y7X3WVeck0H9Ayf
 1UGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OMqsPQOjQqPIEBmD3EIh4Qtw05vaz+UOfW4nYOJHTL4=;
 b=tQnlFXtZ0lpTuA5GYVA4XKSrkLUpFVV3WGj8RhHhfU/pugg+1+LeYsqjiGHAwZ+sJU
 jKF/TSdFhnw3nFbCJ8Mv/gJMq5nLmLXRc5py+DIHslUdjBae9Us1jxn7JTfbNMYjIh+t
 PvAmaLgAmVcj8mOp4BD442V8rTcFNQLQhdig0l0YLAhN7kXdnhxLaTfGwSSBJhPTW/Fk
 XXJIcFDRxWo2cJjeWVeCbYTGYU/Nah6oKgjbgeo2shoMh5NzT4gcfY5a+pIRnJkqB433
 nThL55Lo9D/KWK5eitPUQmtQTemT8HFGPdH4yPoLcsuVTou1x18zCjJgf6JY1lnBSoCa
 tfdg==
X-Gm-Message-State: APjAAAVs12cctYZQoX7rGnhy4G/boq8US7CFHyG2CaRHnmItHctW+nKI
 FNMb/iE0qUDaASkDRNlY7bJ0jvUf2GATQwuH3aU=
X-Google-Smtp-Source: APXvYqw2nuO6UwixpRbfaNpk9MK1Ao8/qBkIZzg+dLv0cDdjoBg3WbnEO02wQKi8/VMw4pkqKPvLqF4+21jZlLPQ/AY=
X-Received: by 2002:a81:50d5:: with SMTP id
 e204mr39589702ywb.379.1563770379165; 
 Sun, 21 Jul 2019 21:39:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190722025043.166344-1-gaoxiang25@huawei.com>
 <20190722025043.166344-13-gaoxiang25@huawei.com>
In-Reply-To: <20190722025043.166344-13-gaoxiang25@huawei.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 22 Jul 2019 07:39:27 +0300
Message-ID: <CAOQ4uxh04gwbM4yFaVpWHVwmJ4BJo4bZaU8A4_NQh2bO_xCHJg@mail.gmail.com>
Subject: Re: [PATCH v3 12/24] erofs: introduce tagged pointer
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
 Theodore Ts'o <tytso@mit.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Miao Xie <miaoxie@huawei.com>, linux-erofs@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Jul 22, 2019 at 5:54 AM Gao Xiang <gaoxiang25@huawei.com> wrote:
>
> Currently kernel has scattered tagged pointer usages
> hacked by hand in plain code, without a unique and
> portable functionset to highlight the tagged pointer
> itself and wrap these hacked code in order to clean up
> all over meaningless magic masks.
>
> This patch introduces simple generic methods to fold
> tags into a pointer integer. Currently it supports
> the last n bits of the pointer for tags, which can be
> selected by users.
>
> In addition, it will also be used for the upcoming EROFS
> filesystem, which heavily uses tagged pointer pproach
>  to reduce extra memory allocation.
>
> Link: https://en.wikipedia.org/wiki/Tagged_pointer

Well, it won't do much good for other kernel users in fs/erofs/ ;-)

I think now would be a right time to promote this facility to
include/linux as you initially proposed.
I don't recall you got any objections. No ACKs either, but I think
that was the good kind of silence (?)

You might want to post the __fdget conversion patch [1] as a
bonus patch on top of your series.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/1530543233-65279-2-git-send-email-gaoxiang25@huawei.com/
