Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B148D80ECC7
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Dec 2023 14:06:49 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=boRv2crS;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SqJm7124nz3bsX
	for <lists+linux-erofs@lfdr.de>; Wed, 13 Dec 2023 00:06:47 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=boRv2crS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+6f90c2f2ff3264e7ff81+7415+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SqJm04dMwz2xdg
	for <linux-erofs@lists.ozlabs.org>; Wed, 13 Dec 2023 00:06:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=67rvxc8KF4Am0jhrdB27CpUPgtiBS4+Z+YV3L6uI8NY=; b=boRv2crSvsM4V861vsFYqPudVo
	oG6u3FHR4FHHElcP1zSEgNE+5kwcrLl8Uz1eXzDuU+QSB05HYIyBVVwkOtXpg6sFkZYx9mqFKQjJM
	CXisjMmelC2DPUsL58SML8bx6tCM58JvtFZQEwgmQOs8rP7cRr4IW8hQuQzWegRit+rlMtWPUetU0
	KpVjNA38PW2wXGCw2uTGgg9BxSr2A9zNj44dE7KI91wfU5RQzskEfu8I4zBHr9uonz3WBXwvKc/s5
	KmNCYBg+ld1Sb/eG3XxK7KRizFgVP0sSFjlESHL+pIF2sj7jbF+BxiL0+eJ/kF74k423hjI106Lm6
	x5CzPzPg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rD2Sy-00Bko8-0I;
	Tue, 12 Dec 2023 13:06:28 +0000
Date: Tue, 12 Dec 2023 05:06:28 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [RFC KERNEL] initoverlayfs - a scalable initial filesystem
Message-ID: <ZXha1IxzRfhsRNOu@infradead.org>
References: <CAOgh=Fwb+JCTQ-iqzjq8st9qbvauxc4gqqafjWG2Xc08MeBabQ@mail.gmail.com>
 <941aff31-6aa4-4c37-bb94-547c46250304@linux.alibaba.com>
 <ZXgNQ85PdUKrQU1j@infradead.org>
 <58d175f8-a06e-4b00-95fe-1bd5a79106df@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58d175f8-a06e-4b00-95fe-1bd5a79106df@linux.alibaba.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: nvdimm@lists.linux.dev, Colin Walters <walters@redhat.com>, Lokesh Mandvekar <lmandvek@redhat.com>, Eric Curtin <ecurtin@redhat.com>, Yariv Rachmani <yrachman@redhat.com>, Brian Masney <bmasney@redhat.com>, Daniel Walsh <dwalsh@redhat.com>, Daan De Meyer <daan.j.demeyer@gmail.com>, linux-unionfs@vger.kernel.org, Luca Boccassi <bluca@debian.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, Pavol Brilla <pbrilla@redhat.com>, Eric Chanudet <echanude@redhat.com>, Alexander Larsson <alexl@redhat.com>, Lennart Poettering <lennart@poettering.net>, Neal Gompa <neal@gompa.dev>, linux-erofs@lists.ozlabs.org, Douglas Landgraf <dlandgra@redhat.com>, Petr =?utf-8?Q?=C5=A0abata?= <psabata@redhat.com>, Stephen Smoogen <ssmoogen@redhat.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Dec 12, 2023 at 03:50:25PM +0800, Gao Xiang wrote:
> I have no idea how it's faster than the current initramfs or initrd.
> So if it's really useful, maybe some numbers can be posted first
> with the current `memmap` hack and see it's worth going further with
> some new infrastructure like initdax.

Agreed.
