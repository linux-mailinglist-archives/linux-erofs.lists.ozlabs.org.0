Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C05164B0F
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Feb 2020 17:53:03 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48N3gc3tpHzDqZC
	for <lists+linux-erofs@lfdr.de>; Thu, 20 Feb 2020 03:53:00 +1100 (AEDT)
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
 header.a=rsa-sha256 header.s=bombadil.20170209 header.b=H1FNokl1; 
 dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48N3gT6QwDzDqRk
 for <linux-erofs@lists.ozlabs.org>; Thu, 20 Feb 2020 03:52:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=cgHnf3SMrTZMA4DpDgtFfVIHiHWSF/Dqsrx7GRLBvxI=; b=H1FNokl1Ks6Q/eFXln6I/UnzU6
 uNPywSHLbBZMMZub1YA6iLdFROQLpb7R/fkeHp2sx0LOh1LezwyK8b9RGHm1SZgBBgV0hcuEYRTAQ
 merEyI+w6w69t8v9PstDfEANDQwcW54pT4F2pguMCpy3hjaFfoP4hfJjnowwZoEaPgkKVPELazSh7
 6MLj14ZI0IkhiXqV5kOdKJZhGS6aIbjkm7qAH2uiQ1ZhpJTCeJ83OSUkPpb8l4bDwSTNNn54WBzkn
 Xy0Vd/PJU5zw6BFXMmfy5bDA3dtZOsOmWEUwuKUFuf61CMwyRMl2Tf/PF4JJ6E7Tim/Qm4mru/2Bl
 SNgQBpHQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1j4SaX-0004DT-TU; Wed, 19 Feb 2020 16:52:41 +0000
Date: Wed, 19 Feb 2020 08:52:41 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH v6 08/19] mm: Add readahead address space operation
Message-ID: <20200219165241.GR24185@bombadil.infradead.org>
References: <20200217184613.19668-1-willy@infradead.org>
 <20200217184613.19668-14-willy@infradead.org>
 <20200219031044.GA1075@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219031044.GA1075@sol.localdomain>
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
 linux-mm@kvack.org, linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 ocfs2-devel@oss.oracle.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Feb 18, 2020 at 07:10:44PM -0800, Eric Biggers wrote:
> > +``readahead``
> > +	Called by the VM to read pages associated with the address_space
> > +	object.  The pages are consecutive in the page cache and are
> > +	locked.  The implementation should decrement the page refcount
> > +	after starting I/O on each page.  Usually the page will be
> > +	unlocked by the I/O completion handler.  If the function does
> > +	not attempt I/O on some pages, the caller will decrement the page
> > +	refcount and unlock the pages for you.	Set PageUptodate if the
> > +	I/O completes successfully.  Setting PageError on any page will
> > +	be ignored; simply unlock the page if an I/O error occurs.
> > +
> 
> This is unclear about how "not attempting I/O" works and how that affects who is
> responsible for putting and unlocking the pages.  How does the caller know which
> pages were not attempted?  Can any arbitrary subset of pages be not attempted,
> or just the last N pages?

Changed to:

``readahead``
        Called by the VM to read pages associated with the address_space
        object.  The pages are consecutive in the page cache and are
        locked.  The implementation should decrement the page refcount
        after starting I/O on each page.  Usually the page will be
        unlocked by the I/O completion handler.  If the filesystem decides
        to stop attempting I/O before reaching the end of the readahead
        window, it can simply return.  The caller will decrement the page
        refcount and unlock the remaining pages for you.  Set PageUptodate
        if the I/O completes successfully.  Setting PageError on any page
        will be ignored; simply unlock the page if an I/O error occurs.

