Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA511158E91
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Feb 2020 13:34:48 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48H2KK5Q04zDqN8
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Feb 2020 23:34:45 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=willy@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20170209 header.b=SeyBbYth; 
 dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48H2K76yPtzDqLq
 for <linux-erofs@lists.ozlabs.org>; Tue, 11 Feb 2020 23:34:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=uIlXDShEskfTvbYftNPC1eqkJUsB5szLvdV7iweWe4s=; b=SeyBbYthoa6L+1pKSTBoqxCFni
 wTJRyOqUnVlYvD37j4HGWVkO1X/D0fyafdbCfsynh7E7Nd3cyOFPC/SIb5jUOMZyzdEvncdXAzReF
 vQYgsmrVkB4zwfd6rrwB1SvDqqK2SKFVfjZfVMxT8s5K4GJS8hhniBqwoUBwsteVgZNIUfpPcQ5aP
 0IPMIzBXCcgmYEtwqCZOxnn68TEw92XrWsLDyQuhAe5AlzAF01rYALZpzjl8uENQAqVFM68FPSZW4
 JFup/EfcWoR5+TyIkZIBfhMJ9badlt8+Epn37DVY1zowNGoeUikWKpJqKg7VeqVpO/jC94HcPn328
 u1r5UcAQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1j1UkI-0006ev-Kh; Tue, 11 Feb 2020 12:34:30 +0000
Date: Tue, 11 Feb 2020 04:34:30 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH v5 01/13] mm: Fix the return type of
 __do_page_cache_readahead
Message-ID: <20200211123430.GT8731@bombadil.infradead.org>
References: <20200211010348.6872-1-willy@infradead.org>
 <20200211010348.6872-2-willy@infradead.org>
 <SN4PR0401MB3598602411B75B46F5267B829B180@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB3598602411B75B46F5267B829B180@SN4PR0401MB3598.namprd04.prod.outlook.com>
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
Cc: "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>,
 "cluster-devel@redhat.com" <cluster-devel@redhat.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
 "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Feb 11, 2020 at 08:19:14AM +0000, Johannes Thumshirn wrote:
> On 11/02/2020 02:05, Matthew Wilcox wrote:
> > even though I'm pretty sure we're not going to readahead more than 2^32
> > pages ever.
> 
> And 640K is more memory than anyone will ever need on a computer *scnr*

Sure, but bandwidth just isn't increasing quickly enough to have
this make sense.  2^32 pages even on our smallest page size machines
is 16GB.  Right now, we cap readahead at just 256kB.  If we did try to
readahead 16GB, we'd be occupying a PCIe gen4 x4 drive for two seconds,
just satisfying this one readahead.  PCIe has historically doubled in
bandwidth every three years or so, so to get this down to something
reasonable like a hundredth of a second, we're looking at PCIe gen12 in
twenty years or so.  And I bet we still won't do it (also, I doubt PCIe
will continue doubling bandwidth every three years).

And Linus has forbidden individual IOs over 2GB anyway, so not happening
until he's forced to see the error of his ways ;-)
