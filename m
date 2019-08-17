Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 689C7913D3
	for <lists+linux-erofs@lfdr.de>; Sun, 18 Aug 2019 02:56:46 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 469zCZ6zyVzDrc9
	for <lists+linux-erofs@lfdr.de>; Sun, 18 Aug 2019 10:56:42 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=nod.at
 (client-ip=195.201.40.130; helo=lithops.sigma-star.at;
 envelope-from=richard@nod.at; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=nod.at
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 469zCP43v9zDqdP
 for <linux-erofs@lists.ozlabs.org>; Sun, 18 Aug 2019 10:56:30 +1000 (AEST)
Received: from localhost (localhost [127.0.0.1])
 by lithops.sigma-star.at (Postfix) with ESMTP id 05377621FCD3;
 Sat, 17 Aug 2019 23:19:55 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
 by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id XTABcBaKQNZk; Sat, 17 Aug 2019 23:19:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by lithops.sigma-star.at (Postfix) with ESMTP id 839676083139;
 Sat, 17 Aug 2019 23:19:51 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
 by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id l7v2AJV0SH0k; Sat, 17 Aug 2019 23:19:51 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
 by lithops.sigma-star.at (Postfix) with ESMTP id 03E82621FCD3;
 Sat, 17 Aug 2019 23:19:50 +0200 (CEST)
Date: Sat, 17 Aug 2019 23:19:50 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Gao Xiang <hsiangkao@aol.com>
Message-ID: <1746679415.68815.1566076790942.JavaMail.zimbra@nod.at>
In-Reply-To: <20190817082313.21040-1-hsiangkao@aol.com>
References: <20190817082313.21040-1-hsiangkao@aol.com>
Subject: Re: [PATCH] erofs: move erofs out of staging
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF60 (Linux)/8.8.12_GA_3809)
Thread-Topic: erofs: move erofs out of staging
Thread-Index: 8FsSXU2wmXCQdCGPbfgJ42ALdSe6DQ==
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
Cc: Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>,
 David Sterba <dsterba@suse.cz>, Miao Xie <miaoxie@huawei.com>,
 devel@driverdev.osuosl.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 "Darrick J . Wong" <darrick.wong@oracle.com>,
 Christoph Hellwig <hch@infradead.org>, Amir Goldstein <amir73il@gmail.com>,
 linux-erofs@lists.ozlabs.org, Al Viro <viro@zeniv.linux.org.uk>,
 Jaegeuk Kim <jaegeuk@kernel.org>, tytso <tytso@mit.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@denx.de>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 torvalds <torvalds@linux-foundation.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

----- Urspr=C3=BCngliche Mail -----
> Von: "Gao Xiang" <hsiangkao@aol.com>
> An: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Al Viro" <viro@ze=
niv.linux.org.uk>, "linux-fsdevel"
> <linux-fsdevel@vger.kernel.org>, devel@driverdev.osuosl.org, linux-erofs@=
lists.ozlabs.org, "linux-kernel"
> <linux-kernel@vger.kernel.org>
> CC: "Andrew Morton" <akpm@linux-foundation.org>, "Stephen Rothwell" <sfr@=
canb.auug.org.au>, "tytso" <tytso@mit.edu>,
> "Pavel Machek" <pavel@denx.de>, "David Sterba" <dsterba@suse.cz>, "Amir G=
oldstein" <amir73il@gmail.com>, "Christoph
> Hellwig" <hch@infradead.org>, "Darrick J . Wong" <darrick.wong@oracle.com=
>, "Dave Chinner" <david@fromorbit.com>,
> "Jaegeuk Kim" <jaegeuk@kernel.org>, "Jan Kara" <jack@suse.cz>, "richard" =
<richard@nod.at>, "torvalds"
> <torvalds@linux-foundation.org>, "Chao Yu" <yuchao0@huawei.com>, "Miao Xi=
e" <miaoxie@huawei.com>, "Li Guifu"
> <bluce.liguifu@huawei.com>, "Fang Wei" <fangwei1@huawei.com>, "Gao Xiang"=
 <gaoxiang25@huawei.com>
> Gesendet: Samstag, 17. August 2019 10:23:13
> Betreff: [PATCH] erofs: move erofs out of staging

> EROFS filesystem has been merged into linux-staging for a year.
>=20
> EROFS is designed to be a better solution of saving extra storage
> space with guaranteed end-to-end performance for read-only files
> with the help of reduced metadata, fixed-sized output compression
> and decompression inplace technologies.
=20
How does erofs compare to squashfs?
IIUC it is designed to be faster. Do you have numbers?
Feel free to point me older mails if you already showed numbers,
I have to admit I didn't follow the development very closely.

Thanks,
//richard
