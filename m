Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F593D06D2
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Jul 2021 04:54:17 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GV0Xl2rxJz308F
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Jul 2021 12:54:15 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132;
 helo=out30-132.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-132.freemail.mail.aliyun.com
 (out30-132.freemail.mail.aliyun.com [115.124.30.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GV0Xb0Pzxz2yNn
 for <linux-erofs@lists.ozlabs.org>; Wed, 21 Jul 2021 12:54:05 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R991e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04423; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=7; SR=0; TI=SMTPD_---0UgTuycl_1626836038; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UgTuycl_1626836038) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 21 Jul 2021 10:53:59 +0800
Date: Wed, 21 Jul 2021 10:53:58 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Andreas =?utf-8?Q?Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Subject: Re: [PATCH v4] iomap: support tail packing inline read
Message-ID: <YPeMRsJwELjoWLFs@B-P7TQMD6M-0146.local>
Mail-Followup-To: Andreas =?utf-8?Q?Gr=C3=BCnbacher?=
 <andreas.gruenbacher@gmail.com>, 
 "Darrick J. Wong" <djwong@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, linux-erofs@lists.ozlabs.org,
 Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>
References: <20210720133554.44058-1-hsiangkao@linux.alibaba.com>
 <20210720204224.GK23236@magnolia>
 <YPc9viRAKm6cf2Ey@casper.infradead.org>
 <YPdkYFSjFHDOU4AV@B-P7TQMD6M-0146.local>
 <20210721001720.GS22357@magnolia>
 <YPdrSN6Vso98bLzB@B-P7TQMD6M-0146.local>
 <CAHpGcM+8cp81=bkzFf3sZfKREM9VbXfePpXrswNJOLVcwEnK7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHpGcM+8cp81=bkzFf3sZfKREM9VbXfePpXrswNJOLVcwEnK7A@mail.gmail.com>
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
Cc: "Darrick J. Wong" <djwong@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Matthew Wilcox <willy@infradead.org>,
 Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
 linux-erofs@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Andreas,

On Wed, Jul 21, 2021 at 04:26:47AM +0200, Andreas Grünbacher wrote:
> Am Mi., 21. Juli 2021 um 02:33 Uhr schrieb Gao Xiang
> <hsiangkao@linux.alibaba.com>:
> > > And since you can only kmap one page at a time, an inline read grabs the
> > > first part of the data in "page one" and then we have to call
> > > iomap_begin a second time get a new address so that we can read the rest
> > > from "page two"?
> >
> > Nope, currently EROFS inline data won't cross page like this.
> >
> > But in principle, yes, I don't want to limit it to the current
> > EROFS or gfs2 usage. I think we could make this iomap function
> > more generally (I mean, I'd like to make the INLINE extent
> > functionity as general as possible,
> 
> Nono. Can we please limit this patch what we actually need right now,
> and worry about extending it later?

Can you elaborate what it will benefit us if we only support one tail
block for iomap_read_inline_data()? (I mean it has similar LOC changes,
similar implementation / complexity.) The only concern I think is if
it causes gfs2 regression, so that is what I'd like to confirm.

In contrast, I'd like to avoid iomap_write_begin() tail-packing because
it's complex and no fs user interests in it for now. So I leave it
untouched for now.

Another concern I really like to convert EROFS to iomap is I'd like to
support sub-page blocksize for EROFS after converting. I don't want to
touch iomap inline code again like this since it interacts 2 directories
thus cause too much coupling.

Thanks,
Gao Xiang

> 
> > my v1 original approach
> > in principle can support any inline extent in the middle of
> > file rather than just tail blocks, but zeroing out post-EOF
> > needs another iteration) and I don't see it add more code and
> > complexity.
> 
> Thanks,
> Andreas
