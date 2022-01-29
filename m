Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E60C44A2CB6
	for <lists+linux-erofs@lfdr.de>; Sat, 29 Jan 2022 09:05:10 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Jm6Lr5tsSz3bP4
	for <lists+linux-erofs@lfdr.de>; Sat, 29 Jan 2022 19:05:08 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131;
 helo=out30-131.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Jm6Lg46FXz2yPV
 for <linux-erofs@lists.ozlabs.org>; Sat, 29 Jan 2022 19:04:57 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R141e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04423; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=2; SR=0; TI=SMTPD_---0V35tMIm_1643443485; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V35tMIm_1643443485) by smtp.aliyun-inc.com(127.0.0.1);
 Sat, 29 Jan 2022 16:04:47 +0800
Date: Sat, 29 Jan 2022 16:04:45 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Igor Eisberg <igoreisberg@gmail.com>
Subject: Re: [PATCH] erofs-utils: add missing errors and normalize errors to
 lower-case
Message-ID: <YfT1Hdr4w6pQKgeA@B-P7TQMD6M-0146.local>
References: <20220128132218.26-1-igoreisberg@gmail.com>
 <CABjEcnGhBLMd1wKC_hjQa8FuO6mFvmC3rxFCgi3fBr0omnymSQ@mail.gmail.com>
 <YfTXDoeqz0dNafhf@B-P7TQMD6M-0146>
 <YfTa/rxeiwycbAKp@B-P7TQMD6M-0146>
 <CABjEcnEN8Uv-VtAV7Rmu=UEaM72ieE-YzEAygFcBKRQ9LX-SvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABjEcnEN8Uv-VtAV7Rmu=UEaM72ieE-YzEAygFcBKRQ9LX-SvQ@mail.gmail.com>
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

On Sat, Jan 29, 2022 at 08:48:01AM +0200, Igor Eisberg wrote:
> On Sat, 29 Jan 2022, 08:13 Gao Xiang, <hsiangkao@linux.alibaba.com> wrote:

..

> 
> >
> > > and I don't want to initialize such structures at the beginning of any
> > > block.
> >
> 
> What exactly is "such structures"? I pointed you to an example where you
> did just that with struct z_erofs_decompress_req rq variable, I'm just
> following your code style, and this one stood out as unusual for your code
> style. Please count how many anonymous struct initializations you have
> across the whole erofs-utils project. I count only this one, and another in
> lib/data.c. Everything else is initialized as named variables.

Sorry, I didn't express clear. I mean here:

		if (compressed) {
			struct z_erofs_decompress_req rq = {
				.in = raw,
				.out = buffer,
				.decodedskip = 0,
				.inputsize = map.m_plen,
				.decodedlength = map.m_llen,
				.alg = map.m_algorithmformat,
				.partial_decoding = 0
			};

			ret = z_erofs_decompress(&rq);
			if (ret < 0) {
				erofs_err("failed to decompress data of m_pa %" PRIu64 ", m_plen %" PRIu64 " @ nid %llu: %s",
					  mdev.m_pa, map.m_plen,
					  inode->nid | 0ULL, strerror(-ret));
				goto out;
			}
		}

rq is at the beginning of the block, and we use the initialized
structure immediately, so I wrote as this.

> 
> 
> > Add some word.
> 
> 
> I didn't understand that...
> 
> Actually, I'd like to add:
> > if (!fsckcfg.extract_path)
> >         return;
> >
> > at the beginning of erofsfsck_set_attributes() instead of
> > using "if (!ret && fsckcfg.extract_path)" in the caller.
> >
> 
> OK, but then we will have mixed declarations and code, because then we
> won't be at the beginning of the block...

Ok, sorry about confusion, I've made a commit instead..
Take a look at:
https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/commit/?h=experimental&id=69476e3ffa4985e767d33cb24d020f3669bc2c77

Since I'd like to avoid too many "if (!ret && fsckcfg.extract_path)"
in the callers if erofsfsck_set_attributes() uses in other place
in the future.

Thanks,
Gao Xiang
