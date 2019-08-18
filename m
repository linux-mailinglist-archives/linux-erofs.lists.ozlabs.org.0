Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA299188C
	for <lists+linux-erofs@lfdr.de>; Sun, 18 Aug 2019 20:00:45 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46BPx70n5bzDrCJ
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Aug 2019 04:00:43 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 46BPx21s5xzDqf5
 for <linux-erofs@lists.ozlabs.org>; Mon, 19 Aug 2019 04:00:36 +1000 (AEST)
Received: from localhost (localhost [127.0.0.1])
 by lithops.sigma-star.at (Postfix) with ESMTP id BE1ED608311C;
 Sun, 18 Aug 2019 20:00:32 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
 by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id 4gGs7GazpkF2; Sun, 18 Aug 2019 20:00:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by lithops.sigma-star.at (Postfix) with ESMTP id 7F2846083139;
 Sun, 18 Aug 2019 20:00:29 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
 by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id Uj_qxmxjUq0m; Sun, 18 Aug 2019 20:00:29 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
 by lithops.sigma-star.at (Postfix) with ESMTP id 097BB608311C;
 Sun, 18 Aug 2019 20:00:29 +0200 (CEST)
Date: Sun, 18 Aug 2019 20:00:28 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: tytso <tytso@mit.edu>
Message-ID: <538856932.69442.1566151228866.JavaMail.zimbra@nod.at>
In-Reply-To: <20190818174621.GB12940@mit.edu>
References: <20190817082313.21040-1-hsiangkao@aol.com>
 <20190818084521.GA17909@hsiangkao-HP-ZHAN-66-Pro-G1>
 <1133002215.69049.1566119033047.JavaMail.zimbra@nod.at>
 <20190818090949.GA30276@kroah.com>
 <790210571.69061.1566120073465.JavaMail.zimbra@nod.at>
 <20190818151154.GA32157@mit.edu>
 <1897345637.69314.1566148000847.JavaMail.zimbra@nod.at>
 <20190818174621.GB12940@mit.edu>
Subject: Re: [PATCH] erofs: move erofs out of staging
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF60 (Linux)/8.8.12_GA_3809)
Thread-Topic: erofs: move erofs out of staging
Thread-Index: sAbiegKjjTKQmAd1TwyH6s3S7iROUA==
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
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
 Dave Chinner <david@fromorbit.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Miao Xie <miaoxie@huawei.com>,
 devel <devel@driverdev.osuosl.org>, Stephen Rothwell <sfr@canb.auug.org.au>,
 Darrick <darrick.wong@oracle.com>, Christoph Hellwig <hch@infradead.org>,
 torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>,
 Jaegeuk Kim <jaegeuk@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 David Sterba <dsterba@suse.cz>, Pavel Machek <pavel@denx.de>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-erofs <linux-erofs@lists.ozlabs.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

----- Urspr=C3=BCngliche Mail -----
> Von: "tytso" <tytso@mit.edu>
> An: "richard" <richard@nod.at>
> CC: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Gao Xiang" <hsian=
gkao@aol.com>, "Jan Kara" <jack@suse.cz>, "Chao
> Yu" <yuchao0@huawei.com>, "Dave Chinner" <david@fromorbit.com>, "David St=
erba" <dsterba@suse.cz>, "Miao Xie"
> <miaoxie@huawei.com>, "devel" <devel@driverdev.osuosl.org>, "Stephen Roth=
well" <sfr@canb.auug.org.au>, "Darrick"
> <darrick.wong@oracle.com>, "Christoph Hellwig" <hch@infradead.org>, "Amir=
 Goldstein" <amir73il@gmail.com>,
> "linux-erofs" <linux-erofs@lists.ozlabs.org>, "Al Viro" <viro@zeniv.linux=
.org.uk>, "Jaegeuk Kim" <jaegeuk@kernel.org>,
> "linux-kernel" <linux-kernel@vger.kernel.org>, "Li Guifu" <bluce.liguifu@=
huawei.com>, "Fang Wei" <fangwei1@huawei.com>,
> "Pavel Machek" <pavel@denx.de>, "linux-fsdevel" <linux-fsdevel@vger.kerne=
l.org>, "Andrew Morton"
> <akpm@linux-foundation.org>, "torvalds" <torvalds@linux-foundation.org>
> Gesendet: Sonntag, 18. August 2019 19:46:21
> Betreff: Re: [PATCH] erofs: move erofs out of staging

> On Sun, Aug 18, 2019 at 07:06:40PM +0200, Richard Weinberger wrote:
>> > So holding a file system like EROFS to a higher standard than say,
>> > ext4, xfs, or btrfs hardly seems fair.
>>=20
>> Nobody claimed that.
>=20
> Pointing out that erofs has issues in this area when Gao Xiang is
> asking if erofs can be moved out of staging and join the "official
> clubhouse" of file systems could certainly be reasonable interpreted
> as such.  Reporting such vulnerablities are a good thing, and
> hopefully all file system maintainers will welcome them.  Doing them
> on a e-mail thread about promoting out of erofs is certainly going to
> lead to inferences of a double standard.

Well, this was not at all my intention.
erofs raised my attention and instead of wasting a new thread
I answered here and reported what I found while looking at it.
That's all.

Thanks,
//richard
