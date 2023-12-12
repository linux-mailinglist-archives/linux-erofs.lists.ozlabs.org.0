Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C03A280E4F1
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Dec 2023 08:35:46 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=rhyiQAuA;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Sq9Q823lHz30PD
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Dec 2023 18:35:44 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=rhyiQAuA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+6f90c2f2ff3264e7ff81+7415+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Sq9Q43c8Jz2yG9
	for <linux-erofs@lists.ozlabs.org>; Tue, 12 Dec 2023 18:35:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AcYhiiH7fhawjVuelCjJeq52YfhKQC6amDLwlqcKTwo=; b=rhyiQAuAA9SMhBFiM8MkZ6S7/n
	2VqgqBenkm2syZdsR1Rs17Wb5BaWMmD22pzkTDL6hYP58KirLwQ8G4Hx2+CujuFMTHiC1xqZtL6ud
	5Ol2yLOF+hnaxCoUbzWseGsOuFgtT+oO9YvjDwYL/VW46twsaJSB7qVoUPFilAFQoF9N7XDWmhEV7
	C5wYXOnPMOjocN4mK5mn4YHhT3wXd4c1mrJdmhV6LrfjCdOb6tTlbXN0mKGhssdilbPbUbACzCEKr
	ugWu78xhg3L50aQSFtgRwv7Hi+deVFSZtKpq51xv0R9033QmVrF2kw2P7atuEz4Z38Ue87RHO6TTv
	H64AJwtQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rCxIh-00AwT9-2z;
	Tue, 12 Dec 2023 07:35:31 +0000
Date: Mon, 11 Dec 2023 23:35:31 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [RFC KERNEL] initoverlayfs - a scalable initial filesystem
Message-ID: <ZXgNQ85PdUKrQU1j@infradead.org>
References: <CAOgh=Fwb+JCTQ-iqzjq8st9qbvauxc4gqqafjWG2Xc08MeBabQ@mail.gmail.com>
 <941aff31-6aa4-4c37-bb94-547c46250304@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <941aff31-6aa4-4c37-bb94-547c46250304@linux.alibaba.com>
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
Cc: nvdimm@lists.linux.dev, Colin Walters <walters@redhat.com>, Lokesh Mandvekar <lmandvek@redhat.com>, Stephen Smoogen <ssmoogen@redhat.com>, Yariv Rachmani <yrachman@redhat.com>, Brian Masney <bmasney@redhat.com>, Daniel Walsh <dwalsh@redhat.com>, Daan De Meyer <daan.j.demeyer@gmail.com>, linux-unionfs@vger.kernel.org, Luca Boccassi <bluca@debian.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Pavol Brilla <pbrilla@redhat.com>, Eric Chanudet <echanude@redhat.com>, Alexander Larsson <alexl@redhat.com>, Lennart Poettering <lennart@poettering.net>, Neal Gompa <neal@gompa.dev>, linux-erofs@lists.ozlabs.org, Douglas Landgraf <dlandgra@redhat.com>, Petr =?utf-8?Q?=C5=A0abata?= <psabata@redhat.com>, Eric Curtin <ecurtin@redhat.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Dec 12, 2023 at 08:50:56AM +0800, Gao Xiang wrote:
> For non-virtualization cases, I guess you could try to use `memmap`
> kernel option [2] to specify a memory region by bootloaders which
> contains an EROFS rootfs and a customized init for booting as
> erofs+overlayfs at least for `initoverlayfs`.  The main benefit is
> that the memory region specified by the bootloader can be directly
> used for mounting.  But I never tried if this option actually works.
> 
> Furthermore, compared to traditional ramdisks, using direct address
> can avoid page cache totally for uncompressed files like it can
> just use unencoded data as mmaped memory.  For compressed files, it
> still needs page cache to support mmaped access but we could adapt
> more for persistent memory scenarios such as disable cache
> decompression compared to previous block devices.
> 
> I'm not sure if it's worth implementing this in kernelspace since
> it's out of scope of an individual filesystem anyway.

IFF the use case turns out to be generally useful (it looks quite
convoluted and odd to me), we could esily do an initdax concept where
a chunk of memory passed by the bootloader is presented as a DAX device
properly without memmap hacks.

