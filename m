Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2273FA4B407
	for <lists+linux-erofs@lfdr.de>; Sun,  2 Mar 2025 19:23:25 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z5VgY5b5kz30WS
	for <lists+linux-erofs@lfdr.de>; Mon,  3 Mar 2025 05:23:21 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=83.149.199.84
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740939800;
	cv=none; b=D8EgDACYZlx4XNTjQVseTLxAYH7nOXuLAY1vQ68dJIDV7IeRRJ8BQwwpmAeB0dvwcANDDcP3F8Zdiwv1tJrXVu56m2tSI99S1N0rHSbmEGBr2D+ZXP1Qxj78+FXpjZS0C4a5dRptZkvuby5dNNWW8jTePxJoJ80jaK+KM8lGp6pJQBWCJf3a0dK7pHRTdVkGPs1PdDzsE5lRPrdh6Ym08sClYgPSuCq+BQUetF/Z4o9sItXm5GnDJXlpETgQqFllN6KJPvJOPVfda9MoCiDoR6GE56zxqUB+7c15C5xdykRLurr0R/axbb+h+OAoYQEMwxBltIMSvwL/t7gG8Vc5tw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740939800; c=relaxed/relaxed;
	bh=H0EDeRRfwEJ7O4uee6odQGPJWEcdHTvlhAexVbp9No0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=norwZ75E9NO95LXuU/CPVsDenV8ppLHS1x/qoIHNjB7Ukf9S1edKkVVo49eHsL1BZYnvpph63XVOBu3ZRM/JaWcIO7urYSthxQwxHDE4S/ZRPZyZph4sGKL65eLjcpr4th9r/ufAqvDz7act0G83IRXBiV74mbBg1tLD18r/6rhym11mqzJl6QB/za6/WyA45IJc/EDT0aZfSTzi/Cz3gukDb0Si7P/cBbyj3HMWjqdwKXLAvu/rtbmLT9Pit1iTIZ5tdF8LTGqr6GXIycORnAaHIHyXv9rKI5NYJc9FH1DWPVBqQqB9UxBAe6HrKDDDGyTKVj1uWeIdF656L7+qSA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; dkim=pass (1024-bit key; unprotected) header.d=ispras.ru header.i=@ispras.ru header.a=rsa-sha256 header.s=default header.b=aRhUo8BY; dkim-atps=neutral; spf=pass (client-ip=83.149.199.84; helo=mail.ispras.ru; envelope-from=pchelkin@ispras.ru; receiver=lists.ozlabs.org) smtp.mailfrom=ispras.ru
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=ispras.ru header.i=@ispras.ru header.a=rsa-sha256 header.s=default header.b=aRhUo8BY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ispras.ru (client-ip=83.149.199.84; helo=mail.ispras.ru; envelope-from=pchelkin@ispras.ru; receiver=lists.ozlabs.org)
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z5VgT2wkNz2yhG
	for <linux-erofs@lists.ozlabs.org>; Mon,  3 Mar 2025 05:23:11 +1100 (AEDT)
Received: from localhost (unknown [10.10.165.4])
	by mail.ispras.ru (Postfix) with ESMTPSA id 8500740CE190;
	Sun,  2 Mar 2025 18:13:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 8500740CE190
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1740939225;
	bh=H0EDeRRfwEJ7O4uee6odQGPJWEcdHTvlhAexVbp9No0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aRhUo8BY3IT/9HrU/p5zGEBXVqKU/8RYbsa7oPXqeU+cM1TdBpJFqYKIEc/eCEyOv
	 JDBxOHRs3OHGGGP8u0V+/cFxuI+bnGvUYOdXK0YedbB/CXaIwt2UCNTMdBqb5Xv9lN
	 14VMUnauswAUzpInicqMJG4sRyuWU8tsgz9/hyt4=
Date: Sun, 2 Mar 2025 21:13:45 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH 6.1 1/2] erofs: handle overlapped pclusters out of
 crafted images properly
Message-ID: <3vutme7tf24cqdfbf4wjti22u6jfxjewe6gt4ufppp4xplyb5e@xls7aozstoqr>
References: <20250228165103.26775-1-apanov@astralinux.ru>
 <20250228165103.26775-2-apanov@astralinux.ru>
 <kcsbxadkk4wow7554zonb6cjvzmkh2pbncsvioloucv3npvbtt@rpthpmo7cjja>
 <fb801c0f-105e-4aa7-80e2-fcf622179446@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fb801c0f-105e-4aa7-80e2-fcf622179446@linux.alibaba.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: Max Kellermann <max.kellermann@ionos.com>, lvc-project@linuxtesting.org, syzbot+de04e06b28cfecf2281c@syzkaller.appspotmail.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Chao Yu <chao@kernel.org>, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Alexey Panov <apanov@astralinux.ru>, Yue Hu <huyue2@coolpad.com>, syzbot+4fc98ed414ae63d1ada2@syzkaller.appspotmail.com, syzbot+c8c8238b394be4a1087d@syzkaller.appspotmail.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, 03. Mar 01:41, Gao Xiang wrote:
> > > diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> > > index 94e9e0bf3bbd..ac01c0ede7f7 100644
> > 
> > I'm looking at the diff of upstream commit and the first thing it does
> > is to remove zeroing out the folio/page private field here:
> > 
> >    // upstream commit 9e2f9d34dd12 ("erofs: handle overlapped pclusters out of crafted images properly")
> >    @@ -1450,7 +1451,6 @@ static void z_erofs_fill_bio_vec(struct bio_vec *bvec,
> >             * file-backed folios will be used instead.
> >             */
> >            if (folio->private == (void *)Z_EROFS_PREALLOCATED_PAGE) {
> >    -               folio->private = 0;
> >                    tocache = true;
> >                    goto out_tocache;
> >            }
> > 
> > while in 6.1.129 the corresponding fragment seems untouched with the
> > backport patch. Is it intended?
> 
> Yes, because it was added in
> commit 2080ca1ed3e4 ("erofs: tidy up `struct z_erofs_bvec`")
> and dropped again.
> 
> But for Linux 6.6.y and 6.1.y, we don't need to backport
> 2080ca1ed3e4.

Thanks for overall clarification, Gao!

My concern was that in 6.1 and 6.6 there is still a pattern at that
place, not directly related to 2080ca1ed3e4 ("erofs: tidy up
`struct z_erofs_bvec`"):

1. checking ->private against Z_EROFS_PREALLOCATED_PAGE
2. zeroing out ->private if the previous check holds true

// 6.1/6.6 fragment

	if (page->private == Z_EROFS_PREALLOCATED_PAGE) {
		WRITE_ONCE(pcl->compressed_bvecs[nr].page, page);
		set_page_private(page, 0);
		tocache = true;
		goto out_tocache;
	}

while the upstream patch changed the situation. If it's okay then no
remarks from me. Sorry for the noise..
