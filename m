Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id F15BD14F567
	for <lists+linux-erofs@lfdr.de>; Sat,  1 Feb 2020 01:26:10 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 488ZdC6LlKzDqhD
	for <lists+linux-erofs@lfdr.de>; Sat,  1 Feb 2020 11:26:07 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=willy@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 488Zcr1sPTzDqgk
 for <linux-erofs@lists.ozlabs.org>; Sat,  1 Feb 2020 11:25:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Fpw6+UEhfuhuXeKhNiLAOcNkyHMzaziNThRDurB0olw=; b=QxOHj2pZg+W0B5HIBaNQ2a1dF
 X0NQclBE2kGZleLQjTuffWwMMANrl04KeOOHt8+bcQ6CQD6k2oHx72uYHBStQflRNHip10UsC+bUF
 Fg7POZ4hQfjJ8LdBtpUUHaKx+Rje32bllb90LUXDP3WyQ/fVujZZviLRgFeAT7YsCrvLqGXY/BB/w
 XtqUGknjOioO7AGDFc7lDe+R24v4E+kG9joislUUkwVb8+Hoia9E/hsFJJBvG1VKjELdCeSa0PDu1
 rNSDke9vxTqSCLFjMRvKxnwwh4Y0P6CGwh+9iPiDkrlTR0ogML9akzWOAnGVQjmF854vphMnQomW5
 k9hsWWB1Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1ixgbW-0005u5-47; Sat, 01 Feb 2020 00:25:42 +0000
Date: Fri, 31 Jan 2020 16:25:42 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 04/12] mm: Add readahead address space operation
Message-ID: <20200201002542.GA20648@bombadil.infradead.org>
References: <20200125013553.24899-1-willy@infradead.org>
 <20200125013553.24899-5-willy@infradead.org>
 <4e28eb80-d602-47e6-51ec-63bb39e1a296@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e28eb80-d602-47e6-51ec-63bb39e1a296@infradead.org>
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
Cc: cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-mm@kvack.org, ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Jan 24, 2020 at 07:57:40PM -0800, Randy Dunlap wrote:
> > +``readahead``
> > +	called by the VM to read pages associated with the address_space
> > +	object.  The pages are consecutive in the page cache and are
> > +        locked.  The implementation should decrement the page refcount after
> > +        attempting I/O on each page.  Usually the page will be unlocked by
> > +        the I/O completion handler.  If the function does not attempt I/O on
> > +        some pages, return the number of pages which were not read so the
> > +        common code can unlock the pages for you.
> > +
> 
> Please use consistent indentation (tabs).

This turned out to be not my fault.  The vim rst ... mode?  plugin?
Whatever it is, it's converting tabs to spaces!  To fix it, I had to
rename the file to .txt, make the edits, then rename it back.  This is
very poor behaviour.
